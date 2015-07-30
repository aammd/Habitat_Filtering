## Funtions for the analysis of the habitat-organism size experiment

#' Put all the organisms into a list
#' 
#' This function is a wrapper for a dplyr pipeline that merges block, 
#' bromeliad and taxa datasets, and configures them in a convenient way 
#' for both `adonis`and `mvabund`. outputs a list of length 2:
#'  first element is block and bromeliad variables
#'  second is a species matrix. 
#' 
#' @param .blocks blocks dataset
#' @param .bromeliad bromeliad datasets
#' @param .taxa the insect taxa to merge. This can vary.
#' @param .sampletime final or initial (or both) -- the sampling period.

TaxaTimeSelector <- function(.blocks, 
                             .bromeliad, 
                             .taxa,
                             sampletime) {
  which_blocks <- .blocks %>%
    filter(experiment == "threespp") %>%
    select(Block = block)
  
  which_broms <- .bromeliad %>%
    semi_join(which_blocks) %>%
    select(Brom, Block, species)
  
  which_taxa <- .taxa %>%
    filter(sampling == sampletime) %>%
    rename(Brom = bromeliad)
  
  brom_taxa <- which_taxa %>%
    filter(Spp != "none") %>%
    spread(Spp, abundance, fill = 0) %>% 
    left_join(which_broms, .) %>% 
    mutate(sampling = sampletime)# %>% ## cheating! NAs introduced in this factor are removed
    ## now only need to remove the NA values! could just get a vector of their names and na to 0
    
  brom_taxa[is.na(brom_taxa)] <- 0
    
  
  ###tests could go here
  brom_taxa %>% 
  {
    list(factors = select(., Block, species),
         taxa = select(., -Block, -Brom, -species, -sampling))
  }
}


BactTimeSelector <- function(.blocks = blocks, 
                             .bromeliad = bromeliad, 
                             .taxa,
                             sampletime = "final") {
  
  which_blocks <- .blocks %>%
    filter(experiment == "threespp") %>%
    select(Block = block)
  
  which_broms <- .bromeliad %>%
    semi_join(which_blocks) %>%
    select(Brom, Block, species)
  
  which_taxa <- .taxa %>%
    filter(sampling == sampletime) %>%
    select(-Block)
  
  brom_taxa <- left_join(which_taxa, which_broms)
  
  ###tests could go here
  brom_taxa %>% 
  {
    list(factors = select(., species),
         taxa = select(., starts_with("X")))
  }
}

## wrapper for filter that removes samples that failed to
## run (ie were NA in the data)
FilterNABacteriaRows <- function(data) {
  OKrows <- data %>%
    extract2("taxa") %>%
    select(starts_with("X")) %>%
    rowSums %>%
    is.na %>%
    not
  
  newfac <- filter(data$factors, OKrows)
  newtax <- filter(data$taxa, OKrows)
  list(factors = newfac, taxa = newtax)
}

## wrapper that lets us work over a list:
lapply_maker <- function(f, ...){
  function(x, ...) lapply(x, f, ...)
}

lapply_bact <- lapply_maker(BactTimeSelector)

lapply_meta <- lapply_maker(TaxaTimeSelector)

lapply_narow <- lapply_maker(FilterNABacteriaRows)

## combine all bacteria into one long data frame

bact_list_to_df <- function(bactlist){
  bactlist %>%
    # gather all columns that start with X (ie the "species") into one
    lapply(function(x) gather(x, key = sp, 
                              value = pres, 
                              starts_with("X"), convert = TRUE)) %>%
    rbind_all %>% 
    select(sampling, bromeliad = Brom, Spp = sp, abundance = pres)
}

## given a list of bacterial species, how many occur across blocks
count_common_spp <- . %>%
  filter(pres != 0) %>% 
  select(Block,sp) %>% 
  distinct %>% 
  group_by(sp) %>% 
  tally %>% 
  extract2("n")




TaxaTimeSelector_split <- function(.blocks, 
                             .bromeliad, 
                             .taxa,
                             sampletime) {
  which_blocks <- .blocks %>%
    filter(experiment == "threespp") %>%
    select(Block = block)
  
  which_broms <- .bromeliad %>%
    semi_join(which_blocks) %>%
    select(Brom, Block, species)
  
  which_taxa <- .taxa %>%
    filter(sampling == sampletime) %>%
    rename(Brom = bromeliad)
  
  brom_taxa <- left_join(which_broms, which_taxa) %>%
    spread(Spp, abundance, fill = 0)
  
  taxa_list <- split(brom_taxa, brom_taxa$Block)
  
  format_list <- function(dat){
    list(factors = select(dat, Block, species),
         taxa = select(dat, -Block, -Brom, -species, -sampling))
  }
  
  lapply(taxa_list, format_list)
  ###tests could go here
  
}

lapply_splitter <- lapply_maker(TaxaTimeSelector_split)
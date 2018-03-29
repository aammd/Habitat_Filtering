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
                             sampletime, 
                             .experiment = "threespp") {
  # get only one of the two experiments (all data is in the same csvs)
  which_blocks <- .blocks %>%
    filter(experiment == .experiment) %>%
    select(Block = block)
  
  # the bromeliads in these blocks are:
  which_broms <- .bromeliad %>%
    semi_join(which_blocks, by = "Block") %>%
    select(Brom, Block, species)
  
  # browser()
  
  # create a table with all the bromeliads from this block. Add "final" or
  # "initial" for each plant (depending on which is being selected). This is
  # necessary because sometimes no organisms were observed, but we still need to
  # know that a sample was collected
  which_broms_sampling <- which_broms %>% 
    modelr::data_grid(nesting(Brom, Block, species), sampling = sampletime) %>% 
    # this dataset should have exactly the following nrows: the number of blocks x 6 reps x (1 or 2 sample times)
    verify(nrow(.) == (nrow(which_blocks) * 6 * length(sampletime)))
  
  # get taxonomic observations for either initial or final (or.. both!)
  which_taxa <- .taxa %>%
    filter(sampling %in% sampletime) %>%
    rename(Brom = bromeliad)
  # note that this collects more taxa than needed! It gets all taxa, not just
  # the ones seen only in the plants being "selected".
  
  # converting data to wide format and adding bromeliads to it
  brom_taxa <- which_taxa %>%
    spread(Spp, abundance, fill = 0) %>% 
    left_join(which_broms_sampling, ., by = c("Brom", "sampling"))
  
  # this leaves a row of NA where there were no animals observed. first fill
  # that down, then edit all the cells
  
  brom_taxa_nafill <- brom_taxa %>% 
    # then check (later) to make sure this has not caused problems
    verify(sum(is.na(sampling)) == 0) %>% 
    # fill numeric columns with 0
    mutate_if(is.numeric, replace_na, replace = 0)
  
  # how many w/in block reps? depends on experiment:
  subreps <- c(threespp = 2, withinsp = 3)[.experiment]
  
  # browser()
  # there are 2 or 3 replicates per block:
  brom_taxa_nafill %>% group_by(sampling, Block, species) %>% tally %>% 
    verify(all(n == subreps))
  # there are 6 total in each block
  blocktotal <- brom_taxa_nafill %>% group_by(sampling, Block) %>% tally %>% 
    verify(all(n == 6))
  # so you can calculate the total number of observations (rows)
  rplants <- nrow(blocktotal) * 6
  
  # and confirm that the sampling matches (i.e. no 0s or NAs or other weird thing)
  if (length(sampletime) == 1) { brom_taxa_nafill %>% group_by(sampling) %>% tally %>% 
    verify(n == rplants)}
  
  outlist <- brom_taxa_nafill %>% 
  {
    list(factors = select(., Block, species, sampling),
         taxa = select(., -Block, -Brom, -species, -sampling))
  }
  
  zerocols <- colSums(outlist$taxa) == 0
  dropped_cols <- names(outlist$taxa)[zerocols]
  
  if (any(zerocols)) {
    message(sprintf("removing absent taxa %s", paste(dropped_cols, collapse = ", ")))
    outlist$taxa <- outlist$taxa[,!zerocols]
  }
  return(outlist)  
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

#' Rename Habitat column to species
#' 
#' For the within-species experiment this is essential, since "species" differences are basically between habitat.
#'
#' @param .bromeliad full bromliad data.frame
#'
#' @return a dataframe with "species" as "open" or "closed"
brom_within <- function(.bromeliad){
 .bromeliad %>% 
    select(-species) %>% 
    rename(species = Habitat) %>% 
    select(Brom, Block, species)
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

filter_block <- function(.blocks, bk) {
  dplyr::filter(.blocks, block == bk)
}


find_bact_singletons <- function(.bact_tts_fin){
  .bact_tts_fin %>% .[[2]] %>% colSums() %>% {. > 1} %>% which()
}

bact_nosingletons <- function(.bact_tts_fin){
  new_bacteria <- .bact_tts_fin
  singles <- find_bact_singletons(.bact_tts_fin)
  new_bacteria[[2]] <- .bact_tts_fin[[2]][,singles]
  new_bacteria
}


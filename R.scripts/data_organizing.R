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
  
  brom_taxa <- left_join(which_broms, which_taxa) %>%
    spread(Spp, abundance, fill = 0)
  
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



TaxaTimeSelector_ini <- partial(TaxaTimeSelector, 
                                .blocks = blocks, 
                                .bromeliad = bromeliad,
                                sampletime = "initial")

TaxaTimeSelector_fin <- partial(TaxaTimeSelector, 
                                  .blocks = blocks, 
                                  .bromeliad = bromeliad,
                                  sampletime = "final")

BactTimeSelector_ini <- partial(BactTimeSelector, 
                                .blocks = blocks, 
                                .bromeliad = bromeliad,
                                sampletime = "initial")

BactTimeSelector_fin <- partial(BactTimeSelector, 
                                  .blocks = blocks, 
                                  .bromeliad = bromeliad,
                                  sampletime = "final")

## wrapper for filter that removes samples that failed to
## run (ie were NA in the data)
FilterNABacteriaRows <- function(data) {
  filter(data,
         data %>% 
           select(starts_with("X")) %>%
           rowSums %>%
           is.na %>%
           not)
}


Select_bact_list_initial <- function(.blocks = blocks, .bromeliad = bromeliad,.bact_list = bact_list){
  lapply(.bact_list, BacteriaTimeSelector,  sampletime = "initial")
}

check_bact <- . %>% extract2(bactlist, .) %>% extract2(2)  %>% tbl_df %>% glimpse

check_fact <- . %>% extract2(bactlist, .) %>% extract2(1)  %>% tbl_df %>% glimpse

fix_zoop_initial <- function(.TaxaAbundances = list_initial){
  zerorows <- .TaxaAbundances[["zoops"]]$taxa %>%
    rowSums(na.rm = TRUE) %>%
    equals(0) %>%
    which
  
  .TaxaAbundances[["zoops"]] <- lapply(.TaxaAbundances[["zoops"]],
                                       function(data) data[-zerorows, ])
  
  class(.TaxaAbundances[["zoops"]]) <- "ExpAbd"
  
  .TaxaAbundances
}


InsectZooBactAbds <- function(sampletime = "initial", .insectlist = insectlist, 
                              .zooplist = zooplist, .bactlist = bactlist){
  
  ## list of abundances
  
  TaxaAbundances <- vector("list",length = 3)
  names(TaxaAbundances) <- c("insects","zoops","bacteria")
  TaxaAbundances[["insects"]]  <-  .insectlist
  TaxaAbundances[["zoops"]]  <-  .zooplist
  TaxaAbundances[["bacteria"]]  <-  .bactlist

  TaxaAbundances
}






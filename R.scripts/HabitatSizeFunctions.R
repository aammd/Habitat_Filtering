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

TaxaTimeSelector <- function(.blocks = blocks, 
                             .bromeliad = bromeliad, 
                             .taxa = insects_renamed,
                             sampletime = "final") {
  ## select blocks
  taxadata <- .blocks %>%
    filter(experiment == "threespp") %>%
    select(Block = block) %>%
    ## merge to bromeliad
    left_join(.bromeliad %>% 
                select(Brom, Block, species)) %>%
    # and add the animals
    left_join(.taxa %>%
                filter(sampling == sampletime) %>%
                spread(key = Spp, abundance, fill = 0) %>%
                mutate(Brom = bromeliad) %>%
                select(-bromeliad)
    ) %>%
    # set up a list object a la mvabund
    {
      list(factors = select(., Block, species),
           taxa = select(., -Block, -Brom, -species, -sampling))
    }
  
  ## set the class to a made-up thing, for use with 
  class(taxadata) <- "ExpAbd"
  taxadata
}



## runs `adonis` on the output of TaxaTimeSelector. Knows where to find species
## abundances.  Also defaults to setting strata as Block. For bacteria (which
## have to be analyzed separately) just set .strata to NULL

AdonisData <- function(Data, .strata = Data[[1]]$Block, ...){  
  adonis(Data[[2]] ~ species, data = Data[[1]], strata = .strata, ...)
}

## wrapper for filter that removes samples that failed to run (ie were NA in the data)
FilterNABacteriaRows <- function(data) {
  filter(data,data %>% 
           select(starts_with("X")) %>%
           rowSums %>%
           is.na %>%
           not)
}

BacteriaTimeSelector <- function(.bacteria_list_item,
                                 .blocks = blocks, .bromeliad = bromeliad, 
                                 sampletime = c("initial","final")){
    ## select blocks
    bact_data <- .blocks %>%
      filter(experiment=="threespp") %>%
      select(Block=block) %>%
      ## merge to bromeliad
      left_join(.bromeliad) %>%
      mutate(bromeliad=Brom) %>%
      select(-Brom) %>%
      # and add the animals
      ## note that for bacteria, they are joined in the opposite direction!
      left_join(.bacteria_list_item,
                .         # this dot essentially makes this a "right join".
      ) %>% 
      ## the following removes all rows with NAs.
      FilterNABacteriaRows %>%
      # and now we filter to keep initial, final or both:
      filter(sampling %in% sampletime) %>%
      # set up a list object , separating predictors (first) and response(second)
      (l(data ~ list(
        factors=data %>% select(Block,species,sampling),
        bacts=data %>% select(starts_with("X"))
      )))
    class(bact_data) <- "ExpAbd"
    bact_data
}

InsectZooBactAbds <- function(SampleTime = "initial"){
  
  ## list of abundances
  
  TaxaAbundances <- vector("list",length = 3)
  names(TaxaAbundances) <- c("insects","zoops","bacteria")
  TaxaAbundances[["insects"]]  <-  TaxaTimeSelector(sampletime = SampleTime)
  TaxaAbundances[["zoops"]]  <-  TaxaTimeSelector(.taxa = zoop_combined, sampletime = SampleTime)
  TaxaAbundances[["bacteria"]]  <-  lapply(bacteria_list, BacteriaTimeSelector, sampletime = SampleTime)
  
  if(SampleTime == "initial") {
    zerorows <- TaxaAbundances[["zoops"]]$taxa %>%
      rowSums(na.rm = TRUE) %>%
      equals(0) %>%
      which
    
    TaxaAbundances[["zoops"]] <- lapply(TaxaAbundances[["zoops"]],
                                        function(data) data[-zerorows, ])
    
    class(TaxaAbundances[["zoops"]]) <- "ExpAbd"
  }
  TaxaAbundances
}


## ... passes refinements of the `strata` argument to AdonisData, otherwise does nothing
## add a "testclass" argument, or perhaps a "logical test" arguement:
## if I go with testclass, must have a new class. 
CommunityAdonis <- function(data_list, testclass, fun, ...){  
  if(inherits(data_list, testclass)) {
    fun(data_list)
  } else {
    lapply(data_list, fun, ...)
  }
}
  
adonisValueExtract <- function(dat, RESP) dat[["aov.tab"]]["species",RESP]

runadonis <- function(x) lapply(x, CommunityAdonis, 
                                testclass = "ExpAbd", fun = AdonisData, .strata = NULL)

extractResp <- function(RESP = "R2") {
  function(adonisanswers) {
    lapply(adonisanswers, CommunityAdonis, testclass = "adonis", 
           function(x) adonisValueExtract(x, RESP))
  }
}




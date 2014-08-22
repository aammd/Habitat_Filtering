## file for analyzing the habitat experiment
## Andrew MacDonald, 2014


# packages ----------------------------------------------------------------

library(dplyr)
library(tidyr)
library(mvabund)
library(magrittr)
library(ggplot2)
library(lubridate)
library(vegan)
library(pander)

source("R.scripts/read_clean_data.R")

## Insects: PERMANOVA -----------------------------------------------------

TaxaTimeSelector <- function(.blocks = blocks, .bromeliad = bromeliad, 
                           .taxa = insects_renamed,
                           sampletime = "final") {
  ## select blocks
  .blocks %>%
    filter(experiment == "threespp") %>%
    select(Block = block) %>%
    ## merge to bromeliad
    left_join(.bromeliad %>% select(Brom, Block, species)) %>%
    # and add the animals
    left_join(.taxa %>%
                filter(sampling == sampletime) %>%
                spread(key = Spp, abundance, fill = 0) %>%
                mutate(Brom = bromeliad) %>%
                select(-bromeliad)
    ) %>%
    # set up a list object a la mvabund
    (l(data ~ {
      list(factors = data %>% 
             select(Block, species),
           insects = data %>% 
             select(-Block, -Brom, -species, -sampling))
    }))
 
}

AdonisData <- function(Data, ...){  
  adonis(Data[[2]] ~ species, data = Data[[1]], strata = Data[[1]]$Block, ...)
}

# final insects
insectfinal <- AdonisData(TaxaTimeSelector())

# inital insects
insectinitial <- AdonisData(TaxaTimeSelector(sampletime = "initial"))

inizoop <- TaxaTimeSelector(.taxa = zoop_combined, 
                 sampletime = "initial")

zerorows <- inizoop$insects %>%
  rowSums(na.rm = TRUE) %>%
  equals(0) %>%
  which
  
inizoop2 <- lapply(inizoop,function(data) data[-zerorows, ])

# initial zoop -- WON'T RUN
AdonisData(inizoop2, 
           method = "bray")

zf <- AdonisData(TaxaTimeSelector(.taxa = zoop_combined, 
                            sampletime = "final"), 
           method = "bray")

# Bacteria from threespp --------------------------------------------------

BacteriaTimeSelector <- function(.bacteria_list = bacteria_list,
                                 sampletime = c("initial","final")){
  
  plyr::llply(bacteria_list,function(BACTERIA){
    ## select blocks
    bact_data <- blocks %>%
      filter(experiment=="threespp") %>%
      select(Block=block) %>%
      ## merge to bromeliad
      left_join(bromeliad) %>%
      mutate(bromeliad=Brom) %>%
      select(-Brom) %>%
      # and add the animals
      ## note that for bacteria, they are joined in the opposite direction!
      left_join(BACTERIA,
                .         # this dot essentially makes this a "right join".
      ) %>% 
      ## the following is a kludgy way to remove NAs.
      (l(data ~ filter(data,!is.na(rowSums(select(data,starts_with("X"))))))) %>%
      # and now we filter to keep initial, final or both:
      filter(sampling %in% sampletime) %>%
      # set up a list object a la mvabund
      (l(data ~ {
        list(factors=data %>% select(Block,species,sampling),
             bacts=data %>% select(starts_with("X")))
      }
      ))
  })
}
  
  #bacteria_adonis_ready$Eccleson$bacts

bacteria_adonis_ready <- BacteriaTimeSelector()
lapply(bacteria_adonis_ready, function(Data, ...){  
  adonis(Data[[2]] ~ species*sampling, data = Data[[1]], ...)
})

bactlist_initial <- BacteriaTimeSelector(sampletime = "initial") %>%
  lapply(AdonisData)
  
bactlist_final <- BacteriaTimeSelector(sampletime = "final") %>%
  lapply(AdonisData)


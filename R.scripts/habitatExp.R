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
source("R.scripts/HabitatSizeFunctions.R")
## Insects: PERMANOVA -----------------------------------------------------

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


  #bacteria_adonis_ready$Eccleson$bacts


lapply(bacteria_list, BacteriaTimeSelector, sampletime = c("initial","final"))


bacteria_adonis_ready <- BacteriaTimeSelector()
lapply(bacteria_adonis_ready, function(Data, ...){  
  adonis(Data[[2]] ~ species*sampling, data = Data[[1]], ...)
})

bactlist_initial <- BacteriaTimeSelector(sampletime = "initial") %>%
  lapply(AdonisData)
  
bactlist_final <- BacteriaTimeSelector(sampletime = "final") %>%
  lapply(AdonisData)


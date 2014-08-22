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

# Inital insects
insect_initial <- AdonisData(TaxaTimeSelector(sampletime = "initial"))

# Final insects
insect_final <- AdonisData(TaxaTimeSelector())


# zooplankton: PERMANOVA --------------------------------------------------

# Initial zooplankton
inizoop <- TaxaTimeSelector(.taxa = zoop_combined, 
                 sampletime = "initial")

## this dataset requires some post-processing due to ugly data 
zerorows <- inizoop$taxa %>%
  rowSums(na.rm = TRUE) %>%
  equals(0) %>%
  which
  
zooplankton_initial <- lapply(inizoop,function(data) data[-zerorows, ]) %>%
  AdonisData(method = "bray")

zooplankton_final <- AdonisData(TaxaTimeSelector(.taxa = zoop_combined, 
                                                 sampletime = "final"), 
                                method = "bray")

bacteria_adonis_ready <- lapply(bacteria_list, BacteriaTimeSelector, sampletime = c("initial","final"))

# bacteria: PERMANOVA -----------------------------------------------------

bactlist_initial <- lapply(bacteria_list, BacteriaTimeSelector, sampletime = c("initial")) %>%
  lapply(AdonisData, .strata = NULL)
  
bactlist_final <- lapply(bacteria_list, BacteriaTimeSelector, sampletime = c("final")) %>%
  lapply(AdonisData, .strata = NULL)


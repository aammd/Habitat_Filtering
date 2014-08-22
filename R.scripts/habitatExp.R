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

abds_initial <- InsectZooBactAbds(SampleTime = "initial")

perm_initial <- CommunityAdonis(data_list = abds_initial)

abds_final <- InsectZooBactAbds(SampleTime = "final")

perm_final <- CommunityAdonis(data_list = abds_final)

str(perm_initial[[1]])




plotter("F.Model")

plotter("Pr(>F)")

plotter("R2")

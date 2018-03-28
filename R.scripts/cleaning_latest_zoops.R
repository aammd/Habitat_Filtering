# Data cleaning script 
# Reads in latest data and reorganizes it into something that can be archived


library(tidyverse)
library(readxl)
library(assertr)

block_sheets <- readxl::excel_sheets("raw-data/habitat_size_zoo (with 5 blocks).xlsx")

data_sheets <- discard(block_sheets, ~ . == "Sheet1")


sheet_rows <- data_sheets %>% 
  set_names(data_sheets) %>% 
  map(read_excel, path = "raw-data/habitat_size_zoo (with 5 blocks).xlsx", n_max = 12)

pluck_one <-  function(x) function(d) unlist(d[seq(x, length(d), by = 4)])

reshape_sheet <- function(sheet){
  sheet %>% 
    split(1:12) %>% 
    map(~ data_frame(sampling   = pluck_one(1)(.),
                     bromeliad  = pluck_one(2)(.),
                     species    = pluck_one(3)(.),
                     count      = pluck_one(4)(.))) %>% 
    bind_rows %>% 
    filter(rowSums(is.na(.)) < 4)
}

sheet_rows[1]

reshaped_sheets <- sheet_rows %>% 
  map(safely(reshape_sheet))

zoops <- reshaped_sheets %>% 
  map("result") %>% 
  bind_rows(.id = "block") %>% 
  # remove "zoo samples"
  mutate(block = stringr::str_replace(block, " zoo samples", ""),
         block = stringr::str_trim(block)) %>% 
  # make sure the spelling matches
  mutate(species = stringr::str_trim(species),
         species = stringr::str_replace(species, " ", "_")) %>% 
  mutate(count = as.integer(count)) %>% 
  rename(abundance = count, Spp = species)

write_csv(x = zoops, path = "raw-data/zooplankton_complete.csv")

# compare to the last one

oldzoops <- read_tsv("raw-data/zoop.txt")

anti_join(zoops, oldzoops) %>% View

anti_join(oldzoops, zoops) %>% View

# it is identical to the old data except for the presence of a few notes and things


# adding notes ------------------------------------------------------------

# Baker -- no notes
# Eccleson - no notes
# Davidson -- replace that 0 with "none"
zoops_spp <- zoops %>% 
  mutate(Spp = if_else(Spp == "0", "none", Spp))

# Tennant -- two mislabbelled samples can't be told apart

zoops_spp %>% filter(bromeliad %in% c("V11*", "V12*", "V11", "V12"))

# awww shit, make sure you changed this only for the Initial, or final, or whatever it was!

zoops_david_comment <- zoops_spp  %>% 
  mutate(bromeliad = if_else(bromeliad %in% c("V11*", "V11"), "V11/V12_1", bromeliad),
         bromeliad = if_else(bromeliad %in% c("V12*", "V12"), "V11/V12_2", bromeliad)) %>% 
  # verify that there are now no bromeliads with these problematic names
  verify(nrow(filter(., bromeliad %in% c("V11*", "V12*", "V11", "V12"))) == 0)


# Donna -- two samples were lost: N50 and N49. Not entirely sure what to fill in
# for these. I want to keep them in the data but fill them in with NA
zoops_david_comment %>% 
  filter(bromeliad %in% c("*N50", "*N49"))
# Pond -- N22 was lost

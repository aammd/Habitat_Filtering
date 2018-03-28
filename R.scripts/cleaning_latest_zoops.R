# Data cleaning script 
# Reads in latest data and reorganizes it into something that can be archived


library(tidyverse)
library(readxl)
library(assertr)
library(stringr)

block_sheets <- readxl::excel_sheets("raw-data/habitat_size_zoo (with 5 blocks).xlsx")

data_sheets <- discard(block_sheets, ~ . == "Sheet1")

# read all the data in
sheet_rows <- data_sheets %>% 
  set_names(data_sheets) %>% 
  map(read_excel, path = "raw-data/habitat_size_zoo (with 5 blocks).xlsx", n_max = 12)

# OK the data is written out sideways, such that every observation of the same
# variable is separated by four columns o.O 
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

# check one uncleaned dataset:
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
  rename(abundance = count, Spp = species) %>% 
  # "fill down" the "final" in the data -- where the block is Eccleson, the sampling just above is "final" and the bromeliad is the same..
  mutate(sampling = case_when(block == "Eccleson" & lag(sampling) == "final" & bromeliad == lag(bromeliad) ~ "final",
                              TRUE ~ sampling))

write_csv(x = zoops, path = "raw-data/zooplankton_complete.csv")

# compare to the last one

oldzoops <- read_tsv("raw-data/zoop.txt")

# This shows all the new data added compared to the previous observations:
anti_join(zoops, oldzoops) %>% View

# This shows possible PROBLEMS because they are present in the old but absent in the new.
anti_join(oldzoops, zoops) %>% View
# however not to worry! these only *appear* to be absent in the new -- they're
# there, but there are asterisks by the names. In the next section I'm going to
# clear out all these

# it is identical to the old data except for the presence of a few notes and things

# adding notes ------------------------------------------------------------

# Baker -- no notes
# Eccleson - no notes
# Davidson -- remove that 0

# identify the "0 species" row
zoops_zero <- zoops %>% 
  filter(Spp == "0")

# use a filtering join to make it go away
zoops_nozero <- zoops %>% 
  anti_join(zoops_zero) %>% 
  verify(nrow(.) == (nrow(zoops) - 1))

# doing this because != matches NAs too. Also not adding a "none" because I fear it would be thought a species later.

# Tennant -- two mislabbelled samples can't be told apart
# Fortunately we can figure it out: L41 and L46 in the bromeliad.volumes.txt file clearly show that only V11 was used, V12 was not involved in the experiment.

zoops_nozero %>% filter(bromeliad %in% c("V11*", "V12*", "V11", "V12"))
# Note that the asterisk was only in the first mention of the plant, but applies to all of them

zoops_david_comment <- zoops_nozero  %>% 
  mutate(bromeliad = if_else(bromeliad %in% c("V11*"), "V11", bromeliad),
         bromeliad = if_else(bromeliad %in% c("V12*", "V12"), "V11", bromeliad)) %>% 
  # verify that there are now no bromeliads with these problematic names
  verify(nrow(filter(., bromeliad %in% c("V11*", "V12*", "V12"))) == 0)


# Donna -- two samples were lost: N50 and N49. Not entirely sure what to fill in
# for these. I want to keep them in the data but fill them in with NA

# Look at the problematic samples:
zoops_david_comment %>% 
  filter(block == "Donna")

# OK so as far as I am concerned this is fine! the NA indicates that these are true missing values.
# just remove the asterisk

zoops_david_twoaster_gone <- zoops_david_comment %>% 
  mutate(bromeliad = if_else(bromeliad %in% c("*N50", "*N49"), str_replace(bromeliad, "\\*", ""), bromeliad))


  
# Pond -- N22 was lost. same procedure as above

zoops_pond_aster_gone <- zoops_david_twoaster_gone %>% 
  mutate(bromeliad = if_else(bromeliad %in% c("*N22"), str_replace(bromeliad, "\\*", ""), bromeliad))

# Apparently there were two samples with the same name?!
zoops_pond_aster_gone %>% 
  group_by(sampling, bromeliad, Spp) %>% 
  filter(n() == 2) %>% 
  arrange(bromeliad)
# ohhh shit. there are some observations that should be impossible! 


  
  mutate(duplicate_sample = seq_along(bromeliad)) %>% 
  filter(duplicate_sample > 1)
zoops_pond_aster_gone %>% 
  filter(grepl("\\*", bromeliad))

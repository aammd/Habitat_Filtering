library("readr")
library("dplyr")
library("magrittr")

broms <- read.delim("raw-data/bromeliad.volumes.txt", comment.char = "#",stringsAsFactors = FALSE)
head(broms)

broms %>% 
  filter(Block %in% c("SarahJane", "Martha", "Pond", "Donna", "Rose")) %>% 
  select(Block, Bromeliad = Brom) %>% 
  arrange(Block, Bromeliad) %>% 
  write_csv("data/second_experiment_blocks.csv")
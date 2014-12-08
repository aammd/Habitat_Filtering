## reading and combining the insect data
## Andrew MacDonald, Dec 2014s

library(dplyr)

insects <-   read.table("../data/insect.communities.table.txt",
                        header=TRUE,comment.char="#",stringsAsFactors=FALSE) %>% tbl_df()

insectnames <- read.csv(file = "../data/insectnames.csv") %>% tbl_df()

# renaming insects taxa ---------------------------------------------------

## correct variable spellings
insects_renamed <- insects %>%
  left_join(insectnames) %>%
  select(sampling, bromeliad, Spp = sp_name, abundance) %>%
  group_by(sampling, bromeliad, Spp) %>%
  summarise(abundance = sum(abundance))


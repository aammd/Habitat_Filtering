## reading and combining the insect data
## Andrew MacDonald, Dec 2014s

library(dplyr)

insects <-   read.table("../raw-data/insect.communities.table.txt",
                        header=TRUE, comment.char="#", stringsAsFactors=FALSE) %>% tbl_df()

insectnames <- read.csv(file = "../raw-data/insectnames.csv", stringsAsFactors=FALSE) %>% tbl_df()

# renaming insects taxa ---------------------------------------------------

## correct variable spellings
insects %>%
  left_join(insectnames) %>%
  select(sampling, bromeliad, Spp = sp_name, abundance) %>%
  group_by(sampling, bromeliad, Spp) %>%
  summarise(abundance = sum(abundance)) %>%
  as.data.frame %>%
  write.csv(file = "../data/inverts.csv", row.names = FALSE)


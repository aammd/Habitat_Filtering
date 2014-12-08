## reading and combining the zoop data
## Andrew MacDonald, Dec 2014

library(dplyr)

## read data
zoop <-  read.table("../raw-data/zoop.txt",
                    header=TRUE,comment.char="#",stringsAsFactors=FALSE) %>% tbl_df

# combining zooplankton ---------------------------------------------------

zoop %>%
  group_by(sampling, bromeliad, Spp) %>%
  summarise(abundance = sum(abundance)) %>%
  as.data.frame %>%
  write.csv(file = "../data/zoops.csv", row.names = FALSE)

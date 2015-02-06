## reading and combining the insect data
## Andrew MacDonald, Dec 2014

read_data <- function(dat) read.table(dat, header = TRUE, comment.char="#", stringsAsFactors=FALSE)

clean_insect_names <- function(community_data, name_data) {
  ## correct variable spellings
  community_data %>%
    left_join(name_data) %>%
    select(sampling, bromeliad, Spp = sp_name, abundance) %>%
    group_by(sampling, bromeliad, Spp) %>%
    summarise(abundance = sum(abundance)) %>%
    as.data.frame
}

## reading and combining the zoop data
## Andrew MacDonald, Dec 2014

## read data
clean_zooplankton <-  . %>% 
  read.table(header=TRUE,comment.char="#",stringsAsFactors=FALSE) %>% 
  tbl_df %>%
  group_by(sampling, bromeliad, Spp) %>%
  summarise(abundance = sum(abundance)) %>%
  as.data.frame

## script for cleaning and organising our data

read_bact_list <- function(dir = "raw-data/bacteria/"){
  dir %>%
    list.files(pattern="*.csv",
               full.names=TRUE) %>% 
    lapply(read.table,comment.char="#",
           header=TRUE,stringsAsFactors=FALSE,sep=",")
}

clean_bact2 <- . %>%
  separate(sample, c("Brom", "day", "month")) %>% 
  mutate(date = paste(day, month, "2013", sep = "-"),
         date = dmy(date),
         sampling = ifelse(date > mean(date), "final", "initial"))

clean_all_bact <- . %>% lapply(clean_bact2)
  
  ## go through this list, identify the block, and put the block names in a vector
  ## then set that vector as names for the list.
  plyr::laply(bacteria_list,function(DF,.bromeliad=bromeliad){
    DF %>%
      select(Brom=bromeliad) %>%
      left_join(.bromeliad) %>%
      extract2("Block") %>% unique
  }
  ) %>%
    set_names(bacteria_list,.)
}
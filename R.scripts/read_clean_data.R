## script for cleaning and organising our data

library(dplyr)

# read in data ------------------------------------------------------------

blocks <-
  read.table("../data/blocks.txt",header=TRUE,comment.char="#",
             stringsAsFactors=FALSE) %>% tbl_df()


zoop <-  read.table("../data/zoop.txt",
                    header=TRUE,comment.char="#",stringsAsFactors=FALSE) %>% tbl_df

bromeliad <-
  read.table("../data/bromeliad.volumes.txt",comment.char="#",
             header=TRUE,stringsAsFactors=FALSE) %>% tbl_df

bact <- list.files("../data/bacteria/",
                   pattern="*.csv",
                   full.names=TRUE) %>% 
  lapply(read.table,comment.char="#",
         header=TRUE,stringsAsFactors=FALSE,sep=",")


# combining zooplankton ---------------------------------------------------

zoop_combined <- zoop %>%
  group_by(sampling, bromeliad, Spp) %>%
  summarise(abundance = sum(abundance))

# rearrange bacteria ------------------------------------------------------

bacteria_list <- lapply(bact,function(DF) {
  
  plotdates <- do.call(rbind,strsplit(DF$sample,split=" "))
  
  samp.dates <- paste(apply(plotdates[,-1],1,paste,collapse="-"),"2013",sep="-")
  samp.dates <- dmy(samp.dates)
  
  duration <- (max(samp.dates)-samp.dates)<as.duration(259200)
  
  sampling <- c("initial","final")[duration+1]
  
  DF <- DF[,!names(DF)%in%c("sample")]
  
  DF <- plyr::rename(DF,c("Block"="block"))
  
  data.frame(bromeliad=plotdates[,1],sampling,DF,stringsAsFactors=FALSE) %>%
   # filter(sampling=="final") %>%
    select(-block)
}) 

## go through this list, identify the block, and put the block names in a vector
## then set that vector as names for the list.
bacteria_list <- plyr::laply(bacteria_list,function(DF,.bromeliad=bromeliad){
  DF %>%
    select(Brom=bromeliad) %>%
    left_join(.bromeliad) %>%
    extract2("Block") %>% unique
}
) %>%
  set_names(bacteria_list,.)
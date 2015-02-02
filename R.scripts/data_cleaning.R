## reading and combining the insect data
## Andrew MacDonald, Dec 2014

read_insects <- function(dat) read.table(dat, header = TRUE, comment.char="#", stringsAsFactors=FALSE)

clean_insect_names <- function(community_data, name_data, output) {
  ## correct variable spellings
  community_data %>%
    left_join(name_data) %>%
    select(sampling, bromeliad, Spp = sp_name, abundance) %>%
    group_by(sampling, bromeliad, Spp) %>%
    summarise(abundance = sum(abundance)) %>%
    as.data.frame %>%
    write.csv(file = output, row.names = FALSE)
}

## reading and combining the zoop data
## Andrew MacDonald, Dec 2014

## read data
clean_zooplankton <-  . %>% 
  read.table(header=TRUE,comment.char="#",stringsAsFactors=FALSE) %>% 
  tbl_df %>%
  group_by(sampling, bromeliad, Spp) %>%
  summarise(abundance = sum(abundance)) %>%
  as.data.frame %>%
  write.csv(file = "data/zoops.csv", row.names = FALSE)

## script for cleaning and organising our data

read_organize_bact <- function(bacteria_data, bromeliad_volumes, output){
  # read in data ------------------------------------------------------------
  
  bromeliad <-
    read.table(bromeliad_volumes,comment.char="#",
               header=TRUE,stringsAsFactors=FALSE) %>% tbl_df
  
  bact <- list.files(bacteria_data,
                     pattern="*.csv",
                     full.names=TRUE) %>% 
    lapply(read.table,comment.char="#",
           header=TRUE,stringsAsFactors=FALSE,sep=",")
  
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
  plyr::laply(bacteria_list,function(DF,.bromeliad=bromeliad){
    DF %>%
      select(Brom=bromeliad) %>%
      left_join(.bromeliad) %>%
      extract2("Block") %>% unique
  }
  ) %>%
    set_names(bacteria_list,.) %>%
    save(file = output)
}
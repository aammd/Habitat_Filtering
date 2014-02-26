## file for analyzing the habitat experiment
## Andrew MacDonald, 2014


# load packages -----------------------------------------------------------

library(reshape2)
library(grid)
library(ggplot2)
library(vegan)
library(igraph)

source("~/Dropbox/PhD/ibutton.functions/ibutton.functions.R")


# read in data ------------------------------------------------------------

blocks <-
  read.table("~/Dropbox/PhD/brazil2013/experiments/data/blocks.txt",header=TRUE,comment.char="#",
             stringsAsFactors=FALSE)


insects <-   read.table("~/Dropbox/PhD/brazil2013/experiments/data/insect.communities.table.txt",
  header=TRUE,comment.char="#",stringsAsFactors=FALSE)

zoop <-  read.table("~/Dropbox/PhD/brazil2013/experiments/data/zoop.txt",
                    header=TRUE,comment.char="#",stringsAsFactors=FALSE)

bromeliad <-
  read.table("~/Dropbox/PhD/brazil2013/experiments/data/bromeliad.volumes.txt",comment.char="#",
    header=TRUE,stringsAsFactors=FALSE)

## correct variable spellings
insects$spp[which(insects$spp=="leptagrion"|insects$spp=="Leptagrion")] <- "Leptagrion"

insects$spp[which(insects$spp%in%c("ostra","elpidium","elp"))] <-   "Elpidium"

insects$spp[which(insects$spp%in%c("diptera","Diptera"))] <-   "Diptera"

## not quite sure where to begin.

## basic first question: for each bromeliad, how did the densities of
## each species change?

## first identify which block belongs to each species

## need matrix with spp names as columns, first row density in
## homogenized, second row density in final.  maplot with a second
## vector of 1,2

## ok so this could be easily made from a dataframe that had only the
## data for one bromeliad and the homogenized community.

## first get a list of all the broms in the homogenized community



## need to get the right bromeliads together for the question
## keep it simple: one species.
select_bromeliads<-function(blockname,dataframe=insects){
  ## get the bromeliads in this block
  useful.broms<-bromeliad$Brom[bromeliad$Block%in%c(blockname)]

  ## collect *all* relevant insects
  sampled_community<-dataframe[dataframe$sampling%in%c("initial","final","homogenized")
                             &dataframe$bromeliad%in%c(useful.broms,blockname),]
  #sampled_community_cast<-cast(sampled_community,sampling+bromeliad~spp,fill=0)
  ## get their species
  # useful_brom_sp<-bromeliad$species[match(sampled_community_cast$bromeliad,bromeliad$Brom)]
  useful_brom_sp<-bromeliad$species[match(sampled_community$bromeliad,bromeliad$Brom)]
  # get their habitat
  useful_brom_hab<-bromeliad$Habitat[match(sampled_community$bromeliad,bromeliad$Brom)]
  ## the one missing value is actually the homogenized community
  useful_brom_sp[is.na(useful_brom_sp)]<-"homogenized"
  #browser()
  data.frame(block=blockname,brom_sp=useful_brom_sp,habitat=useful_brom_hab,sampled_community)
}

one_block_ordination<-function(cast_df){
  sampled_community_cast<-cast_df[,!names(cast_df)%in%c("brom_sp","block","sampling","bromeliad","habitat")]
  # CAs<-scores(cca(sampled_community_cast))[["sites"]]
  CAs<-metaMDS(vegdist(sampled_community_cast,distance="euclid"))[["points"]]
  CAs<-as.matrix(CAs)
  colnames(CAs)<-c("CA1","CA2")
  data.frame(cast_df[,names(cast_df)%in%c("block","sampling","brom_sp","bromeliad","habitat")],CAs)
}

## just do before and after
## permavoa - for the spread of the points.
## before and after for the same community!

## I want to redo the thing to check all bromeliads simultaneously
newer_plot_select_blocks<-function(block_vector=c("Baker","Davidson","Eccleson","Tennant","Smith")){
  selected_broms<-lapply(block_vector,select_bromeliads)
  newtest<-do.call(rbind,selected_broms)
  ## cast spp into columns:
  sampled_community_cast<-cast(newtest,sampling+bromeliad+brom_sp+block~spp,value="abundance",fill=0)
  ordinated_bromeliads<-one_block_ordination(sampled_community_cast)
  wide_broms<-reshape(ordinated_bromeliads,v.names=c("CA1","CA2"),
                      timevar="sampling",direction='wide',idvar="bromeliad")
  
  ## need to fill in the homogenized values:
  
  starting_points<-wide_broms[wide_broms$brom_sp=="homogenized",c("block","CA1.homogenized","CA2.homogenized")]
  
  ## remove homogenized from original and organize
  reshaped_broms<-merge(starting_points,wide_broms[,!names(wide_broms)%in%c("CA1.homogenized","CA2.homogenized")],by="block")
  reshaped_broms2<-reshaped_broms[reshaped_broms$brom_sp!="homogenized",]
  reshaped_broms_hull<-with(reshaped_broms2,convex.hull(cbind(CA1.initial,CA2.initial)))
  #browser()
  ggplot(data=reshaped_broms2,aes(x=CA1.homogenized,xend=CA1.final,y=CA2.homogenized,yend=CA2.final,
                                  colour=brom_sp))+
    geom_segment(arrow=arrow(length=unit(0.2,"cm")))+
    geom_point(aes(colour="homogenized"))+xlab("axis1")+ylab("axis2")+geom_point(aes(x=CA1.initial,y=CA2.initial))+
    scale_colour_brewer(type="div",palette=5)+labs(colour="")
}


## I want to redo the thing to check all bromeliads simultaneously
plot_select_blocks_arrow<-function(block_vector=c("Baker","Davidson","Eccleson","Tennant","Smith"),Dataframe=insects){
  
  selected_broms<-lapply(block_vector,select_bromeliads,dataframe=Dataframe)
  newtest<-do.call(rbind,selected_broms)
  
  sampled_community_cast<-cast(newtest,sampling+bromeliad+brom_sp+habitat+block~spp,value="abundance",fill=0,fun.aggregate=sum)
  
  ## ordination
  ordinated_bromeliads<-one_block_ordination(sampled_community_cast)
  
  ## melt these ordinated data
  meltbrom <- melt(ordinated_bromeliads)
  
#   ## split the melted ordinations by sampling date, and then cast the two CA axes into columns:
#   test <- ddply(meltbrom,.(sampling),dcast,formula=block+brom_sp+bromeliad+habitat~variable)
#   
  
  ##because we need to separate the CA1 and 2 for each time period (in order to draw arrows) we first must combine these vectors:
  melt_with_combined_columns <- transform(meltbrom,newvar=apply(cbind(as.character(variable),sampling),1,paste,collapse="."))
  
 # now cast this back into columns:
  
  out <- dcast(melt_with_combined_columns,formula=block+brom_sp+bromeliad+habitat~newvar)

  ## remove habitat
  out2 <- out[,!names(out)%in%c("habitat")]
  
  ## select out homos
  homogen <- out2[,names(out2)%in%c("bromeliad","CA1.homogenized","CA2.homogenized")]
  ## remove NA rows
  homogen <- homogen[complete.cases(homogen),]
  ## rename bromeliad to block:
  homogen <- rename(homogen,replace=c("bromeliad"="block"))
  
  ## select just the other rows:
  not_homogen <- out2[,!names(out2)%in%c("CA1.homogenized","CA2.homogenized")]
  ## remove NA rows
  not_homogen <- not_homogen[complete.cases(not_homogen),]
  not_homogen$block <- as.character(not_homogen$block)
  
  ## now merge `block` in not_homogen to `bromeliad` in homogen (renamed above):
  join(homogen,not_homogen,by="block",type="full")
  
#   ## dataframe with only the original samples
#   first <- dcast(subset(meltbrom,sampling=="initial"),formula=block+brom_sp+bromeliad+habitat~variable)
#   ## with the homogenized samples
#   homo <- dcast(subset(meltbrom,sampling=="homogenized"),formula=block+brom_sp+bromeliad+habitat~variable)
#   ## the arrows are trickier: they require a merge:
#   final <- dcast(subset(meltbrom,sampling=="final"),formula=block+brom_sp+bromeliad+habitat~variable)
  
#   arrows <- merge(homo,final,by="block",suffixes=c(".homo",".final"))
#   
#   out <- list(first,homo,arrows)
#   names(out) <- c("first","homo","arrows")
#   out
#   ggplot(data=first,aes(x=CA1,y=CA2,colour=brom_sp))+geom_point()+geom_point(data=homo)+geom_segment(data=arrows,aes(x=CA1.homo,xend=CA1.final,y=CA2.homo,yend=CA2.final,colour=brom_sp.final),arrow=arrow(length=unit(0.2,"cm")))

}





## read and work with ibutton data
ibutton_data<-read.ibutton.folder("/home/andrew/Dropbox/PhD/brazil2013/experiments/data/ibuttons/SarahJane/")
sarahjane<-ibuttons.to.data.frame(ibutton_data)

## later I'm going to make this combine nicely with the main dataset.\


## just for quick right now:
habitats<-data.frame(ibutton=c(24,23,25,42,28,30),
  habitat=rep(c("open","closed"),c(3,3)))

sarahjane<-merge(habitats,sarahjane,by="ibutton")




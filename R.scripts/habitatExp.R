## file for analyzing the habitat experiment
## Andrew MacDonald, 2014

library(reshape)
library(grid)
library(ggplot2)
library(vegan)
library(igraph)
source("/home/andrew/Dropbox/PhD/ibutton.functions/ibutton.functions.R")

blocks <-
  read.table("~/Dropbox/PhD/brazil2013/experiments/data/blocks.txt",header=TRUE,comment.char="#",
             stringsAsFactors=FALSE)


insects <-   read.table("~/Dropbox/PhD/brazil2013/experiments/data/insect.communities.table.txt",
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
select_bromeliads<-function(blockname){
  ## get the bromeliads in this block
  useful.broms<-bromeliad$Brom[bromeliad$Block%in%c(blockname)]

  ## collect *all* relevant insects
  sampled_community<-insects[insects$sampling%in%c("initial","final","homogenized")
                             &insects$bromeliad%in%c(useful.broms,blockname),]
  #sampled_community_cast<-cast(sampled_community,sampling+bromeliad~spp,fill=0)
  ## get their species
  # useful_brom_sp<-bromeliad$species[match(sampled_community_cast$bromeliad,bromeliad$Brom)]
  useful_brom_sp<-bromeliad$species[match(sampled_community$bromeliad,bromeliad$Brom)]
  ## the one missing value is actually the homogenized community
  useful_brom_sp[is.na(useful_brom_sp)]<-"homogenized"
  #browser()
  data.frame(block=blockname,brom_sp=useful_brom_sp,sampled_community)
}

one_block_ordination<-function(cast_df){
  sampled_community_cast<-cast_df[,!names(cast_df)%in%c("brom_sp","block","sampling","bromeliad")]
  # CAs<-scores(cca(sampled_community_cast))[["sites"]]
  CAs<-metaMDS(vegdist(sampled_community_cast,distance="euclid"))[["points"]]
  CAs<-as.matrix(CAs)
  colnames(CAs)<-c("CA1","CA2")
  data.frame(cast_df[,names(cast_df)%in%c("block","sampling","brom_sp","bromeliad")],CAs)
}


plot_select_blocks<-function(block_vector=c("Baker","Davidson","Eccleson","Tennant","Smith")){
selected_broms<-lapply(block_vector,select_bromeliads)
ordinated_bromeliads<-do.call(rbind,lapply(selected_broms,one_block_ordination))

wide_broms<-reshape(ordinated_bromeliads,v.names=c("CA1","CA2"),
  timevar="sampling",direction='wide',idvar="bromeliad")

## need to fill in the homogenized values:

starting_points<-wide_broms[wide_broms$brom_sp=="homogenized",c("block","CA1.homogenized","CA2.homogenized")]

## remove homogenized from original and organize
reshaped_broms<-merge(starting_points,wide_broms[,!names(wide_broms)%in%c("CA1.homogenized","CA2.homogenized")],by="block")
browser()
ggplot(data=reshaped_broms,aes(x=CA1.homogenized,xend=CA1.final,y=CA2.homogenized,yend=CA2.final,colour=brom_sp))+geom_segment(arrow=arrow(length=unit(0.2,"cm")))+
    geom_point()+xlab("CA1")+ylab("CA2")+geom_point(aes(x=CA1.initial,y=CA2.initial))+theme_bw()+
    scale_colour_brewer(type="div",palette=5)+opts(legend.position="top")+labs(colour="")


}

## I want to redo the thing to check all bromeliads simultaneously
newer_plot_select_blocks<-function(block_vector=c("Baker","Davidson","Eccleson","Tennant","Smith")){
selected_broms<-lapply(block_vector,select_bromeliads)
newtest<-do.call(rbind,selected_broms)

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



ibutton_data<-read.ibutton.folder("/home/andrew/Dropbox/PhD/brazil2013/experiments/data/ibuttons/SarahJane/")
sarahjane<-ibuttons.to.data.frame(ibutton_data)

## later I'm going to make this combine nicely with the main dataset.
## just for quick right now:
habitats<-data.frame(ibutton=c(24,23,25,42,28,30),
  habitat=rep(c("open","closed"),c(3,3)))

sarahjane<-merge(habitats,sarahjane,by="ibutton")






plot.all.six.broms <- function(plotname){
  ## list bromeliads in one block
  block.bromeliads <- bromeliad[bromeliad$Block==plotname,"Brom"]
  
  ## combine with starting community
  insects.before.after <- rbind(insects[insects$sampling=="homogenized"&
                                        insects$bromeliad==plotname,],
                                insects[insects$sampling=="final"&
                                        insects$bromeliad%in%block.bromeliads,])
  
  ## cast insects into columns
  insects.columns.before.after <- cast(data=insects.before.after,formula=bromeliad~spp,value="abundance",fill=0)
#  browser()
  ## make a nice plot
  par(mfrow=c(4,2),oma=c(0,0,2,0),
      mar=c(5, 4, 4, 2)/2 + 0.1)
  startpoint <-
  which(insects.columns.before.after$bromeliad==plotname)
  n.insects <- ncol(insects.columns.before.after)-1
  plot(0,0,type='n',axes=FALSE)
  legend(x='right',legend=names(insects.columns.before.after)[-1],
         lty=1:n.insects,col=1:n.insects,bty='n',ncol=3)
  plot(0,0,type='n',axes=FALSE)
  for (i in sort(block.bromeliads)){
    endpoint <- which(insects.columns.before.after$bromeliad==i)
    ##    browser()
    maxabds <-
      apply(insects.columns.before.after[c(startpoint,endpoint),-1],1,max)
    xpts <- barplot(maxabds,names=c("start","final"),col=NA,border=NA,
                    width=0.3,main=i,ylab='abundance')
    matlines(x=xpts,insects.columns.before.after[c(startpoint,endpoint),-1],
             type='l',lty=1:n.insects,col=1:n.insects)

  }
  
}

# pdf("../figures/block.pdf")
# lapply(c("Baker","Davidson","Eccleson","Tennant","Smith"),plot.all.six.broms)
# dev.off()
## repeat this over all 5 blocks

## next we need a stripplot (made through beanplot!?) which wiill have
## insect names on x asis and change from original homogenized
## community on the y-axis (so lots of up and down).  this y axis
## could even be scaled by % change to give all complete mortality a
## common place.  that might be better.


## formula for percent change is something like
## (final-starting)/starting. This should be done for EACH bromeliad:

change.by.block <- function(blockname){
## first get the final communities:
  final.comm <- insects[
                        (insects$bromeliad%in%
                         bromeliad[bromeliad$Block==blockname,"Brom"]|
                         insects$bromeliad==blockname)&
                        insects$sampling!="initial",]
  
  ## as above, cast
  all.spp.abds <-
    cast(data=final.comm,formula=bromeliad~spp,value="abundance",fill=0)

  ## get the starting one:
  starting <- which(all.spp.abds$bromeliad==blockname)
  
  ## remove this row from the data:
  starting.comm <- all.spp.abds[starting,-1]
  only.final.bromeliads <- all.spp.abds[-c(starting),]
  
  starting.matrix <- as.matrix(starting.comm)
  final.matrix <- as.matrix(only.final.bromeliads[,-1])
  
  starting.matrix.repeat <- t(replicate(6,starting.matrix,simplify='matrix'))
  changematrix <- (final.matrix-starting.matrix.repeat)
  ## there is a strange thing with the cast command used to create
  ## all.spp.abds.
  changematrix <- as.matrix(changematrix)
  ## stick on names and bromeliads again
  dimnames(changematrix)[[2]] <- names(starting.comm)
  dataframe.change <- cbind(brom=only.final.bromeliads[,1],data.frame(changematrix))
  ## melt
  
  melt(dataframe.change,measure.vars=names(dataframe.change)[-1])
  ## repeat for all blocks
}


# species.list.changes <- do.call(rbind,lapply(c("Baker","Davidson","Eccleson","Tennant","Smith"),change.by.block))

# ## rbind

# ## split by species

# differences.same.species <- lapply(unique(bromeliad$species),function(b){
#   same.spp.bromeliad <- bromeliad[bromeliad$species==b,"Brom"]
#   species.list.changes[species.list.changes$brom%in%same.spp.bromeliad,]
# }
#   )

# names(differences.same.species) <- unique(bromeliad$species)
  

# ## for each species, beanplot

# library(beanplot)

# pdf("../figures/species.changes.pdf")
# for(spp in 1:3){
#   par(oma=c(0,5,0,0))
#   with(differences.same.species[[spp]],
#        stripchart(value~variable,las=1,pch="|",
#                   main=names(differences.same.species)[spp],
#                   xlab="size relative to homogenized community")
#        )
# }
# dev.off()

# ## 2nd experiment

# bromeliad[42:nrow(bromeliad),c("max.vol","Habitat")]

# ## unused ones.
# bromeliad <- bromeliad[is.na(bromeliad$Block),]

# twohab.list <-
#   split(bromeliad[,c("max.vol")],bromeliad[,c("Habitat")])

# twohab.list <- lapply(twohab.list,function(x) x[!is.na(x)])


# threesample <- replicate(50,do.call(c,lapply(twohab.list,function(x) sample(x,3))))

# selected <- threesample[,which.min(apply(threesample,2,sd))]

# bromeliad[bromeliad$max.vol%in%selected,]

# expBlock <-
#   insects[insects$bromeliad%in%c("N48","N35","N52","N20","N22","N51"),]

# with(expBlock,table(spp,bromeliad)) ## should all be 1

# floor(tapply(expBlock$abundance,expBlock$spp,mean,na.rm=TRUE)
#       )


# tapply(expBlock$abundance,expBlock$spp,mean,na.rm=TRUE)
# tapply(expBlock$abundance,expBlock$spp,length)


# cast.expBlock <- cast(data=expBlock,formula=bromeliad~spp,value='abundance',fill=0)

# colMeans(as.data.frame(cast.expBlock[,-1]))
# round(tapply(expBlock$abundance,expBlock$spp,sum)/6)

# head(expBlock)

## file for analyzing the habitat experiment
## Andrew MacDonald, 2014

library(reshape)


blocks <-
  read.table("../data/blocks.txt",header=TRUE,comment.char="#",
             stringsAsFactors=FALSE)


insects <-
  read.table("../data/insect.communities.txt",header=TRUE,comment.char="#",
             stringsAsFactors=FALSE)

bromeliad <-
  read.table("../data/bromeliad.volumes.txt",comment.char="#",header=TRUE,
             stringsAsFactors=FALSE)

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
  title(main=plotname,outer=TRUE)
  
}

pdf("../figures/block.pdf")
lapply(c("Baker","Davidson","Eccleson","Tennant","Smith"),plot.all.six.broms)
dev.off()
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


species.list.changes <- do.call(rbind,lapply(c("Baker","Davidson","Eccleson","Tennant","Smith"),change.by.block))

## rbind

## split by species

differences.same.species <- lapply(unique(bromeliad$species),function(b){
  same.spp.bromeliad <- bromeliad[bromeliad$species==b,"Brom"]
  species.list.changes[species.list.changes$brom%in%same.spp.bromeliad,]
}
  )

names(differences.same.species) <- unique(bromeliad$species)
  

## for each species, beanplot

library(beanplot)

pdf("../figures/species.changes.pdf")
for(spp in 1:3){
  par(oma=c(0,5,0,0))
  with(differences.same.species[[spp]],
       stripchart(value~variable,las=1,pch="|",
                  main=names(differences.same.species)[spp],
                  xlab="size relative to homogenized community")
       )
}
dev.off()

## 2nd experiment

bromeliad[42:nrow(bromeliad),c("max.vol","Habitat")]

## unused ones.
bromeliad <- bromeliad[is.na(bromeliad$Block),]

twohab.list <-
  split(bromeliad[,c("max.vol")],bromeliad[,c("Habitat")])

twohab.list <- lapply(twohab.list,function(x) x[!is.na(x)])


threesample <- replicate(50,do.call(c,lapply(twohab.list,function(x) sample(x,3))))

threesample[,which.min(apply(threesample,2,sd))]


Rose <-
  insects[insects$bromeliad%in%c("N40","N38","N39","N37","N34","N36"),]

with(Rose,table(spp,bromeliad)) ## should all be 1

floor(tapply(Rose$abundance,Rose$spp,mean))


cast.rose <- cast(data=Rose,formula=bromeliad~spp,value='abundance')

colMeans(as.data.frame(recase.rose[,-1]))

head(Rose)

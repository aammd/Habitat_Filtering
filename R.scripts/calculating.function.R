
## this function calculates one experimental block for the
## habitat-effect experiment. 
calculate.block <- function(filename){
  insects <- read.csv("../data/habitat.experiment.insects.csv",
                      stringsAsFactors=FALSE,row.names=1)
  volumes <- read.csv("../data/habitat.experiment.volume.csv",
                      stringsAsFactors=FALSE)
  
  ## remove "unavailable" plants
  
  volumes <- volumes[volumes$Available=="Y",]
  
  ## split by species

  vol.list <- split(volumes,volumes$species)
  
  ## pick two brom at random
  rand.broms <- lapply(vol.list,function(x) x[sample(1:nrow(x),2,replace=FALSE),])

  ## what are the insects in these?
  chosen.brom.names <- do.call(what=c,args=sapply(rand.broms,"[",i="Brom"))
  
  ## how much water do they have?
  volumes.chosen.broms <- volumes[volumes$Brom%in%chosen.brom.names,"max.vol"]
  total.water <- sum(volumes.chosen.broms)
  ## about how much of that water does each plant get? -- assuming 50
  ## ml/plant and 6 plants!!!!!!
  new.block <- cbind(volumes[volumes$Brom%in%chosen.brom.names,],
                   prop.water=round(volumes.chosen.broms/total.water,digits=3))
  
  new.block <- cbind(new.block,ml.water=300*new.block$prop.water)
  
  ## how many insects are in all of these?
  
                                        #head(insects)
  
  insect.abd.all.six <-
    rowSums(insects[,names(insects)%in%chosen.brom.names])
  
  ##relative proportion of water in each plant
  prop.water.name <- new.block$prop.water
  names(prop.water.name) <- new.block$Brom
  
  ## multiply these proportions by the abundances of insects in each treatment.
  densities <- round(prop.water.name%o%insect.abd.all.six,digits=1)
  
  block <- cbind(new.block,densities[,colSums(densities)!=0])
  
  write.csv(block,file=paste0("../data/experimental.blocks/",filename),
            row.names=FALSE)
}

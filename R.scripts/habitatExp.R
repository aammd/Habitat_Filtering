## file for analyzing the habitat experiment
## Andrew MacDonald, 2014


## read and work with ibutton data
ibutton_data<-read.ibutton.folder("/home/andrew/Dropbox/PhD/brazil2013/experiments/data/ibuttons/SarahJane/")
sarahjane<-ibuttons.to.data.frame(ibutton_data)

## later I'm going to make this combine nicely with the main dataset.\


## just for quick right now:
habitats<-data.frame(ibutton=c(24,23,25,42,28,30),
  habitat=rep(c("open","closed"),c(3,3)))

sarahjane<-merge(habitats,sarahjane,by="ibutton")


## file for analyzing the habitat experiment
## Andrew MacDonald, 2014

blocks <-
  read.table("../data/blocks.txt",header=TRUE,comment.char="#")


insects <-
  read.table("../data/insect.communities.txt",header=TRUE,comment.char="#")

bromeliad <-
  read.table("../data/bromeliad.volumes.txt",comment.char="#",header=TRUE)

head(bromeliad)

## not quite sure where to begin.


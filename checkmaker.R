
library(remake)


ls() # nothing
m <- remake(envir=.GlobalEnv)
ls() # all your things!

## running the analyses

## runs `adonis` on the output of TaxaTimeSelector. Knows
## where to find species abundances.  Also defaults to
## setting strata as Block. For bacteria (which have to be
## analyzed separately) just set .strata to NULL

AdonisData <- function(Data, .strata = Data[[1]]$Block, ...){  
  adonis(Data[[2]] ~ species, data = Data[[1]], strata = .strata, ...)
}

## ... passes refinements of the `strata` argument to AdonisData, otherwise does nothing
## add a "testclass" argument, or perhaps a "logical test" arguement:
## if I go with testclass, must have a new class. 
CommunityAdonis <- function(data_list, testclass, fun, ...){  
  if(inherits(data_list, testclass)) {
    fun(data_list)
  } else {
    lapply(data_list, CommunityAdonis, testclass, fun, ...)
  }
}

runadonis <- partial(CommunityAdonis, testclass = "ExpAbd", 
                     fun = AdonisData, .strata = NULL)


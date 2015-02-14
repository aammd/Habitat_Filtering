## running the analyses

## runs `adonis` on the output of TaxaTimeSelector. Knows
## where to find species abundances.  Also defaults to
## setting strata as Block. For bacteria (which have to be
## analyzed separately) just set .strata to NULL

AdonisData <- function(Data, .strata = Data[["factors"]]$Block, ...){  
  adonis(Data[["taxa"]] ~ species, data = Data[["factors"]], strata = .strata, ...)
}

lapply_adonis <- lapply_maker(AdonisData)

run_manyglm2 <- function(data_list, glm_family = "poisson"){  
  #' call mvabund on responses
  responses <- data_list %>% 
    extract2("taxa") %>%
    mvabund
  
  ## run glm
  insect_glm_interact <- data_list %>% 
    extract2("factors") %>% 
    data.frame %>% 
    manyglm(responses ~ Block * species, data = ., family = glm_family)
}

lapply_manyglm <- lapply_maker(run_manyglm2)

## ... passes refinements of the `strata` argument to AdonisData, otherwise does nothing
## add a "testclass" argument, or perhaps a "logical test" arguement:
## if I go with testclass, must have a new class. 
CommunityAdonis <- function(data_list, testclass, fun, ...){  
  if(inherits(data_list, testclass)) {
    fun(data_list)
  } else {
    ## if we go down to this level, there is a nested list -- i.e.,  bacteria
    lapply(data_list, CommunityAdonis, testclass, fun, .strata = NULL, ...)
  }
}

runadonis <- partial(CommunityAdonis, testclass = "ExpAbd", 
                     fun = AdonisData, .strata = NULL)


## running the analyses
library("pryr")
## runs `adonis` on the output of TaxaTimeSelector. Knows
## where to find species abundances.  Also defaults to
## setting strata as Block. For bacteria (which have to be
## analyzed separately) just set .strata to NULL

AdonisData <- function(Data, .strata = Data[["factors"]]$Block, ...){  
  adonis(Data[["taxa"]] ~ species, data = Data[["factors"]], strata = .strata, ...)
}

lapply_adonis <- lapply_maker(AdonisData)

lapply_adonis_noNA <- . %>%
  lapply_narow %>% 
  lapply_adonis

run_manyglm <- function(data_list, glm_family = "poisson", .formula){  
  #' call mvabund on responses
  responses <- data_list %>% 
    extract2("taxa") %>%
    mvabund
  
  f <- as.formula(.formula)
  
  ## run glm
  data_list %>% 
    extract2("factors") %>% 
    data.frame %>% 
    manyglm(f, data = ., family = glm_family)
}

lapply_manyglm <- lapply_maker(run_manyglm)



result_df <- function(result_list, intolist = c("grp", "time", "tech")){
  
  outs <- vector(mode = "list", length = 4L)
  
  for(i in 1:4){
    outs[[i]] <- data_frame(result = result_list[[i]]) %>% 
      mutate(dataset = names(result_list[[i]]),
             samp = names(result_list)[i])
  }
  
  outs %>% 
    rbind_all %>% 
    separate(samp, into = intolist)
}


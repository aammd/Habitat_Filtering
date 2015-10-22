## look for block interaction
anova(inverts_manyglm_fin, inverts_manyglm_fin_add)

## type III sums of squares:

## function to run block and species:block
run_manyglm_no_main_sp <- function(data_list, glm_family = "negative.binomial"){  
  #' call mvabund on responses
  responses <- data_list %>% 
    extract2("taxa") %>% 
    as.matrix
  # browser()
  ## run glm
  data_list %>% 
    extract2("factors") %>% 
    data.frame %>% 
    manyglm(responses ~ Block, data = ., family = glm_family)
}

inverts_manyglm_nomain <- run_manyglm_no_main_sp(inverts_tts_fin, glm_family = I("negative.binomial"))

full <- anova(inverts_manyglm_fin, inverts_manyglm_nomain, nBoot = 100)

## z

zoops_manyglm_nomain <- run_manyglm_no_main_sp(zoops_tts_fin, glm_family = I("negative.binomial"))

full <- anova(inverts_manyglm_fin, zoops_manyglm_nomain, nBoot = 100)


## run and report the manyglm results
# insects in threespp experiment ------------------------------------------

## mvabund approach
run_manyglm <- function(data_list, glm_family = "negative.binomial"){  
  #' call mvabund on responses
  responses <- data_list %>% 
    extract2("taxa") %>% 
    as.matrix
  # browser()
  ## run glm
  data_list %>% 
    extract2("factors") %>% 
    data.frame %>% 
    manyglm(responses ~ Block * species, data = ., family = glm_family)
}


make_summary <- function(manyglm_output, .resamp = "pit.trap", .nboot = 1000){
  summary(manyglm_output, resamp = .resamp, nBoot = .nboot)
}

manyglm_anova <- function(manyglm_output,
                          .resamp = "pit.trap", .nboot = 1000){
  anova(manyglm_output, resamp = .resamp,
        p.uni = "adjusted", show.time = "all", nBoot = .nboot)
}
  
get_model_stats <- function(anova_output){
  
  insect_statistic <- anova_output %>%
    extract2("uni.test") %>% 
    t %>% 
    data.frame %>% 
    select(-X.Intercept.,
           Block_wald = Block,
           species_wald = species,
           Block.species_wald = Block.species) %>%
    add_rownames()
  
  insect_sig <- anova_output %>%
    extract2("uni.p") %>%
    t %>% 
    data.frame %>% 
    select(-X.Intercept.,
           Block_p = Block,
           species_p = species,
           Block.species_p = Block.species) %>%
    add_rownames() %>%
    set_rownames(NULL)
  
  left_join(insect_sig, insect_statistic, by = "rowname")
}

### modified for additive model ####


run_manyglm_add <- function(data_list, glm_family = "negative.binomial"){  
  #' call mvabund on responses
  responses <- data_list %>% 
    extract2("taxa") %>% 
    as.matrix
  # browser()
  ## run glm
  data_list %>% 
    extract2("factors") %>% 
    data.frame %>% 
    manyglm(responses ~ Block + species, data = ., family = glm_family)
}

## fits the block effect only
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

### null model
run_manyglm_null <- function(data_list, glm_family = "negative.binomial"){  
  #' call mvabund on responses
  responses <- data_list %>% 
    extract2("taxa") %>% 
    as.matrix
  # browser()
  ## run glm
  data_list %>% 
    extract2("factors") %>% 
    data.frame %>% 
    manyglm(responses ~ 1, data = ., family = glm_family)
}



## info extraction functions
## calculate percent deviance
manyglm_get_table <- function(.manyglm_anova_result){
  devtable <- .manyglm_anova_result$table
  add_rownames(devtable, var = "term")
}

percent_dev_sp <- function(.manyglm_df){
  ## find species
  whersp <- grepl("sp", .manyglm_df$term)
  tot <- sum(.manyglm_df$Dev, na.rm = TRUE)
  sp <- sum(.manyglm_df$Dev[whersp], na.rm = TRUE)
  (sp/tot)*100
}

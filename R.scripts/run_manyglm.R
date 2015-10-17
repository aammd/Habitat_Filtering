## run and report the manyglm results
# insects in threespp experiment ------------------------------------------

insect_manyglm <- function(.blocks = blocks, .bromeliad = bromeliad, 
                           .taxa = insects_renamed, 
                           run_interaction_model = FALSE, 
                           sampletime = "final", glm_family = "negative.binomial",
                           organisms = "insects") {

  ## call mvabund on responses
  insectresponses <- insect_data %>% 
    extract2("taxa") %>%
    mvabund
  
  ## run glm
  insect_glm_interact <- insect_data %>% 
    extract2("factors") %>% 
    data.frame %>% 
    manyglm(insectresponses ~ Block * species, data = ., family = glm_family) 
  return(insect_glm_interact)
}


  ## name the model output
  model_name <- paste0(organisms, "_interaction_summary_", sampletime, "_", glm_family, ".Rdata")
  
  # summary gives overall fit
  if (run_interaction_model) {
    insect_interact_summary <- insect_glm_interact %>% 
      summary(resamp="residual")
    save(insect_interact_summary, file = model_name)
    message(paste("I just created the file",model_name))
  } else {
    load(model_name)
  }
  
  ## name the anova output
  anova_name <- paste0(organisms, "_interaction_anova_", sampletime, "_", glm_family, ".Rdata")
  
  # anova gives us values for each animal
  if (run_interaction_model) {
    insect_interact_anova  <- insect_glm_interact %>% 
      anova(resamp="perm.resid", p.uni="adjusted", show.time="all")
    save(insect_interact_anova, file = anova_name)
    message(paste("I just created the file", anova_name))
  } else {
    load(anova_name)
  }
  
  insect_statistic <- insect_interact_anova %>%
    extract2("uni.test") %>% 
    t %>% 
    data.frame %>% 
    select(-X.Intercept.,
           Block_wald=Block,
           species_wald=species) %>%
    l(df -> data.frame(spp=rownames(df),df)) %>%
    set_rownames(NULL)
  
  insect_sig <- insect_interact_anova %>%
    extract2("uni.p") %>%
    t %>% 
    data.frame %>% 
    select(-X.Intercept.,
           Block_p=Block,
           species_p=species) %>%
    l(df -> data.frame(spp=rownames(df),df)) %>%
    set_rownames(NULL)
  
  list(plotting_data = left_join(insect_sig, insect_statistic),
       manyglm_summary = insect_interact_summary,
       manyglm_anova = insect_interact_anova,
       manyglm = insect_glm_interact)
}
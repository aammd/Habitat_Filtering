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

make_summary <- function(manyglm_output){
  summary(manyglm_output, resamp = "residual")
}

manyglm_anova <- function(manyglm_output){
  anova(manyglm_output, resamp="perm.resid", p.uni="adjusted", show.time="all")
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
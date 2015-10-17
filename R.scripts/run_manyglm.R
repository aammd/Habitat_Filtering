## run and report the manyglm results
# insects in threespp experiment ------------------------------------------

run_manyglm <- function(Data, 
                           sampletime = "final", glm_family = "negative.binomial",
                           organisms = "insects") {

  ## call mvabund on responses
  insectresponses <- Data %>% 
    extract2("taxa") %>%
    mvabund
  
  ## run glm
  insect_glm_interact <- Data %>% 
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
  
get_model_stats <- function(anova_output){
  
  insect_statistic <- anova_output %>%
    extract2("uni.test") %>% 
    t %>% 
    data.frame %>% 
    select(-X.Intercept.,
           Block_wald=Block,
           species_wald=species) %>%
    l(df -> data.frame(spp=rownames(df),df)) %>%
    set_rownames(NULL)
  
  insect_sig <- anova_output %>%
    extract2("uni.p") %>%
    t %>% 
    data.frame %>% 
    select(-X.Intercept.,
           Block_p=Block,
           species_p=species) %>%
    l(df -> data.frame(spp=rownames(df),df)) %>%
    set_rownames(NULL)
  
  left_join(insect_sig, insect_statistic)
}
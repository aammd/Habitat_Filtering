## look for block interaction
# anova(inverts_manyglm_fin, inverts_manyglm_fin_add)

## type III sums of squares:



inverts_manyglm_nomain <- run_manyglm_no_main_sp(inverts_tts_fin, glm_family = I("negative.binomial"))

full <- anova(inverts_manyglm_fin, inverts_manyglm_nomain, nBoot = 100)

## z

zoops_manyglm_nomain <- run_manyglm_no_main_sp(zoops_tts_fin, glm_family = I("negative.binomial"))

full_zoops <- anova(zoops_manyglm_fin, zoops_manyglm_nomain, nBoot = 100)

## can get univariate stuff from these models too
anova(zoops_manyglm_fin, zoops_manyglm_nomain, nBoot = 100, p.uni = 'adjusted')

# bacteria


bact_manyglm_nomain <- run_manyglm_no_main_sp(bact_tts_fin, glm_family = I("binomial"))

anova(bact_manyglm_fin, bact_manyglm_nomain, nBoot = 100, p.uni = 'none', resamp = "montecarlo")



invert_null <- run_manyglm_null(inverts_tts_fin, glm_family = I("negative.binomial"))



inverts_manyglm_fin_aov %>% 
  manyglm_get_table %>% 
  percent_dev_sp

inverts_manyglm_fin_aov %>% manyglm_get_table()

zoops_manyglm_fin_aov %>% 
  manyglm_get_table %>% 
  percent_dev_sp


bact_manyglm_fin_aov %>% 
  manyglm_get_table %>% 
  percent_dev_sp


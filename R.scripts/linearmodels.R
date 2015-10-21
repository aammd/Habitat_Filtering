disp_difs_long  %>% 
  lm(value ~ taxa * timing, data = .) 


disp_aov_err <- disp_difs_long  %>% 
  aov(value ~ taxa * timing + Error(block), data = .)

stargazer::stargazer(disp_aov_err)

library(lme4)
disp_aov <- lmer(value ~ taxa * timing + (1|block), data = disp_difs_long)

stargazer::stargazer(disp_aov)
summary(disp_aov)


sum_mixed <- summary(mixedmod)

str(aov_mixed)
aov_mixed$`p-value`

# stargazer::stargazer(mixedmod)
# doesn't work!
head(disp_difs_long)
disp_difs_long %>% 
  spread(timing, value) %>% 
  mutate(percent_dec = (initial - final)/initial) %>% 
  lm(percent_dec ~ taxa, data = .) %>% 
  summary


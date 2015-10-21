disp_difs_long  %>% 
  lm(value ~ taxa * timing, data = .) 


disp_aov_err <- disp_difs_long  %>% 
  aov(value ~ taxa * timing + Error(block), data = .)

stargazer::stargazer(disp_aov_err)



head(disp_difs_long)

## turn blocks into percent decrease
disp_difs_long %>% 
  spread(timing, value) %>% 
  mutate(percent_dec = (initial - final)/initial) %>% 
  lm(percent_dec ~ taxa, data = .) %>% 
  summary


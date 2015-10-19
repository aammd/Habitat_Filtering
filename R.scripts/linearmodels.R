disp_difs_long  %>% 
  lm(value ~ taxa * timing, data = .) 


disp_aov_err <- disp_difs_long  %>% 
  aov(value ~ taxa * timing + Error(block), data = .)

summary.lm(disp_aov_err)

library(lme4)
disp_aov <- lmer(value ~ taxa * timing + (1|block), data = disp_difs_long)

stargazer::stargazer(disp_aov)
summary(disp_aov)


library(nlme)
mixedmod <- lme(value ~ taxa*timing, random = ~1|block, data = disp_difs_long)
summary(mixedmod)
stargazer::stargazer(mixedmod)

head(disp_difs_long)
disp_difs_long %>% 
  spread(timing, value) %>% 
  mutate(percent_dec = (initial - final)/initial) %>% 
  lm(percent_dec ~ taxa, data = .) %>% 
  summary


disp_difs_long %>% 
  ggplot(aes(x = timing, y = value, group = block)) +
  geom_line() +
  facet_wrap(~taxa)
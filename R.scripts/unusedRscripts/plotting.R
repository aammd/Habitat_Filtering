# graphing ----------------------------------------------------------------

## graphing insects threespp ----------

insect_final$plotting_data %>%
  ggplot(aes(x = "insect", y = species_wald, fill = species_p < 0.05)) +
  geom_point(shape = 21, size = 5, alpha = 0.7) +
  scale_fill_manual(values = c(NA, "black")) + 
  scale_y_log10()

# insect_wald %>%
#   ggplot(aes(x="insect",y=species_wald,fill=species_p<0.05)) +
#   geom_point(shape=21,size=5,alpha=0.7)+scale_fill_manual(values=c(NA, "black"))+scale_y_log10()
# 
# zoop_wald %>%
#   ggplot(aes(x="zoop",y=species_wald,fill=species_p<0.05)) +
#   geom_point(shape=21,size=5,alpha=0.7)+scale_fill_manual(values=c(NA, "black"))+scale_y_log10()

library(wesanderson)

pal <- wes.palette(4,name = "GrandBudapest")[-1] #%>% rev

rbind_list(insect_final_nbin$plotting_data %>%mutate(Taxa = "insect"),
           zoop_final_nbin$plotting_data %>% mutate(Taxa = "zoop"),
           bact_wald %>% mutate(Taxa = "bact")) %>% 
  mutate(sd_wald = sd_wald %>% is.na %>% ifelse(0,sd_wald),
         Taxa2 = factor(Taxa,levels = c("insect","zoop","bact")) %>%
           as.numeric %>% 
           jitter(0.6),
         species_wald = species_wald + 1,
         sig = species_p %>% is.na %>% ifelse(1,species_p),
         sig = sig %>% is_less_than(0.05)) %>%
  group_by(Taxa) %>%
  mutate(mean_wald = mean(species_wald)) %>% extract2("mean_wald")
ggplot(aes(x=Taxa2,
           y=species_wald,
           shape=factor(sig),
           ymin=species_wald-sd_wald,
           ymax=species_wald+sd_wald,
           colour=factor(Taxa),
           fill=factor(Taxa)
)
) +
  geom_linerange() + 
  geom_point(size=20) +
  scale_y_log10(limits=c(1,100)) + 
  scale_shape_manual(values=c(1,21)) +
  scale_colour_manual(values = pal) +
  scale_fill_manual(values = pal) +
  scale_x_continuous(breaks=c(1,2,3), 
                     labels=c("invertebrate", "zooplankton", "bacteria"),
                     limits=c(0.8,3.2)) + 
  theme_bw() +
  theme(legend.position="none") +
  ylab("Environmental effect size") + xlab(NULL) +
  theme(axis.title.y = element_text(family="Oxygen",size=40),
        axis.text=element_text(family="Oxygen",size=40)
  )
ggsave("test.svg",width = 20,height = 20, units="in")


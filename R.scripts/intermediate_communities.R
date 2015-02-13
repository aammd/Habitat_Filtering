ini_fin <- left_join(inverts, rename(bromeliad, bromeliad = Brom)) %>% 
  group_by(Block, sampling, Spp) %>%
  summarize(abd = sum(abundance))

homo <- inverts %>% 
  filter(sampling == "homogenized") %>% 
  filter(!grepl("pilot*", bromeliad)) %>% 
  select(Block = bromeliad, sampling, Spp, abd = abundance)

rbind(ini_fin, homo) %>% 
  spread(sampling, abd)

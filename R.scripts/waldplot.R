plot_indiv_species <- function(.inverts_manyglm_fin_aov_tidy,
                               .zoops_manyglm_fin_aov_tidy, 
                               .bact_manyglm_fin_aov_tidy,
                               .mytheme){
  
  tidy_total <- rbind_list(.inverts_manyglm_fin_aov_tidy %>%
                             mutate(taxa = "macroinvertebrates") %>% 
                             scale_dev,
                           .zoops_manyglm_fin_aov_tidy %>% 
                             mutate(taxa = "zooplankton") %>% 
                             scale_dev,
                           .bact_manyglm_fin_aov_tidy %>% 
                             mutate(taxa = "bacteria") %>% 
                             scale_dev)
  
  
  tidy_total %>% 
    mutate(taxa = ordered(taxa,
                          levels = c("macroinvertebrates", 
                                     "zooplankton",
                                     "bacteria")),
           sig = species_p %>% is_less_than(0.05)) %>% 
    ggplot(aes(x = taxa, y = species_wald, fill = factor(sig))) +
    geom_point(shape = 21,
               size = 3,
               position = position_jitter(width = .1)) +
    scale_fill_manual(values = c(NA, "black")) +
    .mytheme
}

scale_dev <- function(manyglm.tidy){
  tot_dev <- manyglm.tidy %>% 
    select(contains("wald")) %>% 
    sum
  # tot_dev <- sum(manyglm.tidy$species_wald)
  
  manyglm.tidy %>% 
    mutate_each(funs(sdev = ./tot_dev), contains("wald"))
}


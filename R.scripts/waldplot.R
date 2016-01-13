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
  
  
  multivar_data <- tidy_total %>% 
    mutate(taxa = ordered(taxa,
                          levels = c("macroinvertebrates", 
                                     "zooplankton",
                                     "bacteria")),
           sig = species_p %>% is_less_than(0.05))
  # browser()
  multivar_data %>% 
    ggplot(aes(x = taxa, y = species_wald, )) +
    geom_boxplot(varwidth = TRUE) +
    geom_point(data = multivar_data %>% 
                 filter(sig),
               shape = 21,
               size = 3,
               fill = "black") +
    geom_label(data = multivar_data %>% 
                 filter(sig), 
               aes(label = rowname), 
               nudge_x = 0.1, hjust = "left") +
    scale_fill_manual(values = c("black"), 
                      labels = c("p < 0.05"),
                      name = NULL) +
    xlab("Organism type") +
    ylab("Percent deviance explained") + 
    theme_minimal()
}

scale_dev <- function(manyglm.tidy){
  tot_dev <- manyglm.tidy %>% 
    select(contains("wald")) %>% 
    sum
  # tot_dev <- sum(manyglm.tidy$species_wald)
  
  manyglm.tidy %>% 
    mutate_each(funs(sdev = ./tot_dev), contains("wald"))
}


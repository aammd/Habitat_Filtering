
get_cohen <- function(disp_val){
  
  disp_d <- cohen.d(as.numeric(disp_val$distances),
                    as.factor(names(disp_val$distances)))

  data_frame(cohen_est = disp_d$estimate,
             lower = disp_d$conf.int[["inf"]],
             upper = disp_d$conf.int[["sup"]])
}

disper_list %>% lapply(anova) %>% lapply(broom::tidy) %>% plyr::ldply() %>% View

perm_disper <- disper_list %>% lapply(permutest)

anova_tables <- perm_disper %>% 
  lapply(function(x) x[["tab"]]) %>% 
  plyr::ldply()



perm_disper[[1]] %>% .[["tab"]]

disper_list %>% lapply(get_cohen) %>% plyr::ldply() %>% 
  separate(.id, c("taxa", "block")) %>% 
  mutate(taxa = ordered(taxa, levels = c("inverts","zoops", "bact"))) %>% 
  ggplot(aes(x = taxa, y = cohen_est)) + geom_point()



disper_list %>% lapply(get_cohen) %>% plyr::ldply() %>% 
  separate(.id, c("taxa", "block")) %>% 
  mutate(taxa = ordered(taxa, levels = c("inverts","zoops", "bact"))) %>% 
  lm(cohen_est ~ taxa, data = .) %>% 
  summary
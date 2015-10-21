
make_betadisp <- function(data_list, distmeas){
  ## repeat this process for all blocks and taxa
  ## arguments for starting data and distance metric
  
  inv_dist <- vegdist(data_list[[2]], method = distmeas)
  # grps <- unite(inverts_ini_fin_Baker[[1]], "blck", Block, sampling)[["blck"]]
  
  inv_grps <- data_list[[1]]$sampling
  
  bkr <- betadisper(inv_dist, inv_grps, bias.adjust = TRUE, )
#   anova(bkr)
#   
#   bkr$distances[names(bkr$distances) == "final"] %>% mean
  return(bkr)
}


get_mean_disps <- function(displist){
  get_mean <- function(df, time) {
    df[["distances"]] %>% 
      .[names(df[["distances"]]) == time] %>% 
      mean
  }
  dplyr::data_frame(
    category = names(displist),
    initial = sapply(displist, get_mean, time = "initial"),
    final = sapply(displist, get_mean, time = "final")
  ) %>% 
    separate(category, c("taxa", "block"))
}


make_disp_mixedmod <- function(.disp_difs_long){
  lme(value ~ taxa*timing, random = ~1|block, data = .disp_difs_long)
}

make_disp_mixedmod_nointeract <- function(.disp_difs_long){
  lme(value ~ taxa + timing, random = ~1|block, data = .disp_difs_long)
}

aov_mixed_tidy <- function(.aov_mixed){
  .aov_mixed %>% 
    add_rownames(var = "term") %>% 
    select(term, Fvalue = `F-value`, pvalue = `p-value`) %>% 
    group_by(term) %>% 
    mutate_each(funs(sprintf("%.2f", .))) %>% 
    ungroup
}

getFP_aov <- function(.aov_mixed_tidy, val, .term){
  .aov_mixed_tidy %>% 
    filter(term == .term) %>% 
    select_(val) %>% 
    as.numeric
}

check_p <- function(pv){
  if (pv < 0.05) {
    "p < 0.05"
  } else {
    "p > 0.05"
  }
}

check_aov_p <- function(.aov_mixed_tidy, Term){
  check_p(getFP_aov(.aov_mixed_tidy, "pvalue", .term = Term))
}

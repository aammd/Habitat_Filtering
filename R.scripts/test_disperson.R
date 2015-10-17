
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
  get_mean <- function (df, time) {
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




           
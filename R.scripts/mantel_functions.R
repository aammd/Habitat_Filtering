split_tts <- function(tts_ini, tts_fin){
  
  ## check rownames by making them unique
  blks_ini <- split(tts_ini[[2]], tts_ini[[1]][,1])
  blks_fin <- split(tts_fin[[2]], tts_fin[[1]][,1])
  
  list(ini = blks_ini, fin = blks_fin)
}


mantel_ini_fin <- function(ini, fin){
  mantel(vegdist(ini), vegdist(fin))
}

make_mantels <- function(tts_split_list){
  Map(mantel_ini_fin,
      tts_split_list[["ini"]],
      tts_split_list[["fin"]])
}

get_man_stat <- function(manlist, getme = "statistic"){
  sapply(manlist, "[[", i = getme)
}

get_statistic <- function(output_list){
    data_frame(blk = names(output_list),
               stat = get_man_stat(output_list, "statistic"),
               sigf = get_man_stat(output_list, "signif"))
  
}

make_tidy_mantel <- function(invert_mantel_list,
                             zoop_mantel_list,
                             bact_mantel_list){
  rbind_list(
    cbind(get_statistic(invert_mantel_list), taxa = "Macroinvertebrates"),
    cbind(get_statistic(zoop_mantel_list), taxa = "Zooplankton"),
    cbind(get_statistic(bact_mantel_list), taxa = "Bacteria")
  )
}
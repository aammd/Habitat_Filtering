
#' make an attractive MDS plot
#'
#' @param taxa_mds the output of metaMDS, when run on one of the nice objects that comes out of TaxaTimeSelector
#' @param env_vars the enviro variables from TaxaTimeSelector
#'
#' @return a nice plot
mds_plotmaker <- function(taxa_mds, env_vars, maintitle){
  # define colours and shapes
  ## plot with colours for species
  mastercols <- viridis(5)
  colors.vec <- mastercols[1:3]
  names(colors.vec) <- c("Neoregelia", "Vrisea","Aechmea.nudicaulis")
  
  ## and shapes for timing
  shapes.vec <- c(initial = 21, final = 22)
  
  ## draw empty plot
  plot(taxa_mds, display = "sites", type = "n", main = maintitle)
  
  ## define hulls by the combination of species and sampling
  env_vars %<>%
    unite(sp_samp, Block, sampling, remove = FALSE)
  
  # browser()
  ## which groups of this are initial? which are final?
  allgrps <- unique(env_vars$sp_samp)
  isfinal <- grepl(".*_final", allgrps)
  fins <- allgrps[isfinal]
  inis <- allgrps[!isfinal]
  
  ordihull(taxa_mds,
           groups = env_vars$sp_samp,
           label = FALSE, lwd = 1.3, draw = "polygon",
           col = mastercols[4], 
           show.groups = fins)
  
  ordihull(taxa_mds,
           groups = env_vars$sp_samp,
           label = FALSE, lwd = 1.3, draw = "polygon",
           col = mastercols[5], 
           show.groups = inis)
  
  # ordihull(taxa_mds,
  #          groups = env_vars$sp_samp,
  #          label = FALSE, lwd = 1.3, draw = "polygon",
  #          col = colors.vec["Neoregelia"],
  #          show.groups = c("Neoregelia_final", "Neoregelia_initial"))
  # 
  # ordihull(taxa_mds,
  #          groups = env_vars$sp_samp,
  #          label = FALSE, lwd = 1.3, draw = "polygon",
  #          col = colors.vec["Vrisea"],
  #          show.groups = c("Vrisea_final", "Vrisea_initial"))
  # 
  # 
  # ordihull(taxa_mds,
  #          groups = env_vars$sp_samp,
  #          label = FALSE, lwd = 1.3, draw = "polygon",
  #          col = colors.vec["Aechmea.nudicaulis"],
  #          show.groups = c("Aechmea.nudicaulis_final",
  #                          "Aechmea.nudicaulis_initial"))
  
  ## draw points for each bromeliad, drawing the shapes and colours from data
  points(taxa_mds, display = "sites", cex = 1,
         pch = shapes.vec[env_vars$sampling], 
         col = "black", 
         bg = colors.vec[env_vars$species])
  
  ## create legends -- carefully, using unique values
  bromnames <- unique(env_vars$species)
  sampnames <- unique(env_vars$sampling)
  
  legend("topright", legend = substr(bromnames, 1, 1),
         bty = "n",
         col = "black",cex = 1.3, pch = 21, pt.bg = colors.vec[bromnames])
  
  legend("bottomright", legend = sampnames,
         bty = "n",
         pch = shapes.vec[sampnames],
         col = "black", pt.bg = "black")
  
}


mds_plot_list <- function(answer_list){
  mds_plotmaker(answer_list[[3]], answer_list[[1]])
}

## function to go over all elements in a list and do the mds_plot_list thing:

plot_taxa_mds <- function(mds_list){
  par(mfrow = c(2,3))
  for
}
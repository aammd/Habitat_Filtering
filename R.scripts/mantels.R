inverts_tts_ini
inverts_tts_fin

## check rownames by making them unique
inv_blks_ini <- split(inverts_tts_ini[[2]], inverts_tts_ini[[1]][,1])
inv_blks_fin <- split(inverts_tts_fin[[2]], inverts_tts_fin[[1]][,1])

mantel_ini_fin <- function(ini, fin){
  mantel(vegdist(ini), vegdist(fin))
}

## each block individually
Map(mantel_ini_fin, inv_blks_fin, inv_blks_ini)

## via strata
mantel(vegdist(inverts_tts_ini[[2]]), vegdist(inverts_tts_fin[[2]]), strata = inverts_tts_fin[[1]][[1]])

zoops_tts_fin[[2]] %>% rowSums()

## there are missing zooplankton samples so:
badzoo <- which(rowSums(bact_tts_ini[[2]]) == 0)
mantel(vegdist(bact_tts_ini[[2]][-badzoo,]),
       vegdist(bact_tts_fin[[2]][-badzoo,]),
       strata = bact_tts_fin[[1]][[1]][-badzoo])

zoo_blks_ini <- split(bact_tts_ini[[2]], bact_tts_ini[[1]][,1])
zoo_blks_fin <- split(bact_tts_fin[[2]], bact_tts_fin[[1]][,1])


Map(mantel_ini_fin, zoo_blks_fin, zoo_blks_ini)

## finally bact


## 
badbac <- which(rowSums(bact_tts_ini[[2]]) == 0)
# which(rowSums(bact_tts_fin[[2]]) == 0) # its fine
mantel(vegdist(bact_tts_ini[[2]][-badbac,]),
       vegdist(zoops_tts_fin[[2]][-badbac,]),
       strata = zoops_tts_fin[[1]][[1]][-badbac])


zoo_blks_ini <- split(zoops_tts_ini[[2]], zoops_tts_ini[[1]][,1])
zoo_blks_fin <- split(zoops_tts_fin[[2]], zoops_tts_fin[[1]][,1])


Map(mantel_ini_fin, zoo_blks_fin, zoo_blks_ini)
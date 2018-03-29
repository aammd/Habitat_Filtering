## these functions extract analysis results from adonis and
## manyglm objects
library(magrittr)

## given a data.frame `dat`, return the value of RESP for
## the variable "species"
adonisValueExtract <- function(dat, RESP) dat[["aov.tab"]]["species",RESP]

## runs adonisValueExtract for all the three major responses
## we want in an adonis analysis
get_summary_adonis <- . %>%
  rowwise %>%
  mutate(R2 = adonisValueExtract(result, "R2"),
         F.Model = adonisValueExtract(result, "F.Model"),
         p = adonisValueExtract(result, "Pr(>F)")
  )

## get_summary_adonis returns a data.frame with the actual
## model output stored in the `result` column. this function
## trims that off before printing
write_results <- function(dat, file){
  dat %>% 
    select(-result) %>% 
    write.csv(file = file, row.names = FALSE)
}

## run the anova on the manyglm output
get_info_manyglm <-  . %>%
  group_by(dataset, grp, time, tech, dist) %>%
  do(aov_result = anova(.[["result"]][[1]],
                        resamp="perm.resid",
                        p.uni="adjusted")
     )

## for anova results, extract all univariate test results
insect_statistic <- . %>%
  extract2("uni.test") %>% 
  t %>% 
  data.frame %>% 
  select(-X.Intercept.,
         Block_wald=Block,
         species_wald=species) %>% 
  add_rownames

## extract univariate p values
insect_sig <- . %>%
  extract2("uni.p") %>%
  t %>% 
  data.frame %>% 
  select(-X.Intercept.,
         Block_p=Block,
         species_p=species) %>% 
  add_rownames

## left join the stastics and their pvals into a dataframe.
## essentially tidying it.
## note that this must be done only to metazoans, so e.g.
## filter(anova_manyglm, grp == "meta") %>% species_stats
species_stats <- function(data){
  data %>% 
    rowwise %>% 
    do(left_join(insect_statistic(.$aov_result), insect_sig(.$aov_result)))
}

r2_plot_df_maker <- function(.inverts_adonis_ini, .inverts_adonis_fin,
                    .zoops_adonis_ini, .zoops_adonis_fin,
                    .bact_adonis_ini, .bact_adonis_fin){ ## does this need to be substitute?
  list(data_frame(name = as.character(quote(.inverts_adonis_ini)), 
                  number = species_r2(.inverts_adonis_ini)),
       data_frame(name = as.character(quote(.zoops_adonis_ini)), 
                  number = species_r2(.zoops_adonis_ini)),
       data_frame(name = as.character(quote(.bact_adonis_ini)), 
                  number = species_r2(.bact_adonis_ini)),
       data_frame(name = as.character(quote(.inverts_adonis_fin)), 
                  number = species_r2(.inverts_adonis_fin)),
       data_frame(name = as.character(quote(.zoops_adonis_fin)), 
                  number = species_r2(.zoops_adonis_fin)),
       data_frame(name = as.character(quote(.bact_adonis_fin)), 
                  number = species_r2(.bact_adonis_fin))
  ) %>%
    bind_rows %>% 
    mutate(name = gsub(x = name, pattern = "\\.", replacement = "")) %>%
    separate(name, into = c("taxa", "method", "time")) %>% 
    mutate(taxa = factor(taxa, levels = c("inverts", "zoops", "bact")))

}


## compare the increase in R2 between different organism groups to a null model of that same increase:
test_slope_robustness <- function(inverts_adonis_ini, inverts_adonis_fin,
                                  zoops_adonis_ini, zoops_adonis_fin,
                                  bact_adonis_ini, bact_adonis_fin, 
                                  .inverts_tts_ini, .zoops_tts_ini, .bact_tts_ini,
                                  .inverts_tts_fin, .zoops_tts_fin, .bact_tts_fin,
                                  REPS){
  # browser()
  sizes <- data_frame(taxa = c("bact", "zoops", "inverts"),
                      size = log(c(0.04, 0.5, 5)))
  # bacteria = 0.04mm,  zooplankton = 0.5mm,  macroinvertebrates = 5mm
  # could replace these values with more detailed size later
  
  observed <- r2_plot_df_maker(inverts_adonis_ini, inverts_adonis_fin,
                               zoops_adonis_ini, zoops_adonis_fin,
                               bact_adonis_ini, bact_adonis_fin) %>% 
    left_join(sizes, by = "taxa") %>% 
    group_by(time) %>% 
    do(broom::tidy(lm(number ~ size, data = .)))
  
  ### randomization tests
  
  null_sims <- replicate(n = REPS, {
    # generate a stratified randomization of the subscripts
    ss <- 1:30 %>% 
      split(f = gl(5, 6)) %>% 
      lapply(sample) %>% 
      unlist
    # randomizing the envrionmental variable -- bromeliad "species" (which is sometimes V, A, N and sometimes open, closed) -- across all observations 
    .inverts_tts_ini$factors$species <- .inverts_tts_ini$factors$species[ss]
    .zoops_tts_ini$factors$species <- .zoops_tts_ini$factors$species[ss]
    .bact_tts_ini$factors$species <- .bact_tts_ini$factors$species[ss] 
    
    .inverts_tts_fin$factors$species <- .inverts_tts_fin$factors$species[ss]
    .zoops_tts_fin$factors$species <- .zoops_tts_fin$factors$species[ss]
    .bact_tts_fin$factors$species <- .bact_tts_fin$factors$species[ss] 
    
    inverts_adonis_ini <- AdonisData(.inverts_tts_ini, method = I("euclid"))
    zoops_adonis_ini <- AdonisData(.zoops_tts_ini, method = I("euclid"))
    bact_adonis_ini <- AdonisData(.bact_tts_ini, method = I("euclid"))
    inverts_adonis_fin <- AdonisData(.inverts_tts_fin, method = I("euclid"))
    zoops_adonis_fin <- AdonisData(.zoops_tts_fin, method = I("euclid"))
    bact_adonis_fin <- AdonisData(.bact_tts_fin, method = I("euclid"))
    
    r2_plot_df_maker(inverts_adonis_ini, inverts_adonis_fin,
                     zoops_adonis_ini, zoops_adonis_fin,
                     bact_adonis_ini, bact_adonis_fin) %>% 
      left_join(sizes, by = "taxa") %>%
      group_by(time) %>% 
      do(broom::tidy(lm(number ~ size, data = .)))
    
    
  }, simplify = FALSE)
  
  obs_slope <- observed %>% filter(term == "size") %>% select(time, estimate)
  
  null_sims_summary <- null_sims %>% 
    bind_rows(.id = "sim") %>% 
    filter(term == "size") %>% 
    select(time, estimate) %>%
    bind_rows(obs_slope) %>% 
    left_join(obs_slope %>% 
                rename(obs = estimate)) %>% 
    group_by(time, obs) %>% 
    summarize(null_mean = mean(estimate),
              null_sd   = sd(estimate),
              null_p    = sum(estimate >= obs) / length(estimate)) %>% 
    mutate(ses = (obs - null_mean) / null_sd)
  
  return(list(null_sims, null_sims_summary))
}


## look at results.
library("magrittr")

adonisValueExtract <- function(dat, RESP) dat[["aov.tab"]]["species",RESP]


get_summary_adonis <- . %>%
  rowwise %>%
  mutate(R2 = adonisValueExtract(result, "R2"),
         F.Model = adonisValueExtract(result, "F.Model"),
         p = adonisValueExtract(result, "Pr(>F)")
  )

write_results <- function(dat, file){
  dat %>% 
    select(-result) %>% 
    write.csv(file = file, row.names = FALSE)
}

get_info_manyglm <-  . %>%
  rowwise %>%
  do(result = .$result, dataset = .$dataset, time = .$time, 
     tech = .$tech, dist = .$dist, 
     aov = anova(.$result, resamp="perm.resid",
                 p.uni="adjusted"))

## for anova results
insect_statistic <- . %>%
  extract2("uni.test") %>% 
  t %>% 
  data.frame %>% 
  select(-X.Intercept.,
         Block_wald=Block,
         species_wald=species) %>% 
  add_rownames

insect_sig <- . %>%
  extract2("uni.p") %>%
  t %>% 
  data.frame %>% 
  select(-X.Intercept.,
         Block_p=Block,
         species_p=species) %>% 
  add_rownames

species_stats <- . %>% 
  rowwise %>% 
  do(left_join(insect_statistic(.$aov), insect_sig(.$aov)))

## these functions extract analysis results from adonis and
## manyglm objects
library("magrittr")

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

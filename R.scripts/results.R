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

r2_plot <- function(.inverts_adonis_ini, .inverts_adonis_fin,
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
    rbind_all %>% 
    mutate(name = gsub(x = name, pattern = "\\.", replacement = "")) %>%
    separate(name, into = c("taxa", "method", "time")) %>% 
    mutate(taxa = factor(taxa, levels = c("inverts", "zoops", "bact"))) %>%
    ggplot(aes(x = taxa, colour = time, y = number)) + 
    geom_point(size = 6) +
    ylab(expression(r^2*" value")) +
    theme_bw()
}
## look at results.


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
  do(aov = anova(.$result, resamp="perm.resid", p.uni="adjusted"))

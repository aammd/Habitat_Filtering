## Functions for analyzing the R data
## 


insect_manyglm <- function(.blocks = blocks,
                           .bromeliad = bromeliad, 
                           .taxa = insects_renamed, 
                           run_interaction_model = FALSE, 
                           sampletime = "final", 
                           glm_family = "negative.binomial",
                           organisms = "insects") {
  ## select blocks
  insect_data <- .blocks %>%
    filter(experiment == "threespp") %>%
    select(Block = block) %>%
    ## merge to bromeliad
    left_join(.bromeliad %>% select(Brom, Block, species)) %>%
    # and add the animals
    left_join(.taxa %>%
                filter(sampling == sampletime) %>%
                spread(key = Spp, abundance, fill = 0) %>%
                mutate(Brom = bromeliad) %>%
                select(-bromeliad)
    ) %>%
    # set up a list object a la mvabund
    {
      list(factors = . %>% 
             select(Block, species) %>% 
             as.matrix,
           insects = . %>% 
             select(-Block, -Brom, -species, -sampling) %>% 
             as.matrix)
    }
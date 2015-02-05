## Functions for analyzing the R data
## Andrew MacDonald 2015

#' get all the insects into a list
#' 
#' binds the blocks to the insects, before filtering, so that we can be sure
#' that environmental variables and species data line up
#' 
#' @param .blocks the blocks data.frame
#' @param .bromeliad the bromeliad data.frame
#' @param .taxa the insects_renamed object (insects after cleaning the names)
#' @param sampletime which sample to analyze. Defaults to "final"
#' @param which_exp which experiment are we looking at here?
insect_manyglm <- function(.blocks = blocks,
                           .bromeliad = bromeliad, 
                           .taxa = insects_renamed,
                           sampletime = "final",
                           which_exp = "threespp") {
  ## select blocks
  .blocks %>%
    filter(experiment == which_exp) %>%
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
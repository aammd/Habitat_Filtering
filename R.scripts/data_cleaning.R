## reading and combining the insect data
## Andrew MacDonald, Dec 2014

read_data <- function(dat) read.table(dat, header = TRUE, 
                                      comment.char="#", 
                                      stringsAsFactors=FALSE)

clean_insect_names <- function(community_data, name_data) {
  ## correct variable spellings
  community_data %>%
    left_join(name_data) %>%
    select(sampling, bromeliad, Spp = sp_name, abundance) %>%
    group_by(sampling, bromeliad, Spp) %>%
    summarise(abundance = sum(abundance)) %>%
    as.data.frame
}

## reading and combining the zoop data
## Andrew MacDonald, Dec 2014

## read data

clean_zooplankton <-  function(filename){
  filename %>% 
    read_csv(comment = "#") %>% 
    tbl_df %>%
    group_by(sampling, bromeliad, Spp) %>%
    # ignores duplicates
    summarise(abundance = mean(abundance)) %>%
    as.data.frame %>% 
    summarize_zoops()
}

summarize_zoops <- function(.zoops){
  .zoops %>% 
    separate(Spp, c("group", "stage")) %>%
    mutate(stage = ifelse(stage %in% c("adult", "nauplius"),
                          "sp",
                          stage),
           stage = ifelse(is.na(stage),
                          "sp",
                          stage)) %>% 
    unite("Spp", group, stage) %>% 
    group_by(sampling, bromeliad, Spp) %>% 
    summarize(abundance = sum(abundance)) %>% 
    as.data.frame
}


## alias for reading bacteria
read_bact <- function(x) read.table(x, comment.char="#",
                                    header=TRUE, stringsAsFactors=FALSE,
                                    sep=",")

clean_bact <- . %>%
  separate(sample, c("Brom", "day", "month"), extra = "drop") %>% 
  mutate(date = paste(day, month, "2013", sep = "-"),
         date = dmy(date),
         sampling = ifelse(date > mean(date), "final", "initial"))

clean_bact_win <- function(df){
  df %>%
    separate(sample, c("Brom", "month")) %>% 
    mutate(sampling = ifelse(month == "may", "final", "initial"))
}

## compose intoi reading functions
read_clean_bact <- . %>%
  read_bact %>%
  clean_bact

read_clean_bact_within <- . %>% 
  read_bact %>% 
  clean_bact_win
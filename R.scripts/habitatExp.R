## file for analyzing the habitat experiment
## Andrew MacDonald, 2014


# insects in threespp experiment ------------------------------------------

insect_manyglm <- function(.blocks = blocks,
                           .bromeliad = bromeliad, 
                           .taxa = insects_renamed, 
                           run_interaction_model = FALSE, 
                           sampletime = "final", 
                           glm_family = "negative.binomial",
                           organisms = "insects") {

  

  ## name the model output
  model_name <- paste0(organisms, "_interaction_summary_", sampletime, "_", glm_family, ".Rdata")
  
  # summary gives overall fit
  if (run_interaction_model) {
    insect_interact_summary <- insect_glm_interact %>% 
      summary(resamp="residual")
    save(insect_interact_summary, file = model_name)
    message(paste("I just created the file",model_name))
  } else {
    load(model_name)
  }
  
  ## name the anova output
  anova_name <- paste0(organisms, "_interaction_anova_", sampletime, "_", glm_family, ".Rdata")
  
  # anova gives us values for each animal
  if (run_interaction_model) {
    insect_interact_anova  <- insect_glm_interact %>% 
      anova(resamp="perm.resid", p.uni="adjusted", show.time="all")
    save(insect_interact_anova, file = anova_name)
    message(paste("I just created the file", anova_name))
  } else {
    load(anova_name)
  }
  
  insect_statistic <- insect_interact_anova %>%
    extract2("uni.test") %>% 
    t %>% 
    data.frame %>% 
    select(-X.Intercept.,
           Block_wald=Block,
           species_wald=species) %>%
    l(df -> data.frame(spp=rownames(df),df)) %>%
    set_rownames(NULL)
  
  insect_sig <- insect_interact_anova %>%
    extract2("uni.p") %>%
    t %>% 
    data.frame %>% 
    select(-X.Intercept.,
           Block_p=Block,
           species_p=species) %>%
    l(df -> data.frame(spp=rownames(df),df)) %>%
    set_rownames(NULL)

  list(plotting_data = left_join(insect_sig, insect_statistic),
       manyglm_summary = insect_interact_summary,
       manyglm_anova = insect_interact_anova,
       manyglm = insect_glm_interact)
}

rerun <- FALSE
## calculating model objects
if (rerun) {
  ## initial insects
  insect_manyglm(run_interaction_model = rerun, sampletime = "initial")
  insect_manyglm(run_interaction_model = rerun, sampletime = "initial", glm_family = "poisson")
  ## final insects
  insect_manyglm(run_interaction_model = rerun, sampletime = "final")
  insect_manyglm(run_interaction_model = rerun, sampletime = "final", glm_family = "poisson")
  ## initial zoops
  insect_manyglm(.taxa = zoop_combined,
                 run_interaction_model = rerun,
                 organisms = "zoops",
                 sampletime = "initial")
  insect_manyglm(.taxa = zoop_combined,
                 run_interaction_model = rerun,
                 organisms = "zoops",
                 sampletime = "initial", glm_family = "poisson")
  ## final zoops
  insect_manyglm(.taxa = zoop_combined,
                 run_interaction_model = rerun,
                 organisms = "zoops",
                 sampletime = "final")
  insect_manyglm(.taxa = zoop_combined,
                 run_interaction_model = rerun,
                 organisms = "zoops",
                 sampletime = "final", glm_family = "poisson")
} else {
  ## LOADING model objects
  ## initial insects
  insect_initial_nbin <- insect_manyglm(run_interaction_model = rerun, sampletime = "initial")
  insect_initial_pois <- insect_manyglm(run_interaction_model = rerun, sampletime = "initial", glm_family = "poisson")
  ## final insects
  insect_final_nbin <- insect_manyglm(run_interaction_model = rerun, sampletime = "final")
  insect_final_pois <- insect_manyglm(run_interaction_model = rerun, sampletime = "final", glm_family = "poisson")
  ## initial zoops
  zoop_initial_nbin <- insect_manyglm(.taxa = zoop_combined,
                 run_interaction_model = rerun,
                 organisms = "zoops",
                 sampletime = "initial")
  zoop_initial_pois <- insect_manyglm(.taxa = zoop_combined,
                 run_interaction_model = rerun,
                 organisms = "zoops",
                 sampletime = "initial", glm_family = "poisson")
  ## final zoops
  zoop_final_nbin <- insect_manyglm(.taxa = zoop_combined,
                 run_interaction_model = rerun,
                 organisms = "zoops",
                 sampletime = "final")
  zoop_final_posis <- insect_manyglm(.taxa = zoop_combined,
                 run_interaction_model = rerun,
                 organisms = "zoops",
                 sampletime = "final", glm_family = "poisson")
}

#check assumptions

insect_final_nbin$manyglm %>% plot
insect_final_pois$manyglm %>% plot

zoop_initial_nbin$manyglm %>% plot
zoop_initial_pois$manyglm %>% plot

insect_final_nbin$manyglm_summary
zoop_final_nbin$manyglm_summary

# Bacteria from threespp --------------------------------------------------

if (FALSE) {
  bact_results <- plyr::llply(bacteria_list,function(BACTERIA){
    ## select blocks
    bact_data <- blocks %>%
      filter(experiment=="threespp") %>%
      select(Block=block) %>%
      ## merge to bromeliad
      left_join(bromeliad) %>%
      mutate(bromeliad=Brom) %>%
      select(-Brom) %>%
      # and add the animals
      ## note that for bacteria, they are joined in the opposite direction!
      left_join(BACTERIA,
                .                        # this dot essentially makes this a "right join".
      ) %>% 
      # set up a list object a la mvabund
      l(data -> {
        list(factors=data %>% select(Block,species) %>% as.matrix,
             bacts=data %>% select(starts_with("X")) %>% as.matrix
        )}
      )
    
    ## call mvabund on responses
    bactresponses <- bact_data %>% extract2("bacts") %>% mvabund
    
    ## run glm
    bact_glm_species <- bact_data %>% extract2("factors") %>% data.frame %>% 
      manyglm(bactresponses~species,data=.,family="binomial") 
    
    bact_total_aov <- anova(bact_glm_species, nBoot=400, test="wald")
    
    ## not sure how to interpret
    #drop1(bact_glm_species)
    
    # summary gives overall fit
    bact_species_summary <- bact_glm_species %>% summary(resamp="pit.trap")
    # anova gives us values for each animal
    bact_species_anova  <- bact_glm_species %>% anova(resamp="pit.trap",p.uni="adjusted", show.time="all")
    
    bact_statistic <- bact_species_anova$uni.test %>% t %>% data.frame %>% 
      select(-X.Intercept.,
             #Block_wald=Block,
             species_wald=species) %>%
      l(df -> {data.frame(spp=rownames(df),df)}) %>%
      set_rownames(NULL)
    
    bact_sig <- bact_species_anova$uni.p %>% t %>% data.frame %>% 
      select(-X.Intercept.,
             #Block_p=Block,
             species_p=species) %>%
      l(df -> {data.frame(spp=rownames(df),df)}) %>%
      set_rownames(NULL)
    
    bact_species_wald <- left_join(bact_sig,bact_statistic)
    
    list("bact_glm_species"=bact_glm_species,
         "bact_total_aov"=bact_total_aov,
         "bact_species_summary"=bact_species_summary,
         "bact_species_anova"=bact_species_anova,
         "bact_species_wald"=bact_species_wald)
  })
  save(bact_results, file = "bacteria_results_final.Rdata")
  message(paste("I just created the file","bacteria_results_final.Rdata"))
} else {
  load("bacteria_results_final.Rdata")
}

bact_results %>% lapply(function(blk) extract2(blk,"bact_species_anova"))


    ## check with plots
par(mfrow=c(2,3))
lapply(bact_results,function(x) plot(x$bact_glm_species))

plyr::ldply(bact_results,extract2,"bact_species_wald") %>%
  select(block=.id,
         species_p,
         species_wald) %>%
  ggplot(aes(x=block,y=species_wald))+geom_point()

bact_wald <- plyr::ldply(bact_results,extract2,"bact_species_wald") %>%
  select(block=.id,
         species_p,
         species_wald) %>%
  group_by(block) %>%
  summarize(sd_wald=sd(species_wald),
            species_wald=mean(species_wald)
#             species_p=sum(species_p>0.05),       
  )

# graphing ----------------------------------------------------------------

## graphing insects threespp ----------

insect_final$plotting_data %>%
  ggplot(aes(x = "insect", y = species_wald, fill = species_p < 0.05)) +
  geom_point(shape = 21, size = 5, alpha = 0.7) +
  scale_fill_manual(values = c(NA, "black")) + 
  scale_y_log10()

# insect_wald %>%
#   ggplot(aes(x="insect",y=species_wald,fill=species_p<0.05)) +
#   geom_point(shape=21,size=5,alpha=0.7)+scale_fill_manual(values=c(NA, "black"))+scale_y_log10()
# 
# zoop_wald %>%
#   ggplot(aes(x="zoop",y=species_wald,fill=species_p<0.05)) +
#   geom_point(shape=21,size=5,alpha=0.7)+scale_fill_manual(values=c(NA, "black"))+scale_y_log10()

library(wesanderson)

pal <- wes.palette(4,name = "GrandBudapest")[-1] #%>% rev

rbind_list(insect_final_nbin$plotting_data %>%mutate(Taxa = "insect"),
           zoop_final_nbin$plotting_data %>% mutate(Taxa = "zoop"),
           bact_wald %>% mutate(Taxa = "bact")) %>% 
  mutate(sd_wald = sd_wald %>% is.na %>% ifelse(0,sd_wald),
         Taxa2 = factor(Taxa,levels = c("insect","zoop","bact")) %>%
           as.numeric %>% 
           jitter(0.6),
         species_wald = species_wald + 1,
         sig = species_p %>% is.na %>% ifelse(1,species_p),
         sig = sig %>% is_less_than(0.05)) %>%
  group_by(Taxa) %>%
  mutate(mean_wald = mean(species_wald)) %>% extract2("mean_wald")
  ggplot(aes(x=Taxa2,
             y=species_wald,
             shape=factor(sig),
             ymin=species_wald-sd_wald,
             ymax=species_wald+sd_wald,
             colour=factor(Taxa),
             fill=factor(Taxa)
  )
  ) +
  geom_linerange() + 
  geom_point(size=20) +
  scale_y_log10(limits=c(1,100)) + 
  scale_shape_manual(values=c(1,21)) +
  scale_colour_manual(values = pal) +
  scale_fill_manual(values = pal) +
  scale_x_continuous(breaks=c(1,2,3), 
                     labels=c("invertebrate", "zooplankton", "bacteria"),
                     limits=c(0.8,3.2)) + 
  theme_bw() +
  theme(legend.position="none") +
  ylab("Environmental effect size") + xlab(NULL) +
  theme(axis.title.y = element_text(family="Oxygen",size=40),
        axis.text=element_text(family="Oxygen",size=40)
  )
ggsave("test.svg",width = 20,height = 20, units="in")


rbind_list(insect_final_nbin$plotting_data %>% mutate(Taxa="insect"),
           zoop_final_nbin$plotting_data %>% mutate(Taxa="zoop"),
           bact_wald %>% mutate(Taxa="bact")
) %>%
  group_by(




  ggsave("test.png",width = 20,height = 20, units="in")




## basic first question: for each bromeliad, how did the densities of
## each species change?

## first identify which block belongs to each species

## need matrix with spp names as columns, first row density in
## homogenized, second row density in final.  maplot with a second
## vector of 1,2

## ok so this could be easily made from a dataframe that had only the
## data for one bromeliad and the homogenized community.

## first get a list of all the broms in the homogenized community


## need to get the right bromeliads together for the question
## keep it simple: one species.
select_bromeliads<-function(blockname,dataframe=insects){
  ## get the bromeliads in this block
  useful.broms<-bromeliad$Brom[bromeliad$Block%in%c(blockname)]

  ## collect *all* relevant insects
  sampled_community<-dataframe[dataframe$sampling%in%c("initial","final","homogenized")
                             &dataframe$bromeliad%in%c(useful.broms,blockname),]
  #sampled_community_cast<-cast(sampled_community,sampling+bromeliad~spp,fill=0)
  ## get their species
  # useful_brom_sp<-bromeliad$species[match(sampled_community_cast$bromeliad,bromeliad$Brom)]
  useful_brom_sp<-bromeliad$species[match(sampled_community$bromeliad,bromeliad$Brom)]
  # get their habitat
  useful_brom_hab<-bromeliad$Habitat[match(sampled_community$bromeliad,bromeliad$Brom)]
  ## the one missing value is actually the homogenized community
  useful_brom_sp[is.na(useful_brom_sp)]<-"homogenized"
  #browser()
  data.frame(block=blockname,brom_sp=useful_brom_sp,habitat=useful_brom_hab,sampled_community)
}

one_block_ordination<-function(cast_df){
  sampled_community_cast<-cast_df[,!names(cast_df)%in%c("brom_sp","block","sampling","bromeliad","habitat")]
  # CAs<-scores(cca(sampled_community_cast))[["sites"]]
  CAs<-metaMDS(vegdist(sampled_community_cast,distance="euclid"))[["points"]]
  CAs<-as.matrix(CAs)
  colnames(CAs)<-c("CA1","CA2")
  data.frame(cast_df[,names(cast_df)%in%c("block","sampling","brom_sp","bromeliad","habitat")],CAs)
}

## just do before and after
## permavoa - for the spread of the points.
## before and after for the same community!

## I want to redo the thing to check all bromeliads simultaneously
newer_plot_select_blocks<-function(block_vector=c("Baker","Davidson","Eccleson","Tennant","Smith")){
  selected_broms<-lapply(block_vector,select_bromeliads)
  newtest<-do.call(rbind,selected_broms)
  ## cast spp into columns:
  sampled_community_cast<-cast(newtest,sampling+bromeliad+brom_sp+block~spp,value="abundance",fill=0)
  ordinated_bromeliads<-one_block_ordination(sampled_community_cast)
  wide_broms<-reshape(ordinated_bromeliads,v.names=c("CA1","CA2"),
                      timevar="sampling",direction='wide',idvar="bromeliad")
  
  ## need to fill in the homogenized values:
  
  starting_points<-wide_broms[wide_broms$brom_sp=="homogenized",c("block","CA1.homogenized","CA2.homogenized")]
  
  ## remove homogenized from original and organize
  reshaped_broms<-merge(starting_points,wide_broms[,!names(wide_broms)%in%c("CA1.homogenized","CA2.homogenized")],by="block")
  reshaped_broms2<-reshaped_broms[reshaped_broms$brom_sp!="homogenized",]
  reshaped_broms_hull<-with(reshaped_broms2,convex.hull(cbind(CA1.initial,CA2.initial)))
  #browser()
  ggplot(data=reshaped_broms2,aes(x=CA1.homogenized,xend=CA1.final,y=CA2.homogenized,yend=CA2.final,
                                  colour=brom_sp))+
    geom_segment(arrow=arrow(length=unit(0.2,"cm")))+
    geom_point(aes(colour="homogenized"))+xlab("axis1")+ylab("axis2")+geom_point(aes(x=CA1.initial,y=CA2.initial))+
    scale_colour_brewer(type="div",palette=5)+labs(colour="")
}


## I want to redo the thing to check all bromeliads simultaneously
plot_select_blocks_arrow<-function(block_vector=c("Baker","Davidson","Eccleson","Tennant","Smith"),Dataframe=insects,homogen_insects=TRUE){
  
  selected_broms<-lapply(block_vector,select_bromeliads,dataframe=Dataframe)
  newtest<-do.call(rbind,selected_broms)
  
  sampled_community_cast<-cast(newtest,sampling+bromeliad+brom_sp+habitat+block~spp,value="abundance",fill=0,fun.aggregate=sum)
  
  ## ordination
  ordinated_bromeliads<-one_block_ordination(sampled_community_cast)
  
  ## melt these ordinated data
  meltbrom <- melt(ordinated_bromeliads)
  
  #   ## split the melted ordinations by sampling date, and then cast the two CA axes into columns:
  #   test <- ddply(meltbrom,.(sampling),dcast,formula=block+brom_sp+bromeliad+habitat~variable)
  #   
  
  ##because we need to separate the CA1 and 2 for each time period (in order to draw arrows) we first must combine these vectors:
  melt_with_combined_columns <- transform(meltbrom,newvar=apply(cbind(as.character(variable),sampling),1,paste,collapse="."))
  
  # now cast this back into columns:
  
  out <- dcast(melt_with_combined_columns,formula=block+brom_sp+bromeliad+habitat~newvar)
  
  ## the below merging is only relevant for insect communities.
  if (!homogen_insects) out 
  
  else {
    ## remove habitat
    out2 <- out[,!names(out)%in%c("habitat")]
    
    ## select out homos
    homogen <- out2[,names(out2)%in%c("bromeliad","CA1.homogenized","CA2.homogenized")]
    ## remove NA rows
    homogen <- homogen[complete.cases(homogen),]
    ## rename bromeliad to block:
    homogen <- rename(homogen,replace=c("bromeliad"="block"))
    
    ## select just the other rows:
    not_homogen <- out2[,!names(out2)%in%c("CA1.homogenized","CA2.homogenized")]
    ## remove NA rows
    not_homogen <- not_homogen[complete.cases(not_homogen),]
    not_homogen$block <- as.character(not_homogen$block)
    
    ## now merge `block` in not_homogen to `bromeliad` in homogen (renamed above):
    join(homogen,not_homogen,by="block",type="full")
    
    #   ## dataframe with only the original samples
    #   first <- dcast(subset(meltbrom,sampling=="initial"),formula=block+brom_sp+bromeliad+habitat~variable)
    #   ## with the homogenized samples
    #   homo <- dcast(subset(meltbrom,sampling=="homogenized"),formula=block+brom_sp+bromeliad+habitat~variable)
    #   ## the arrows are trickier: they require a merge:
    #   final <- dcast(subset(meltbrom,sampling=="final"),formula=block+brom_sp+bromeliad+habitat~variable)
    
    #   arrows <- merge(homo,final,by="block",suffixes=c(".homo",".final"))
    #   
    #   out <- list(first,homo,arrows)
    #   names(out) <- c("first","homo","arrows")
    #   out
    #   ggplot(data=first,aes(x=CA1,y=CA2,colour=brom_sp))+geom_point()+geom_point(data=homo)+geom_segment(data=arrows,aes(x=CA1.homo,xend=CA1.final,y=CA2.homo,yend=CA2.final,colour=brom_sp.final),arrow=arrow(length=unit(0.2,"cm")))
  }
}





## read and work with ibutton data
ibutton_data<-read.ibutton.folder("/home/andrew/Dropbox/PhD/brazil2013/experiments/data/ibuttons/SarahJane/")
sarahjane<-ibuttons.to.data.frame(ibutton_data)

## later I'm going to make this combine nicely with the main dataset.\


## just for quick right now:
habitats<-data.frame(ibutton=c(24,23,25,42,28,30),
  habitat=rep(c("open","closed"),c(3,3)))

sarahjane<-merge(habitats,sarahjane,by="ibutton")



# bacteria ordination: ----------------------------------------------------

## this only works for Bacteria.
bacteria_ordination <- ldply(bacteria_list[3:5],function(X){
  X2 <- X[,!names(X)%in%c("bromeliad","sampling","block")]
  CAs<-metaMDS(vegdist(X2,distance="euclid"))[["points"]]
  CAs <- as.matrix(CAs)
  colnames(CAs)<-c("CA1","CA2")
  data.frame(X[,names(X)%in%c("bromeliad","sampling","block")],CAs)
})


## that can be graphed right away:
bromeliad2 <- bromeliad[,1:2]
bromeliad2 <- rename(bromeliad2,c("Brom"="bromeliad"))
bact_ord_spp <- join(bacteria_ordination,bromeliad2,by="bromeliad")

if(FALSE){
svg("bacteria.svg",width=11.2,height=8.4)
ggplot(bact_ord_spp,aes(x=CA1,y=CA2,colour=species,shape=sampling))+geom_point(size=5)+theme(axis.text=element_text(size=12),axis.title=element_text(size=14,face="bold"))+facet_wrap(~block,scales="free",ncol=2)
dev.off()
}

meltbacteria <- melt(bacteria_ordination)

#   ## split the melted ordinations by sampling date, and then cast the two CA axes into columns:
#   test <- ddply(meltbrom,.(sampling),dcast,formula=block+brom_sp+bromeliad+habitat~variable)
#   

##because we need to separate the CA1 and 2 for each time period (in order to draw arrows) we first must combine these vectors:
melt_with_combined_columns <- transform(meltbacteria,newvar=apply(cbind(as.character(variable),sampling),1,paste,collapse="."))

# now cast this back into columns:

out <- dcast(melt_with_combined_columns,formula=block+bromeliad~newvar)



# llply(bacteria_list,function(x) sum(is.na(x)))
# 
# CAs<-metaMDS(vegdist(sampled_community_cast,distance="euclid"))[["points"]]
# CAs<-as.matrix(CAs)
# colnames(CAs)<-c("CA1","CA2")
# data.frame(cast_df[,names(cast_df)%in%c("block","sampling","brom_sp","bromeliad","habitat")],CAs)


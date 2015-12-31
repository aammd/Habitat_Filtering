---
title: "Smaller organisms are less strongly structured by environmental variation"
author: "A. Andrew M. MacDonald, Vinicius F. Farjalla , Diane S. Srivastava"
fontsize: 12pt
output:
  pdf_document:
    includes:
      in_header: formatting/myheader.tex
    latex_engine: xelatex
  md_document: default
  html_document: default
  word_document:
    reference_docx: formatting/reference.docx
geometry: margin=1in
bibliography: orgsize.bib
csl: formatting/the-american-naturalist.csl
---




## Abstract


## Introduction

When can we predict species composition from environmental conditions? This
relationship is important to understand, because different species
compositions may perform different functions. If different environments cause
different species compositions, then as the global environment changes,
species will also change [@Hooper2012;@Gilman2010]. However, it appears that  not all species
are equally sensitive to the same environmental conditions [@Farjalla2012]. This relationship is complicated by dispersal -- different groups of organisms disperse to different degrees, affecting how well their distribution match the environment. Are there general
principles which would allow us to predict when species composition depends on
the environment? We test the hypothesis that the strength of this relationship
is positively correlated with the overall size of organisms: that is,
environmental conditions have a stronger effect on in larger- bodied
macroscopic organisms, and a weaker signal in smaller-bodied microscopic
organisms.

How much variation in community composition is related to the environment
depends on the process of community assembly. Models of community assembly
describe how local communities are assembled from the regional species pool;
these have been organized [@Vellend2010b;@Nemergut2013a;@Lessard2012] into four
distinct processes: speciation, dispersal, selection and drift. In this
framework, speciation populates the regional pool, dispersal refers to the
arrival of species into a local community, “selection” to differences among
species in their response to environment or other species, and “drift” to
changes in species abundances resulting from stochastic demographic processes.
These four processes together can describe all of the contemporary models of
community ecology; providing a framework for assessing whether differences in dispersal or differences in selection drive community structure [@Vellend2010b;@Hanson2012;@Chase2011] For example, neutral theory assumes all individuals of all
species are equivalent, and so is based on dispersal, drift and speciation
alone [@Weiher2011;@Alonso2006;@Chave2004]. Because neutral theory excludes ecological selection, it predicts that
spatial patterns in species composition are largely uncorrelated with the
underlying environment. In a niche-based framework, species are able to
coexist if they possess traits which permit them to colonize and persist in a
habitat, and if they are sufficiently different from other species to allow
coexistence [@Chase2003]. Because species often differentiate their niches on the basis of
environmental tolerance, niche theories generally predict a close coupling of
species composition with the underlying environment (except where species interactions modify these distributions, [@Vellend2014])

As neutral and niche theory make different predictions about the strength of
environmental correlations with species composition, numerous studies have
examined such correlations in the hopes of determining whether niche or
neutral paradigms are the better descriptor of communities. Rather than a
universal pattern, such studies have instead revealed a wide spectrum of
correlation strengths between environment and communities. Although there has
been some attempt to understand this variation in terms of differences between
environments [@Peres-Neto2006], there has been much less consideration of the role of
biological differences between organisms.

One of the most profound differences between organisms is in their body size.
Macroscopic (> 1mm) and microscopic (< 1 mm) animals differ in population
size, population growth rates, physiological pathways, morphological
complexity, genome size, mechanisms of gene transfer, and modes of dispersal.
These biological properties of organisms are in turn expected to affect rates
of speciation, dispersal, selection and drift -- the four processes underlying
community assembly. It is therefore likely that communities composed of
either macroscopic and microscopic animals differ in the way in which they are
assembled.

If microscopic and macroscopic communities are assembled by different
processes, we would expect to see difference in their distribution. Indeed,
this is often the case. Microscopic organisms are often globally distributed,
while macroscopic organisms have more geographically restricted distributions.
Even within landscapes, there is some evidence that microscopics organisms
respond less to environmental or elevational gradients than macroscopic
organisms [@Farjalla2012;@Fierer2011].  However, while such
differences in distribution suggest that the suite of processes underlying
community assembly differ between micro- and macroscopic organisms, it is
difficult to determine which process is driving this difference. There are two
possible mechanisms that may make communities of smaller organisms more widely
distributed. First, smaller organisms could have larger environmental
tolerances, allowing them to occupy broader fundamental niches. Second,
smaller organisms could have greater dispersal abilities, allowing them to
reach more habitats.

<!--Bryant J et al 2008 pnas show bacteria and plants have different patterns over an elevational gradient – but both respond-->
<!--Wang, J., Soininen, J., Zhang, Y., Wang, B., Yang, X. and Shen, J. (2012), Patterns of elevational beta diversity in micro- and macroorganisms. Global Ecology and Biogeography, 21: 743–750. doi: 10.1111/j.1466-8238.2011.00718.x-->

The environment may not affect small-bodied organisms if they have large
fundamental niches, meaning that they would not experience much selection after
colonizing a new habitat. This larger fundamental niche could be caused by
several factors. First, their small body size allows habitat heterogeneity to
affect them at very small scales:  smaller things are able to find tiny
microhabitats that they are able to tolerate, while organisms that live at
larger scales cannot. Secondly, single celled organisms may be able to use
multiple carbon sources [@Langenheder2007] and therefore are found in more
habitats.  Microscopic life is also more likely to possess resting stages when a
habitat is unfavorable (e.g. encysting protists, tun state for tardigrades) or
to propagate by a resistant life history stage (spores). At the population
level, small organisms may persist in a habitat if they are able to evolve
rapidly by virtue of their rapid generation times and high population sizes.
This rapid evolution can also proceed because of the use of environmental DNA,
which bacteria can absorb and which may confer an advantage in new habitats.
Zooplankton may also evolve rapidly (cite), for example in response to the
presence of predators.

Alternatively, microscopic organisms may be widely distributed because they
are able to get to more places faster. There is substantial evidence that
microscopic organisms may be able to disperse further than macroscopic
organisms. The classic "everything is everywhere and the environment selects"
hypothesis of Baas Becking [-@BaasBecking1934] suggests that smaller organisms are not limited by
biogeographic barriers but instead are found everywhere, emerging from
resistant stages in favorable environments [@Huszar2015]. Many bacteria and zooplankton have
passive dispersal, traveling between suitable habitat by wind or water
currents, or by phoresy. In contrast, macroscopic organisms usually have
active dispersal, for example oviposition by flying adults. At smaller spatial
scales, active dispersal could result in a close association between
distribution and environmental variables, assuming that active dispersal is
adapted to maximize fitness. However, at larger scales, the limited distances
covered by active dispersal might prevent macroscopic animals from reaching
suitable places. This would weaken the association between environment and
distribution for such animals. Dispersal is higher for smaller animals both in
terms of the number of dispersing propagules (because population sizes are so
much larger) and the distance dispersed (since passive dispersal requires no
energy, organisms can go very far.)

It has been difficult to determine whether environmental filtering or
dispersal limitation explains variation in species composition between micro-
and macroscopic organisms. There are two reasons for this. First, the
distribution of micro-and macroscopic organisms has rarely been compared
within the same system. This creates a problem of scale, with studies of many
macroscopic organisms occurring on much smaller spatial scales than bacteria.
Second, when we rely on observational data alone, we have a limited ability to
infer environmental filtering. This is because environment, space and
dispersal are often correlated. Additionally, when an actively-dispersing
species is not found in a site it is impossible to determine if this is
because the environment makes dispersal or establishment unlikely. For
example, a female insect may be deterred from ovipositing in a location by the
presence of a predator. Previous researchers have used variance partitoning to
separate the effects of environment from space, but this approach still has
limitations [@Gilbert2010]. Patterns of dispersal may be irregular and nonlinear over space,
caused by individual behaviour (active dispersers) or by nonlinear,
unpredictable vectors (passive dispersers). An experiment that removes
dispersal limitation for all organisms is therefore a stronger test of the relative effects
of environment on species composition. We are aware of no study that
experimentally removes dispersal limitation for both micro- and macro-
organisms in the same system, simultaneously.

#Bromeliads 
We conducted an experiment that removes dispersal limitation for
micro- and macro-organisms, using bromeliad phytotelmata as a model community.
Bromeliads are common in the neotropics and contain many species of insects [@Marino2012], zooplankton [CITE], and bacteria [CITE]. Importantly, different species of
bromeliad grow in different habitats, and this habitat variation is correlated with differences among their communities. Previous observations in this system
show that this environmental variation is closely associated with variation in
macroinvertebrate composition, weakly associated with variation in zooplankton communities and not at all associated with variation in bacterial communities [@Farjalla2012].

#Hypotheses
Here we provide a much stronger test of the strength of environmental filtering for these three organism types by experimentally dispersing all species to all habitats, and examining whether the original habitat-based patterns in composition re-emerged.  We predicted: 
1). If environmental filtering increases with organism size, we would predict that larger organisms would show stronger habitat effects on community composition than smaller organisms, both before and after our experimental dispersal treatment (Figure  1a). 
2). If instead dispersal limitation increased with organism size, we would expect that any apparent effect of habitat on community composition was an artefact of spatial autocorrelation and would be erased by our dispersal treatment (Figure  1b). 
3). If both environmental filtering and dispersal limitation increased with organism size, we would predict an intermediate scenario (Figure  1c).


![ho](../photos/hypotheses.png)

Figure  1: Our hypotheses about the effect of organism body size on the strength of environmental filtering.

## Methods

### Experimental design

Our goal is to experimentally test the observational patterns
documented by Farjalla et al. [-@Farjalla2012], therefore we performed this
experiment in the same location along the same gradient of environmental
variation. The location we used is the Parque Nacional de Jurubatiba,
Northeast Rio de Janeiro state, Brazil ($22^{\circ}$ S $41^{\circ}$); the
environmental gradient is twofold -- three different species of bromeliad,
which grow in three levels of exposure to sunlight. Each species of bromeliad
is found in a different habitat of the park: _Aechmea nudicaulis_ (full sun
habitats), _Vriesea neoglutinosa_ (partial shade), and _Neoregelia cruenta_
(full shade). _Neoregelia_ has a uniquely large habitat range at this site,
occurring in both full shade and full sun; only shade plants were used in this
study.



We homogenized the community of macroinvertebrates, zooplankton and bacteria
among all three bromeliad species. For each of five temporal blocks, we
collected and sampled the macroinvertebrates, zooplankton and bacteria of two
bromeliads of each of the three species. We then homogenized the communities
of all six bromeliads as described shortly (Figure  2).  Our goal was
to create identical starting community composition for all bromeliads within a
block. Variation between blocks in starting community composition is thus
included in the random effect of blocks. We created five blocks in this
experiment between 27 March 2013 and 03 April 2013.

![img](../photos/design.png) 

Figure  2: Schematic of our experimental design. We first sampled six bromeliads (two plants of each of the three species named here). We formed (solid arrows) homogeneous initial communities (MIX) by counting equal numbers of animals (macroinvertebrates) or by mixing water samples of equal volume from all plants (zooplankton and bacteria). We then returned (dashed arrows) these initial communities to the six bromeliads, and replaced the bromeliads in their original habitats.

Our experimental setup consisted of three steps (Figure  2):
collection of original communities from bromeliads, homogenization of
communities, and assembly of this homogenized community in each of the
original (now empty) bromeliads.  **Original communities**: Prior to sampling
the macroinvertebrates, we sampled macroinvertebrates by thoroughly rinsing
each bromeliad and filtering the water through 1mm and 180μm mesh. These mesh
sizes have been shown to separate macro invertebrates from both coarse
detritus and fine particulate organic matter, facilitating their collection [@Romero2010].
We identified macroinvertebrates to morphospecies. We sampled the zooplankton
and bacteria communities by collecting water samples from each bromeliad:
100ml for zooplankton, 50ml for bacteria. Zooplankton were collected by
filtering on 50 μm Nytex mesh and fixed in 5% buffered formalin. This fixed
solution was then diluted to 20 ml, and a 1 ml subsample taken for analysis.
Zooplankton were  identified to the lowest taxonomic unit possible (species in
most cases, except for bdelloid rotifers and harpaticoid copepods, left at the
level of class and order, respectively). Bacteria were collected by taking
100ml of filtrate from the zooplankton sample and filtering it a second
time on a Whatman filter paper. We measured bacterial community composition
using denaturing gradient gel electrophoresis (DGGE, Muyzer et al.
[@Muyzer1993]). This technique measures an approximation of bacterial
diversity in the form of Operational Taxonomic Units (OTUs). **Homogenized
communities**: We created homogenized communities of zooplankton and microbes
by mixing an equal volume of filtered tank water from each plant
(approximately 100ml plant^-1^), then dividing this mixed volume among all
individual bromeliads. To create homogenized communities of
macroinvertebrates, we simply divided all the individuals of all species found
in our six bromeliads equally among these bromeliads. **Bromeliad
preparation**: We emptied bromeliads by washing them thoroughly, hanging them
upside down to dry for at least 24 hours and then rinsing each plant with 70%
ethanol. Any coarse detritus found in the bromeliads was similarly cleaned,
frozen and thawed (to kill any macroinvertebrates eggs). We confirmed that
this technique removed all invertebrates and most detritus by dissecting an
empty bromeliad. Bromeliads were placed in a local habitat similar to their
original location: _Neoregelica_ in shade, _Aechmea_ in full sun and _Vriesea_ in
marginal habitat. We then added the starting communities of
macroinvertebrates, zooplankton and bacteria.

Bromeliads are an open system, characterized by continual colonization and
emergence. Both of these processes are problematic for our question. If we
were to allow colonization it could swamp any changes in our starting
community composition. Conversely, if we allowed the experiment to continue
for too long any macroinvertebrates with complex life cycles would emerge,
leaving us with no community to sample [@Lecraw2014]. We took two steps to
make sure that our treatment effects were not affected by colonization or
excessive emergence. To prevent colonization we surrounded bromeliads with
mosquito netting (mesh size approx. 1.5 mm). To prevent emergence we ended our
experiment after 12 days, based on the results of a pilot study that
confirmed that this was sufficient time for communities to change, but not so
long that bromeliads were empty.


### Analyses


*Question 2: less environmental signal among smaller organism types* 
The size-plasticity hypothesis predicts that the correlation between community composition and environment should increase in strength from small to large types of organism.  This correlation should be weaker for smaller organism types.
We tested this hypothesis with a permutation ANOVA (PERMANOVA), which measures
the amount of difference in community composition between treatment groups and
compares this to the expected distribution under a null hypothesis of no
treatment effects. In each PERMANOVA we used block as an error stratum,
meaning that permutations were performed within blocks. We repeated this
analysis for all three organism types, and at both "initial" and "final"
sampling dates (i.e. at the beginning and end of the experiment).

*Question 3: Particular traits are correlated with environmental signal*

The distance-based approaches described above test the response of the whole
community, but community-level responses are often driven by the response of a
smaller number of species. These species often possess particular traits which
correlate with their responses. We tested this hypothesis with multivariate
generalized linear models [@mvabund], which is a  model-based multivariate
alternative to distance-based methods [@Warton2012]. This technique is implemented in the R package `mvabund`  [@Wang2012; @mvabund]. We used this approach to fit the model:

$log(\mu_{jkl}) =  intercept_{j} + block_{jk} + bromeliad_{jl} + block \times bromeliad_{jkl}$

where $\mu_{jkl}$ is the response of species $j$ in block $k$ to the environment of bromeliad $l$. This model is used to predict the mean of a negative binomial distribution: 

$Y_{ij} \sim NegBin(\mu_{jkl}, \phi_{j})$

Here, $Y_{ij}$ is the abundance of species $j$ in plant $i$. The dispersion parameter, $\phi_{j}$, measures the variability of species $j$ (constant across sites). We fit these models to final community composition only.

This approach has three advantages that make it suitable for our application.
First, because it is based on GLMs, we are able to model the mean-variance
relationship common in count data. This characteristic of count data is often
problematic for distance-based metrics, which can conflate differences in
dispersion with differences in location [@Warton2012]. We are already testing
for dispersion and location effects in the separate analysis described above
with distance based methods. Therefore this multivariate GLM approach helps
confirm our findings by accounting for both within a different framework.
Second, because it is model-based, it allows us to test for an interaction
between our treatments (different bromeliad species) and blocks. Significance
in these tests is generated by permutation tests based on 1000 replications.
Third, mvabund also allows for estimating individual species-level responses, via a correction for repeated family-level testing [@Wang2012].
This lets us identify which species responded most to the environmental
differences, and to relate these to traits of these species. 

All statistical analyses were conducted in R [@rcore]. Code to reproduce the analysis published here is available at ***link to data***


## Results   


*Question 1: less beta diversity among smaller organism types*
All organism types showed the same decrease in mean distance to centroid at the end of the experiment -- there was no significant interaction between organism type and the effect of sampling time (Figure  3, Mixed effect model F~2,20~ = 0.44, p > 0.05). However, we did see an overall 22% decrease in the dispersion at the end of the experiment (F~1,20~ = 15.47, p < 0.05).

*Question 2: less environmental signal among smaller organism types*
Bromeliad species identity explains more variation in community composition of invertebrates, less for zooplankton and less still for bacteria (Figure  4: , Table  1. Similar to the dispersion result, we found that for all organism types, bromeliad species explained less of the variation in composition at the end of the experiment than at the beginning.

*Question 3: Particular traits are correlated with environmental signal*


We wanted to use the manyglm approach to measure test if smaller organism
types respond less to the same environmental gradient than larger ones. To do
this, we measured the percent of the total deviance explained by the
combination of $bromeliad_{jl}$ and $block \times bromeliad_{jkl}$ terms in
our model. These terms explained high proportions of deviance for insects and
zooplankton (71.38 and 69.72, respectively) and less for bacteria (24.17). This agrees with our hypothesis, and
with the PERMANOVA results reported above. We were obliged to combine terms
for this comparison, because there was always a significant interaction between
block and species in our models (ie, we could not examine main effects of
species independently; See Supplementary Material).

### Tables	



Table  1: Bromeliad species effects on the composition of three types of organisms, as determined by PERMANOVAs both before and 12 days after homogenization. Both F-ratios and R^2^ values are higher for macroinvertebrates than for zooplankton than for bacteria (before and after). Following homogenization, macroinvertebrate and bacterial communities both significantly diverged between bromeliad species. 

|                    |        | F~2,27~                            | p                            | R^2^                         |
| -------- | ------------------| ---------|--------- | ---------- |
| macroinvertebrates | before | 7.03 | 0.001 | 0.34 |
|                    | after  | 6.42 | 0.001 | 0.32 |
| zooplankton        | before | 2.59 | 0.008 | 0.16 |
|                    | after  | 1.75 | 0.158 | 0.11 |
| bacteria           | before | 0.69 | 0.085 | 0.05 |
|                    | after  | 0.63 | 0.027 | 0.04                             |


### Figures

![between](../figures/r2_plot.png)
Figure  4: The amount of variation (r2 from PERMANOVA) in faunal community composition explained by bromeliad species (i.e. the strength of the environmental signal) decreases from larger to smaller organisms.  The environmental signal in initial, undisturbed communities was removed by homogenization, but after 12 days of recovery, was again of similar strength in final macroinvertebrate and bacterial communities. 

![indiv](../figures/individual_responses.png)
Figure  5: Responses of individual species (or OTUs) to environmental variation. The percent of total deviance explained by each species is shown on the y-axis. Points are shaded if the adjusted p-value for that species regression was significant.


## Discussion

We tested three predictions of the size-plasticity hypothesis. We
asked whether smaller organisms showed a weaker relationship to environmental
variation than larger organisms (Question 2). We found this pattern in two
different multivariate tests (Question 3). Third, we asked which taxa were
driving the response, and found that chironomids, oligochaetes and one
zooplankton species in particular explained more of the deviance in
multivariate response.
<!-- That is the result. Now somewhere you need to talk about the explanation
for these taxa driving the trend. Looks like they were the only ones
abundant enough to be sig.  And –watch out! – oligochaetes are not active
dispersers. In the Farjalla et al. paper we were asked to do the analyses
with and without non-insects (oligochaetes and ostracods) to figure out
their influence. -->

We found that the strength
of the environmental signal followed the pattern expected by the size-
plasticity hypothesis: macroinvertebrates > zooplankton > bacteria. These effects were similar in direction and magnitude to the observed relationships at the start of the experiment. We found slightly different results
from the multivariate GLM approach: while macroinvertebrates still showed a
large response to environment and bacteria a small response, zooplankton
showed a response nearly as strong as for insects. One explanation for this is
that in creating global dispersal, we have removed the environmental signal
from active dispersal for insects (which may base oviposition decisions in
response to the environment). Our results are also consistent with those of
Soininen et al. [-@Soininen2013], who found a similar negative correlation
between organism size and environmental signal (in their case, zooplankton,
phytoplankton and zooplankton). Interestingly, they used a different
statistical framework: large-scale species distribution models instead of
local observations or experiments. As Farjalla et al. predicted, the strength
of environmental filtering is in negative proportion to body size. Over the
same time interval, insects and zooplankton developed more of a response to
the environment than did bacteria.

We have confirmed a hypothesis made by observational methods with a
manipulative experiment and a complementary statistical approach. In our
experiment we removed the variation in community composition between habitats,
and were essentially able to watch the recovery of beta diversity in our
system.  Our results offer support for the size plasticity hypothesis, and
offer insight into the development of beta diversity in three different types
of organisms.

Our experimental conditions are missing several elements that make important contributions to community composition. One such element is the effect of species interactions. Species interactions are important in determining community compositon in many communities. The distribution of adults -- of course, this has nothing to do with the differences in the community composition in response to bromeliad variation. 

We are also missing on interactions between terrestrial adults and the matrix around the bromeliads. Bromelaids are different from each other, but not all those differences would be correlated with differences in adult distriubution. For example, bromeliads in the shade probably have more detritus, but shaded plants may well have more spiders present to kill insects. Likewise exposed bromeliads may have a higher risk of bird predation. 

However another source of variation in community composition is also removed here, and this one is potentially more important. That is the interactions among individuals in our experiment. Our experimental design allowed only some of the interactions to persist in the community. For example, predation is probably important in determining the distribution of different species. 

predator-prey interactions 

Higher heat in more exposed bromeliads makes the predators forage more aggressively and that leads to more insect community death. How specific is a predator's diet, and how much variance exists among prey in vulnerability? that makes both the exposed habitats both a stronger filter -- supposing predators simply have a higher feeding rate, but not different diet preferences. 
If predators are killing more of their favourites, then the habitat is more strongly filtered. This would be the case even if they respond to a simple trait, something like body size.
If they are killing at random, merely say the first ones they encounter, this would not create more environmental signal per se. 

competition

How would competition be different in the different habitats? Well, competition in this system is probably a priority effect. priority effects occur when one species establishes in a community before another, developing a large enough population. In natural plants, if there is a competitor, insects might either choose not to oviposit in a bromeliad, or oviposit there but have reduced survival. In our experiment this did not occur because there was no time. Instead individuals were combined together and may not have had sufficient time to influence each other's survival. However how much of this variation is actually relatd to the environment? well probably rather little. There is probably no reason to expect that species interactions are more extreme in different habitats

Except that eg in Aechmaea they may well interact more directly, causing more predation or more competition, and more exposure to heat, where the higher structure of Vresia or Neoregelia might offer refuges from both of these. 

Adult behaviour

oviposition behaviour in this system often comes with female choice. Females respond to the presence of predators, and potentially of competitors, and sometimes even the amount of resources that are visible. Why is this interesting? well it means that environmental variables can have an effect on the dispersal to the community note mrely the survival of animals in this community once they arrive there. And so, when local variables work in that way, they can have a much larger effect on the local community composition. 
IN a similar way, the matrix around the bromeliad can be importnat for dispersal into the communities. by that I mean that sometimes adults get killed and eaten by predators in the area around the bromeliads. For example, more exposed sites may experience more bird predation, while more forested sites have more of another kind of predation, in this case 

Why is this important to the world of ecology?
Well all systems that we know of contain this same wide range of organism sizes. And many systems are also characterized by an environmental gradient. It seems like future attempts to measure evnerionmental structure might indeed want to track body size as a critical feature of the organism group studied. also the scale of environmental variation is very important. Also it does indeed seem like smaller organisms may have larger fundamental niches, being less structured by the environment and responding less to a maniupalation of thier environment. A natural next step would be to quantify the actual niche size of these organisms, by measuring their ability to survive and reproduce at the extremes of the environmental gradient found in bromeliads. usually, measurements of the niche take place only over organisms of very similar size. 

Our analysis of bacterial species individually found a large number of OTUs which responded to the environment. This is due to a very high number of taxa that are found only once, giving the appearance of extremely high environmental signal. If instead we consider only those OTUs found in multiple bromeliads, we find a much weaker effect. This result is partly difficult to interpret based on the nature of the DGGE technique. This provides only a measure of how different a bacterial community is, and as such each OTU may actually represent multiple groups of baterial species. It is also impossible to relate DGGE otus to any trait of the taxa, which might account for either the traits that allow them tobe present in a community or the different traits that might impact the community. However DGGE is indeed the same technique that was used before. And for our purposes it is sufficient to quantify variation in microbial communities. For the purposes of this study we needed to know how variable microbial communities are, and to what extent that was correlated with the environment. 
There is a possibility that our inability to detect an environmental signal in bacteria was hampered by this poor taxonomic resolution. In other words, perhaps we cannot tell anything about the bacteria, and we are in fact picking up the signal, not of increasing plasticity, but of decreasing taxonomic resolution. the "taxonomic impediment" is of course greater the smaller a taxon is. As a check against this, we checked the multivariate dispersion of each community, confirming that it was smaller at the end of the experiment than at the beginning. This is what we'd expect. At the beginning, when we observed the composition of each plant, we found that each had a very large variation in their composition. We then homogenized them removing all variation. We allowed only two weeks for variation to emerge. thus we expect that the variation in the final communities should be much smaller than in the full community, because they have less time. If, on the other hand, our method simply did not work and could not detect any change at all in the bacterial community, we would not find any change in the multivariate dispersion at all. As it is, we find a decrease in the dispersion of the bacteria that is on par with what we observed in the zooplankton. which is a good sign that our treatments did indeed reduce variation, just that when they did increase them again the resulting variation did not correlate with the environment. 
Alternative methods are now available to more completely quantify the bacterial communities. Future studies should take advantage of these more complete methods. they give a better census of the entire microbial community. Additionally, they provide a means of confirming what these organisms actually do in a community. 
 

In our study, we use morphospecies at one taxonomic level for insects, and a much coarser one for zooplankton, and at a very crude level for bacteria. Our method is robust to this variation in resolution, because we compare only before and after homoegnization within each taxonomic group. However, another exciting future direction would be to compare how the number of species in a taxonomic group alters its sensitivity to the environment. suppose a very species-rich assemblage and a very species-poor one are compared along the same gradient. This is interesting in two directions. One , in fact the more speciose groiup might have on average smaller niches (due to competition) on the other hand, more speciose groups are also likely to be smaller in body size, and according to our result have larger fundamental groups. also, in more speciose groups there are possibly more species interactions, which might cause competition (ie the different niche breathds I just mentioned) but also they might facilitate each other, or might show a whole host of species interactions (eg sharing a predator). 

Vellends' four processes:
speciation
* unlikely
* might have occurred in the microbes?

By manipulating the starting communities, we altered the process of community assembly to measure the strength of only a single effect: selection. a single process. 
Speciation is unlikely to have occurred in our samples, but does maybe, among the smallest organisms. For example, in strong resource gradients different populations of microbes can certainly evolve. However its not likely that any divergence in microbes would create such a strong difference in DGGE, nor not at all certain that any such process would affect the behaviour of other species. thus its probably an invisible process to our experiment. 

dispersal
* removed in our study
* that was the point

The main goal of our study was to examine the effects of removing dispersal. 

drif
* random death did indeed occur
* while it might have been higher or lower in any given plant, this would not have enhanced the environmental signal.
selection
* this was essentially an expeiment to measure the strenght of seleciton on different organism groups. We found that larger organisms do indeed experience higher seleciton than smaller organisms. 

What does this mean for the park at Jurubatiba? Well the landscape there is composed of different taxa of bromeliads. it is a landscape characterized by a large number of very different communities, of different shade and sun habitats, probably more than the average amount of heterogeneity. We show that this heterogeneity may well affect the distribution of different groups to a different extent. For example larger species are probably very patchily distributed, only in those bromeliads where they can persist, while bacterial and zooplankton species are probably distributed more evenly across the landscape. fhjk


## References

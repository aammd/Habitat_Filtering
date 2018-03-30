---
title: "Supplementary Material"
author: "A. Andrew M. MacDonald"
output:
  pdf_document:
    latex_engine: xelatex
    includes:
      in_header: formatting/myheader_suppmatt.tex
    toc: true
  md_document: default
  html_document: default
geometry: margin=1in
fontsize: 12pt
---

This Supplementary document contains three sections. First is a section showing the results from the PERMANOVAs reported in the main manuscript. Second is some NMDS plots which show the communities which represent our experimental results.

## PERMANOVAS

In the main text we report differences among three organismal groups (insects, zooplankton and bacteria) in their sensitivity to environmental gradients. In this system, the environmental gradient is represented by differences between three bromeliad species which grow in different habitats. Figure 3 in the text reports the differences in these environmental effects as the R^2^ value from PERMANOVAs. This Supplement reports these PERMANOVA tables in full. 



## Before homogenization

### Macroinvertebrates

|          | Df| SumsOfSqs|  MeanSqs|  F.Model|       R2| Pr(>F)|
|:---------|--:|---------:|--------:|--------:|--------:|------:|
|species   |  2|  27029.33| 13514.67| 7.032039| 0.342491|  0.001|
|Residuals | 27|  51890.50|  1921.87|       NA| 0.657509|     NA|
|Total     | 29|  78919.83|       NA|       NA| 1.000000|     NA|

### Zooplankton

|          | Df| SumsOfSqs|  MeanSqs|  F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|--------:|--------:|---------:|------:|
|species   |  2|  15648.27| 7824.133| 2.583128| 0.1606111|  0.005|
|Residuals | 27|  81781.30| 3028.937|       NA| 0.8393889|     NA|
|Total     | 29|  97429.57|       NA|       NA| 1.0000000|     NA|

### Bacteria

|          | Df| SumsOfSqs|  MeanSqs|   F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|--------:|---------:|---------:|------:|
|species   |  2|  22.46667| 11.23333| 0.6855787| 0.0483293|  0.131|
|Residuals | 27| 442.40000| 16.38519|        NA| 0.9516707|     NA|
|Total     | 29| 464.86667|       NA|        NA| 1.0000000|     NA|

## 12 Days after homogenization
### Macroinvertebrates

|          | Df| SumsOfSqs|   MeanSqs|  F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|---------:|--------:|---------:|------:|
|species   |  2|  59463.67| 29731.833| 6.418015| 0.3222216|  0.001|
|Residuals | 27| 125079.10|  4632.559|       NA| 0.6777784|     NA|
|Total     | 29| 184542.77|        NA|       NA| 1.0000000|     NA|

### Zooplankton

|          | Df| SumsOfSqs|   MeanSqs|  F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|---------:|--------:|---------:|------:|
|species   |  2|    3116.6| 1558.3000| 1.757114| 0.1151669|  0.163|
|Residuals | 27|   23945.0|  886.8519|       NA| 0.8848331|     NA|
|Total     | 29|   27061.6|        NA|       NA| 1.0000000|     NA|

### Bacteria

|          | Df| SumsOfSqs|  MeanSqs|   F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|--------:|---------:|---------:|------:|
|species   |  2|  23.33333| 11.66667| 0.6344411| 0.0448862|  0.032|
|Residuals | 27| 496.50000| 18.38889|        NA| 0.9551138|     NA|
|Total     | 29| 519.83333|       NA|        NA| 1.0000000|     NA|


## Ordination figures

In the PERMANOVA results above, we analysed community data using block as a random factor and bromeliad species as the environmental variable. In the following NMDS plots, we split the data up differently for display purposes: here, we show each block separately, with points grouped by the time of observation (before or after the experiment) and by the environment in which they are found. In the plots that follow, two clouds of points represent differences before the experiment ("initial", round points) and 12 days after ("final", square points). Three colours represent the three species: _Aechmea nudicaulis_ (yellow points; full sun habitats), _Vriesea neoglutinosa_ (green points; partial shade), and _Neoregelia cruenta_ (purple points; full shade).

![](../figures/inverts.pdf)
![](../figures/zoop.pdf)
![](../figures/bact.pdf)


<!-- # multivariate GLM -->

<!-- results of multivariate GLMS -->

<!-- ## diagnositic plots for full models -->
<!-- ```{r} -->
<!-- plot(inverts_manyglm_fin) -->
<!-- ``` -->


<!-- ```{r} -->
<!-- plot(zoops_manyglm_fin) -->
<!-- ``` -->

<!-- ```{r} -->

<!-- plot(bact_manyglm_fin) -->
<!-- ``` -->

<!-- ## ANOVA tables for full models -->
<!-- Analyis of deviance  -->

<!-- ```{r} -->
<!-- kable(inverts_manyglm_table) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- kable(zoops_manyglm_table) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- kable(bact_manyglm_table) -->
<!-- ``` -->


<!-- ## manyglm -->


<!-- test for interactions -->
<!-- ```{r} -->
<!-- #anova(inverts_manyglm_fin, inverts_manyglm_fin_add) -->

<!-- ``` -->

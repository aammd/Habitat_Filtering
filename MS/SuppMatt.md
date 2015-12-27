---
title: "Supplementary Material"
author: "A. Andrew M. MacDonald; Diane S. Srivastava; Vinicius"
output:
  pdf_document:
    latex_engine: xelatex
    includes:
      in_header: formatting/myheader_suppmatt.tex
    toc: true
  md_document: default
  html_document: default
  word_document:
    reference_docx: reference.docx
geometry: margin=1in
fontsize: 12pt
---




# Exploratory figures

![](../figures/inverts.pdf)
![](../figures/zoop.pdf)
![](../figures/bact.pdf)

# Dispersion

mixed effect ANOVA table

|            | numDF| denDF|     F-value|   p-value|
|:-----------|-----:|-----:|-----------:|---------:|
|(Intercept) |     1|    20| 837.1699446| 0.0000000|
|taxa        |     2|    20|   9.9229148| 0.0010150|
|timing      |     1|    20|  15.4715289| 0.0008221|
|taxa:timing |     2|    20|   0.4375683| 0.6516385|

residual plot for the dispersion model
![plot of chunk unnamed-chunk-3](figure/SuppMatt__unnamed-chunk-3-1.png) 

![](../figures/one_one_plot.pdf)
Figure  1: This is the different mean differences to centroid on the same plot. shown is the 1:1 line.

# PERMANOVAS




## initial

### inverts

|          | Df| SumsOfSqs|  MeanSqs|  F.Model|       R2| Pr(>F)|
|:---------|--:|---------:|--------:|--------:|--------:|------:|
|species   |  2|  27029.33| 13514.67| 7.032039| 0.342491|  0.001|
|Residuals | 27|  51890.50|  1921.87|       NA| 0.657509|     NA|
|Total     | 29|  78919.83|       NA|       NA| 1.000000|     NA|

### zooplankton

|          | Df| SumsOfSqs|  MeanSqs| F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|--------:|-------:|---------:|------:|
|species   |  2|   15666.0| 7833.000|  2.5853| 0.1607244|  0.008|
|Residuals | 27|   81805.2| 3029.822|      NA| 0.8392756|     NA|
|Total     | 29|   97471.2|       NA|      NA| 1.0000000|     NA|

### bacteria

|          | Df| SumsOfSqs|  MeanSqs|   F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|--------:|---------:|---------:|------:|
|species   |  2|  22.46667| 11.23333| 0.6855787| 0.0483293|  0.101|
|Residuals | 27| 442.40000| 16.38519|        NA| 0.9516707|     NA|
|Total     | 29| 464.86667|       NA|        NA| 1.0000000|     NA|

## final
### insects

|          | Df| SumsOfSqs|   MeanSqs|  F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|---------:|--------:|---------:|------:|
|species   |  2|  59463.67| 29731.833| 6.418015| 0.3222216|  0.001|
|Residuals | 27| 125079.10|  4632.559|       NA| 0.6777784|     NA|
|Total     | 29| 184542.77|        NA|       NA| 1.0000000|     NA|

### zooplankton

|          | Df| SumsOfSqs|   MeanSqs|  F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|---------:|--------:|---------:|------:|
|species   |  2|  3104.733| 1552.3667| 1.749576| 0.1147295|  0.125|
|Residuals | 27| 23956.600|  887.2815|       NA| 0.8852705|     NA|
|Total     | 29| 27061.333|        NA|       NA| 1.0000000|     NA|

### bacteria

|          | Df| SumsOfSqs|  MeanSqs|   F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|--------:|---------:|---------:|------:|
|species   |  2|  23.33333| 11.66667| 0.6344411| 0.0448862|  0.016|
|Residuals | 27| 496.50000| 18.38889|        NA| 0.9551138|     NA|
|Total     | 29| 519.83333|       NA|        NA| 1.0000000|     NA|



# multivariate GLM

results of multivariate GLMS

## diagnositic plots for full models
![plot of chunk unnamed-chunk-11](figure/SuppMatt__unnamed-chunk-11-1.png) 


![plot of chunk unnamed-chunk-12](figure/SuppMatt__unnamed-chunk-12-1.png) 

![plot of chunk unnamed-chunk-13](figure/SuppMatt__unnamed-chunk-13-1.png) 

## ANOVA tables for full models
Analyis of deviance 


|term          | Res.Df| Df.diff|      Dev| Pr(>Dev)|
|:-------------|------:|-------:|--------:|--------:|
|(Intercept)   |     29|      NA|       NA|       NA|
|Block         |     25|       4| 109.7867|    0.176|
|species       |     23|       2| 123.4727|    0.002|
|Block:species |     15|       8| 150.3358|    0.058|


|term          | Res.Df| Df.diff|      Dev| Pr(>Dev)|
|:-------------|------:|-------:|--------:|--------:|
|(Intercept)   |     29|      NA|       NA|       NA|
|Block         |     25|       4| 46.35160|    0.098|
|species       |     23|       2| 55.03097|    0.002|
|Block:species |     15|       8| 51.67825|    0.018|


|term          | Res.Df| Df.diff|        Dev| Pr(>Dev)|
|:-------------|------:|-------:|----------:|--------:|
|(Intercept)   |     29|      NA|         NA|       NA|
|Block         |     25|       4| 2210.04170|     0.02|
|species       |     23|       2|  673.64723|     0.02|
|Block:species |     15|       8|   30.72662|     0.10|

## manyglm


test for interactions



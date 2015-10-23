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

```r
anova(disp_mixed) %>% 
    knitr::kable()
```



|            | numDF| denDF|     F-value|   p-value|
|:-----------|-----:|-----:|-----------:|---------:|
|(Intercept) |     1|    20| 703.4117822| 0.0000000|
|taxa        |     2|    20|   3.8561996| 0.0383318|
|timing      |     1|    20|  16.1076135| 0.0006818|
|taxa:timing |     2|    20|   0.3875174| 0.6837264|

residual plot for the dispersion model

```r
plot(disp_mixed)
```

![plot of chunk unnamed-chunk-3](figure/SuppMatt__unnamed-chunk-3-1.png) 

![](../figures/one_one_plot.pdf)
Figure  1: This is the different mean differences to centroid on the same plot. shown is the 1:1 line.

# PERMANOVAS




## initial

### inverts

```r
get_adonis_table(inverts_adonis_ini)
```



|          | Df| SumsOfSqs|  MeanSqs|  F.Model|       R2| Pr(>F)|
|:---------|--:|---------:|--------:|--------:|--------:|------:|
|species   |  2|  27029.33| 13514.67| 7.032039| 0.342491|  0.001|
|Residuals | 27|  51890.50|  1921.87|       NA| 0.657509|     NA|
|Total     | 29|  78919.83|       NA|       NA| 1.000000|     NA|

### zooplankton

```r
get_adonis_table(zoops_adonis_ini)
```



|          | Df| SumsOfSqs|  MeanSqs|  F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|--------:|--------:|---------:|------:|
|species   |  2|  15601.27| 7800.633| 2.578766| 0.1603833|  0.004|
|Residuals | 27|  81673.60| 3024.948|       NA| 0.8396167|     NA|
|Total     | 29|  97274.87|       NA|       NA| 1.0000000|     NA|

### bacteria

```r
get_adonis_table(bact_adonis_ini)
```



|          | Df| SumsOfSqs|  MeanSqs|   F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|--------:|---------:|---------:|------:|
|species   |  2|  22.46667| 11.23333| 0.6855787| 0.0483293|  0.096|
|Residuals | 27| 442.40000| 16.38519|        NA| 0.9516707|     NA|
|Total     | 29| 464.86667|       NA|        NA| 1.0000000|     NA|

## final
### insects

```r
get_adonis_table(inverts_adonis_fin)
```



|          | Df| SumsOfSqs|   MeanSqs|  F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|---------:|--------:|---------:|------:|
|species   |  2|  59463.67| 29731.833| 6.418015| 0.3222216|  0.002|
|Residuals | 27| 125079.10|  4632.559|       NA| 0.6777784|     NA|
|Total     | 29| 184542.77|        NA|       NA| 1.0000000|     NA|

### zooplankton

```r
get_adonis_table(zoops_adonis_fin)
```



|          | Df| SumsOfSqs|   MeanSqs|  F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|---------:|--------:|---------:|------:|
|species   |  2|  3065.733| 1532.8667| 1.732589| 0.1137423|  0.131|
|Residuals | 27| 23887.600|  884.7259|       NA| 0.8862577|     NA|
|Total     | 29| 26953.333|        NA|       NA| 1.0000000|     NA|

### bacteria

```r
get_adonis_table(bact_adonis_fin)
```



|          | Df| SumsOfSqs|  MeanSqs|   F.Model|        R2| Pr(>F)|
|:---------|--:|---------:|--------:|---------:|---------:|------:|
|species   |  2|  23.33333| 11.66667| 0.6344411| 0.0448862|  0.016|
|Residuals | 27| 496.50000| 18.38889|        NA| 0.9551138|     NA|
|Total     | 29| 519.83333|       NA|        NA| 1.0000000|     NA|



# multivariate GLM

results of multivariate GLMS


```r
plot(inverts_manyglm_fin)
```

![plot of chunk unnamed-chunk-11](figure/SuppMatt__unnamed-chunk-11-1.png) 



```r
plot(zoops_manyglm_fin)
```

![plot of chunk unnamed-chunk-12](figure/SuppMatt__unnamed-chunk-12-1.png) 


```r
plot(bact_manyglm_fin)
```

![plot of chunk unnamed-chunk-13](figure/SuppMatt__unnamed-chunk-13-1.png) 

## manyglm


test for interactions

```r
#anova(inverts_manyglm_fin, inverts_manyglm_fin_add)
```


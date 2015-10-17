---
title: "Supplementary Material"
author: "A. Andrew M. MacDonald; Diane S. Srivastava; Vinicius"
output:
  pdf_document:
    latex_engine: xelatex
    includes:
      in_header: formatting/myheader_suppmatt.tex
  md_document: default
  html_document: default
  word_document:
    reference_docx: reference.docx
geometry: margin=1in
fontsize: 12pt
---

# Before

## insects

```r
inverts_adonis_ini
```


Call:
adonis(formula = Data[["taxa"]] ~ species, data = Data[["factors"]],      method = "euclid", strata = .strata) 

Blocks:  strata 
Permutation: free
Number of permutations: 999

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)    
species    2     27029 13514.7   7.032 0.34249  0.001 ***
Residuals 27     51891  1921.9         0.65751           
Total     29     78920                 1.00000           
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

## zooplankton

```r
zoops_adonis_ini
```


Call:
adonis(formula = Data[["taxa"]] ~ species, data = Data[["factors"]],      method = "euclid", strata = .strata) 

Blocks:  strata 
Permutation: free
Number of permutations: 999

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)   
species    2     15601  7800.6  2.5788 0.16038  0.004 **
Residuals 27     81674  3024.9         0.83962          
Total     29     97275                 1.00000          
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

## bacteria

```r
bact_adonis_ini
```


Call:
adonis(formula = Data[["taxa"]] ~ species, data = Data[["factors"]],      method = "euclid", strata = .strata) 

Blocks:  strata 
Permutation: free
Number of permutations: 999

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)  
species    2     22.47  11.233 0.68558 0.04833  0.096 .
Residuals 27    442.40  16.385         0.95167         
Total     29    464.87                 1.00000         
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# After
## insects

```r
inverts_adonis_fin
```


Call:
adonis(formula = Data[["taxa"]] ~ species, data = Data[["factors"]],      method = "euclid", strata = .strata) 

Blocks:  strata 
Permutation: free
Number of permutations: 999

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)   
species    2     59464 29731.8   6.418 0.32222  0.002 **
Residuals 27    125079  4632.6         0.67778          
Total     29    184543                 1.00000          
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

## zooplankton

```r
zoops_adonis_fin
```


Call:
adonis(formula = Data[["taxa"]] ~ species, data = Data[["factors"]],      method = "euclid", strata = .strata) 

Blocks:  strata 
Permutation: free
Number of permutations: 999

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)
species    2    3065.7 1532.87  1.7326 0.11374  0.131
Residuals 27   23887.6  884.73         0.88626       
Total     29   26953.3                 1.00000       

## bacteria

```r
bact_adonis_fin
```


Call:
adonis(formula = Data[["taxa"]] ~ species, data = Data[["factors"]],      method = "euclid", strata = .strata) 

Blocks:  strata 
Permutation: free
Number of permutations: 999

Terms added sequentially (first to last)

          Df SumsOfSqs MeanSqs F.Model      R2 Pr(>F)  
species    2     23.33  11.667 0.63444 0.04489  0.016 *
Residuals 27    496.50  18.389         0.95511         
Total     29    519.83                 1.00000         
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1


## dispersion anovas


```r
aovs_disp <- lapply(disper_list, anova)

lapply(aovs_disp, stargazer::stargazer)
```


% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.091 & 0.032 & 0.069 & 0.113 \\ 
Mean Sq & 2 & 0.040 & 0.041 & 0.011 & 0.069 \\ 
F value & 1 & 6.057 &  & 6.057 & 6.057 \\ 
Pr(\textgreater F) & 1 & 0.034 &  & 0.034 & 0.034 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.123 & 0.019 & 0.110 & 0.136 \\ 
Mean Sq & 2 & 0.074 & 0.089 & 0.011 & 0.136 \\ 
F value & 1 & 12.411 &  & 12.411 & 12.411 \\ 
Pr(\textgreater F) & 1 & 0.006 &  & 0.006 & 0.006 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.169 & 0.152 & 0.061 & 0.276 \\ 
Mean Sq & 2 & 0.045 & 0.024 & 0.028 & 0.061 \\ 
F value & 1 & 2.222 &  & 2.222 & 2.222 \\ 
Pr(\textgreater F) & 1 & 0.167 &  & 0.167 & 0.167 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.128 & 0.154 & 0.020 & 0.237 \\ 
Mean Sq & 2 & 0.022 & 0.003 & 0.020 & 0.024 \\ 
F value & 1 & 0.827 &  & 0.827 & 0.827 \\ 
Pr(\textgreater F) & 1 & 0.385 &  & 0.385 & 0.385 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.100 & 0.126 & 0.011 & 0.189 \\ 
Mean Sq & 2 & 0.015 & 0.006 & 0.011 & 0.019 \\ 
F value & 1 & 0.576 &  & 0.576 & 0.576 \\ 
Pr(\textgreater F) & 1 & 0.465 &  & 0.465 & 0.465 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.246 & 0.329 & 0.014 & 0.479 \\ 
Mean Sq & 2 & 0.031 & 0.024 & 0.014 & 0.048 \\ 
F value & 1 & 0.282 &  & 0.282 & 0.282 \\ 
Pr(\textgreater F) & 1 & 0.607 &  & 0.607 & 0.607 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.000 & 5.657 & 1 & 9 \\ 
Sum Sq & 2 & 0.225 & 0.084 & 0.165 & 0.284 \\ 
Mean Sq & 2 & 0.151 & 0.188 & 0.018 & 0.284 \\ 
F value & 1 & 15.469 &  & 15.469 & 15.469 \\ 
Pr(\textgreater F) & 1 & 0.003 &  & 0.003 & 0.003 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.559 & 0.762 & 0.020 & 1.098 \\ 
Mean Sq & 2 & 0.065 & 0.063 & 0.020 & 0.110 \\ 
F value & 1 & 0.186 &  & 0.186 & 0.186 \\ 
Pr(\textgreater F) & 1 & 0.675 &  & 0.675 & 0.675 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.000 & 5.657 & 1 & 9 \\ 
Sum Sq & 2 & 0.454 & 0.639 & 0.002 & 0.906 \\ 
Mean Sq & 2 & 0.052 & 0.069 & 0.002 & 0.101 \\ 
F value & 1 & 0.024 &  & 0.024 & 0.024 \\ 
Pr(\textgreater F) & 1 & 0.880 &  & 0.880 & 0.880 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.564 & 0.650 & 0.105 & 1.023 \\ 
Mean Sq & 2 & 0.104 & 0.002 & 0.102 & 0.105 \\ 
F value & 1 & 1.023 &  & 1.023 & 1.023 \\ 
Pr(\textgreater F) & 1 & 0.336 &  & 0.336 & 0.336 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.246 & 0.329 & 0.014 & 0.479 \\ 
Mean Sq & 2 & 0.031 & 0.024 & 0.014 & 0.048 \\ 
F value & 1 & 0.282 &  & 0.282 & 0.282 \\ 
Pr(\textgreater F) & 1 & 0.607 &  & 0.607 & 0.607 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.224 & 0.316 & 0.001 & 0.448 \\ 
Mean Sq & 2 & 0.023 & 0.031 & 0.001 & 0.045 \\ 
F value & 1 & 0.017 &  & 0.017 & 0.017 \\ 
Pr(\textgreater F) & 1 & 0.898 &  & 0.898 & 0.898 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:04 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.292 & 0.322 & 0.065 & 0.520 \\ 
Mean Sq & 2 & 0.058 & 0.009 & 0.052 & 0.065 \\ 
F value & 1 & 1.248 &  & 1.248 & 1.248 \\ 
Pr(\textgreater F) & 1 & 0.290 &  & 0.290 & 0.290 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:04 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.190 & 0.223 & 0.033 & 0.347 \\ 
Mean Sq & 2 & 0.034 & 0.002 & 0.033 & 0.035 \\ 
F value & 1 & 0.938 &  & 0.938 & 0.938 \\ 
Pr(\textgreater F) & 1 & 0.356 &  & 0.356 & 0.356 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 

% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:04 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lccccc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
Statistic & \multicolumn{1}{c}{N} & \multicolumn{1}{c}{Mean} & \multicolumn{1}{c}{St. Dev.} & \multicolumn{1}{c}{Min} & \multicolumn{1}{c}{Max} \\ 
\hline \\[-1.8ex] 
Df & 2 & 5.500 & 6.364 & 1 & 10 \\ 
Sum Sq & 2 & 0.162 & 0.226 & 0.002 & 0.322 \\ 
Mean Sq & 2 & 0.017 & 0.021 & 0.002 & 0.032 \\ 
F value & 1 & 0.062 &  & 0.062 & 0.062 \\ 
Pr(\textgreater F) & 1 & 0.808 &  & 0.808 & 0.808 \\ 
\hline \\[-1.8ex] 
\end{tabular} 
\end{table} 
$inverts_Baker
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.091 & 0.032 & 0.069 & 0.113 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.040 & 0.041 & 0.011 & 0.069 \\\\ "                                                                                                         
[15] "F value & 1 & 6.057 &  & 6.057 & 6.057 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.034 &  & 0.034 & 0.034 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$inverts_Davidson
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.123 & 0.019 & 0.110 & 0.136 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.074 & 0.089 & 0.011 & 0.136 \\\\ "                                                                                                         
[15] "F value & 1 & 12.411 &  & 12.411 & 12.411 \\\\ "                                                                                                           
[16] "Pr(\\textgreater F) & 1 & 0.006 &  & 0.006 & 0.006 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$inverts_Eccleson
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.169 & 0.152 & 0.061 & 0.276 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.045 & 0.024 & 0.028 & 0.061 \\\\ "                                                                                                         
[15] "F value & 1 & 2.222 &  & 2.222 & 2.222 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.167 &  & 0.167 & 0.167 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$inverts_Tennant
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.128 & 0.154 & 0.020 & 0.237 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.022 & 0.003 & 0.020 & 0.024 \\\\ "                                                                                                         
[15] "F value & 1 & 0.827 &  & 0.827 & 0.827 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.385 &  & 0.385 & 0.385 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$inverts_Smith
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.100 & 0.126 & 0.011 & 0.189 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.015 & 0.006 & 0.011 & 0.019 \\\\ "                                                                                                         
[15] "F value & 1 & 0.576 &  & 0.576 & 0.576 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.465 &  & 0.465 & 0.465 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$zoops_Baker
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.246 & 0.329 & 0.014 & 0.479 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.031 & 0.024 & 0.014 & 0.048 \\\\ "                                                                                                         
[15] "F value & 1 & 0.282 &  & 0.282 & 0.282 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.607 &  & 0.607 & 0.607 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$zoops_Davidson
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.000 & 5.657 & 1 & 9 \\\\ "                                                                                                                      
[13] "Sum Sq & 2 & 0.225 & 0.084 & 0.165 & 0.284 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.151 & 0.188 & 0.018 & 0.284 \\\\ "                                                                                                         
[15] "F value & 1 & 15.469 &  & 15.469 & 15.469 \\\\ "                                                                                                           
[16] "Pr(\\textgreater F) & 1 & 0.003 &  & 0.003 & 0.003 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$zoops_Eccleson
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.559 & 0.762 & 0.020 & 1.098 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.065 & 0.063 & 0.020 & 0.110 \\\\ "                                                                                                         
[15] "F value & 1 & 0.186 &  & 0.186 & 0.186 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.675 &  & 0.675 & 0.675 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$zoops_Tennant
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.000 & 5.657 & 1 & 9 \\\\ "                                                                                                                      
[13] "Sum Sq & 2 & 0.454 & 0.639 & 0.002 & 0.906 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.052 & 0.069 & 0.002 & 0.101 \\\\ "                                                                                                         
[15] "F value & 1 & 0.024 &  & 0.024 & 0.024 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.880 &  & 0.880 & 0.880 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$zoops_Smith
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.564 & 0.650 & 0.105 & 1.023 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.104 & 0.002 & 0.102 & 0.105 \\\\ "                                                                                                         
[15] "F value & 1 & 1.023 &  & 1.023 & 1.023 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.336 &  & 0.336 & 0.336 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$bact_Baker
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:03 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.246 & 0.329 & 0.014 & 0.479 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.031 & 0.024 & 0.014 & 0.048 \\\\ "                                                                                                         
[15] "F value & 1 & 0.282 &  & 0.282 & 0.282 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.607 &  & 0.607 & 0.607 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$bact_Davidson
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:04 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.224 & 0.316 & 0.001 & 0.448 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.023 & 0.031 & 0.001 & 0.045 \\\\ "                                                                                                         
[15] "F value & 1 & 0.017 &  & 0.017 & 0.017 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.898 &  & 0.898 & 0.898 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$bact_Eccleson
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:04 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.292 & 0.322 & 0.065 & 0.520 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.058 & 0.009 & 0.052 & 0.065 \\\\ "                                                                                                         
[15] "F value & 1 & 1.248 &  & 1.248 & 1.248 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.290 &  & 0.290 & 0.290 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$bact_Tennant
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:04 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.190 & 0.223 & 0.033 & 0.347 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.034 & 0.002 & 0.033 & 0.035 \\\\ "                                                                                                         
[15] "F value & 1 & 0.938 &  & 0.938 & 0.938 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.356 &  & 0.356 & 0.356 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             

$bact_Smith
 [1] ""                                                                                                                                                          
 [2] "% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu"                                                 
 [3] "% Date and time: Thu, Oct 15, 2015 - 07:29:04 PM"                                                                                                          
 [4] "\\begin{table}[!htbp] \\centering "                                                                                                                        
 [5] "  \\caption{} "                                                                                                                                            
 [6] "  \\label{} "                                                                                                                                              
 [7] "\\begin{tabular}{@{\\extracolsep{5pt}}lccccc} "                                                                                                            
 [8] "\\\\[-1.8ex]\\hline "                                                                                                                                      
 [9] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[10] "Statistic & \\multicolumn{1}{c}{N} & \\multicolumn{1}{c}{Mean} & \\multicolumn{1}{c}{St. Dev.} & \\multicolumn{1}{c}{Min} & \\multicolumn{1}{c}{Max} \\\\ "
[11] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[12] "Df & 2 & 5.500 & 6.364 & 1 & 10 \\\\ "                                                                                                                     
[13] "Sum Sq & 2 & 0.162 & 0.226 & 0.002 & 0.322 \\\\ "                                                                                                          
[14] "Mean Sq & 2 & 0.017 & 0.021 & 0.002 & 0.032 \\\\ "                                                                                                         
[15] "F value & 1 & 0.062 &  & 0.062 & 0.062 \\\\ "                                                                                                              
[16] "Pr(\\textgreater F) & 1 & 0.808 &  & 0.808 & 0.808 \\\\ "                                                                                                  
[17] "\\hline \\\\[-1.8ex] "                                                                                                                                     
[18] "\\end{tabular} "                                                                                                                                           
[19] "\\end{table} "                                                                                                                                             
![](../figures/inverts.pdf)
![](../figures/zoop.pdf)
![](../figures/bact.pdf)

![](../figures/one_one_plot.pdf)


```r
disp_difs_long  %>% 
  lm(value ~ taxa * timing, data = .) %>% 
  summary
```

```
## 
## Call:
## lm(formula = value ~ taxa * timing, data = .)
## 
## Residuals:
##       Min        1Q    Median        3Q       Max 
## -0.092481 -0.034698 -0.003641  0.029661  0.160591 
## 
## Coefficients:
##                    Estimate Std. Error t value Pr(>|t|)    
## (Intercept)         0.38495    0.01783  21.592  < 2e-16 ***
## taxa.L              0.02429    0.03088   0.787 0.439221    
## taxa.Q             -0.06380    0.03088  -2.066 0.049783 *  
## timingfinal        -0.10119    0.02521  -4.013 0.000509 ***
## taxa.L:timingfinal  0.02374    0.04367   0.544 0.591712    
## taxa.Q:timingfinal  0.03024    0.04367   0.692 0.495293    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.06905 on 24 degrees of freedom
## Multiple R-squared:  0.5061,	Adjusted R-squared:  0.4032 
## F-statistic: 4.919 on 5 and 24 DF,  p-value: 0.00307
```



```r
disp_difs_long  %>% 
  lm(value ~ taxa * timing, data = .) %>% 
  stargazer()
```


% Table created by stargazer v.5.1 by Marek Hlavac, Harvard University. E-mail: hlavac at fas.harvard.edu
% Date and time: Thu, Oct 15, 2015 - 07:29:04 PM
\begin{table}[!htbp] \centering 
  \caption{} 
  \label{} 
\begin{tabular}{@{\extracolsep{5pt}}lc} 
\\[-1.8ex]\hline 
\hline \\[-1.8ex] 
 & \multicolumn{1}{c}{\textit{Dependent variable:}} \\ 
\cline{2-2} 
\\[-1.8ex] & value \\ 
\hline \\[-1.8ex] 
 taxa.L & 0.024 \\ 
  & (0.031) \\ 
  & \\ 
 taxa.Q & $-$0.064$^{**}$ \\ 
  & (0.031) \\ 
  & \\ 
 timingfinal & $-$0.101$^{***}$ \\ 
  & (0.025) \\ 
  & \\ 
 taxa.L:timingfinal & 0.024 \\ 
  & (0.044) \\ 
  & \\ 
 taxa.Q:timingfinal & 0.030 \\ 
  & (0.044) \\ 
  & \\ 
 Constant & 0.385$^{***}$ \\ 
  & (0.018) \\ 
  & \\ 
\hline \\[-1.8ex] 
Observations & 30 \\ 
R$^{2}$ & 0.506 \\ 
Adjusted R$^{2}$ & 0.403 \\ 
Residual Std. Error & 0.069 (df = 24) \\ 
F Statistic & 4.919$^{***}$ (df = 5; 24) \\ 
\hline 
\hline \\[-1.8ex] 
\textit{Note:}  & \multicolumn{1}{r}{$^{*}$p$<$0.1; $^{**}$p$<$0.05; $^{***}$p$<$0.01} \\ 
\end{tabular} 
\end{table} 


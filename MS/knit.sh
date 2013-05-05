# copy the latest bibliography from Mendeley's export
# cp ~/Documents/Work/Reference/BibTex/git_ms.bib .
# Make the figure
# pandoc -H margins.sty list_of_figures.md -o list_of_figures.pdf
# Make the manuscript
Rscript -e "library(knitr); knit('habitat_organism_size.Rmd')"
pandoc --bibliography references.bib habitat_organism_size.md -o habitat_organism_size.pdf
# Combine the two using PDFtools (pdftools@skynet.be)
# pdfcat git_manuscript.pdf list_of_figures.pdf > git_ms.pdf
# Remove duplicate files and rename concated one to original name
# rm list_of_figures.pdf
# rm git_manuscript.pdf
# mv git_ms.pdf git_manuscript.pdf

#pandoc -H margins.sty --bibliography git_ms.bib --csl plos.csl git_manuscript.md -o git_manuscript.tex
#pandoc -H margins.sty list_of_figures.md -o list_of_figures.tex

## look at it:

evince habitat_organism_size.pdf
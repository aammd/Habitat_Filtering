# copy the latest bibliography from Mendeley's export
# cp ~/Documents/Work/Reference/BibTex/git_ms.bib .
# Make the figure
# pandoc -H margins.sty list_of_figures.md -o list_of_figures.pdf
# Make the manuscript
Rscript -e "library(knitr); knit('habitat_organism_size.Rmd')"
pandoc -s -S --bibliography references.bib habitat_organism_size.md -o habitat_organism_size.pdf

## make the figures
Rscript -e "library(knitr); knit('habitat_organism_size_figs.Rmd')"
pandoc -s -S habitat_organism_size_figs.md -o habitat_organism_size_figs.pdf


# Combine the two 
pdfunite habitat_organism_size.pdf habitat_organism_size_figs.pdf habitat_organism_size_MS.pdf
# Remove duplicate files and rename concated one to original name
rm habitat_organism_size.pdf
rm habitat_organism_size_figs.pdf
# rm git_manuscript.pdf
# mv git_ms.pdf git_manuscript.pdf

#pandoc -H margins.sty --bibliography git_ms.bib --csl plos.csl git_manuscript.md -o git_manuscript.tex
#pandoc -H margins.sty list_of_figures.md -o list_of_figures.tex

## look at it:

evince habitat_organism_size_MS.pdf
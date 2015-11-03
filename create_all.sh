#! /bin/bash
		

## copy over the theme from the first chapter:
cp ../01_PredPhylo/R.scripts/FIGURE_themes.R ./R.scripts/

## obtain the bibliography from Mendeley
cp /home/andrew/Documents/reference/Mendeley_reference_lists/04_OrgSizeHabitat.bib ./MS/orgsize.bib

## append to the end the R package citations
cat ./MS/Rcitations.bibtex >> ./MS/orgsize.bib

## copy over citation format from the correct source.
cp ../../reference/styles/the-american-naturalist.csl ./MS/formatting/

## finally make everthing
remake
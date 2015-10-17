#! /bin/bash

## obtain the bibliography from Mendeley
cp /home/andrew/Documents/reference/Mendeley_reference_lists/@MS_habitat_size_org.bib ./MS/orgsize.bib

## append to the end the R package citations
cat ./MS/Rcitations.bibtex >> ./MS/orgsize.bib

## copy over citation format from the correct source.
cp ../../reference/styles/the-american-naturalist.csl ./MS/formatting/

## finally make everthing
remake
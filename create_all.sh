#! /bin/bash
		

## copy over the theme from the first chapter:
cp ../01_PredPhylo/R.scripts/FIGURE_themes.R ./R.scripts/

bash create_refs.sh

bash create_illustration.sh

## copy over citation format from the correct source.
cp ../../reference/styles/the-american-naturalist.csl ./MS/formatting/

remake
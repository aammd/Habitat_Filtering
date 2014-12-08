all: data/inverts.csv

clean:

.PHONY: all clean

data/inverts.csv : R.scripts/inverts.R raw-data/insect.communities.table.txt raw-data/insectnames.csv
	cd $(<D); Rscript $(<F)
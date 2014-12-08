all: data/inverts.csv data/zoops.csv

clean:

.PHONY: all clean

data/inverts.csv : R.scripts/inverts.R raw-data/insect.communities.table.txt raw-data/insectnames.csv
	cd $(<D); Rscript $(<F)

data/zoops.csv : R.scripts/zoops.R raw-data/zoop.txt
	cd $(<D); Rscript $(<F)
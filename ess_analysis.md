# Compare predicted essential genes among *Dickeya* strains.

#### Find PyParanoid group numbers for predicted essential genes. 

To match gene locusIds with PyParanoid groups, search locustag\_matrix\_with\_genes.txt metadata.  

~~~ r
source("src/add_groups_to_ess.R")
~~~

Write group names for predicted essential genes. 

~~~ r
source("src/save_ess_groups.R")
~~~

Lists of genes with essentiality predictions and PyParanoid groups:

- [Dda3937.ess.csv](analysis/Dda3937.ess.csv)
- [DdiaME23.ess.csv](analysis/DdiaME23.ess.csv)
- [Ddia6719.ess.csv](analysis/Ddia6719.ess.csv)

How many predicted essential genes do not have predicted groups?

~~~ bash
for strain in Dda3937 DdiaME23 Ddia6719; do
echo $strain
grep NA  analysis/${strain}_ess_groups.txt | \
wc -l
done
~~~
~~~
Dda3937
      11
DdiaME23
      16
Ddia6719
      19
~~~

Use these group numbers to construct Venn diagram comparing predicted essential genes for the three strains. Note NA counts.



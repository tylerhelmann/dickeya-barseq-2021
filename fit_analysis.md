## Analysis of BarSeq fitness data

#### Estimate FDR

Overall, we attempted 36 genome-wide fitness experiments for each of three transposon libraries, of which 35 (*Dda*3937), 36 (*Ddia*ME23), and 33 (*Ddia*6719) passed metrics for internal consistency (Wetmore *et al*. 2015). 

We used the following cutoff for a significant phenotype: |fitness| > 1 and |t| > 4, where t is the fitness divided by the estimated standard error. 

~~~ r
R
source("src/write_genes_with_phenotype.R")
~~~

Considering only experiments that passed internal QC metrics:

For *Dda*3937, across all 35 experiments x 3,706 genes, 3,715 gene fitness values (2.9%) had |fitness| > 1 and |t| > 4.  
For *Ddia*ME23, across all 36 experiments x 3,761 genes, 2,396 gene fitness values (1.8%) had |fitness| > 1 and |t| > 4.  
For *Ddia*6719, across all 33 experiments x 3,528 genes, 1,936 gene fitness values (1.7%) had |fitness| > 1 and |t| > 4.  

Based on previous methods to estimate the false discovery rate for a significant phenotype (Price *et al.* 2018, Liu *et al.* 2021) and the same significant phenotype cutoffs, we assessed fitness & t values generated from comparisons between replicate time0 experiments.

~~~ r
# R output.
[1] "Dda3937 : 6 time0 experiments"
[1] 0
[1] 0
[1] 0
[1] 0
[1] 0
[1] 0
[1] "DdiaME23 : 6 time0 experiments"
[1] 0
[1] 0
[1] 0
[1] 0
[1] 0
[1] 0
[1] "Ddia6719 : 2 time0 experiments"
[1] 0
[1] 0

~~~

For *Dda*3937, across 6 time0 x 3,706 genes, 0 gene fitness values (0%) had |fitness| > 1 and |t| > 4.  
For *Ddia*ME23, across 6 time0 x 3,761 genes, 0 gene fitness values (0%) had |fitness| > 1 and |t| > 4.  
For *Ddia*6719, across 2 time0 x 3,528 genes, 0 gene fitness values (0%) had |fitness| > 1 and |t| > 4.  

#### Summarize genes (with phenotype) by treatment

Create analysis R script for all library x treatment combinations.  
(All other steps in R.)

~~~ bash
./src/write_analysis_R_scripts.sh > src/freq_functions.R
~~~

Load lists of genes where |fit| > 1 and |t| > 4.

~~~ r
fit_Dda3937 <- read.csv("analysis/Dda3937_phenotype.tab", header = T)
fit_DdiaME23 <- read.csv("analysis/DdiaME23_phenotype.tab", header = T)
fit_Ddia6719 <- read.csv("analysis/Ddia6719_phenotype.tab", header = T)
~~~

Add orthogroup info (from PyParanoid database).

~~~ r
locustag_matrix <- read.csv("dickeya_db/locustag_matrix_with_genes.txt", header = T)

fit_Dda3937$group <- locustag_matrix$X[match(fit_Dda3937$locusId, locustag_matrix$Dda3937_locus)]
fit_DdiaME23$group <- locustag_matrix$X[match(fit_DdiaME23$locusId, locustag_matrix$DdiaME23_locus)]
fit_Ddia6719$group <- locustag_matrix$X[match(fit_Ddia6719$locusId, locustag_matrix$Ddia6719_locus)]
~~~

Add COG info to *Dda*3937 feature table.  
(Necessary because COG lists reference GenBank locusIds.)

~~~ r
# Import all COG lists.
source("src/import_COG_lists.R")
# Save new feature table.
source("src/annotate_COGs.R") 
~~~

Add COG info to PyParanoid homolog matrix, based on *Dda*3937 gemes.
(Links COGs to all strains.)

~~~ r 
Dda3937_feature_table_COG <- read.csv("analysis/Dda3937_feature_table_COG.txt")
locustag_matrix_with_genes <- read.csv("dickeya_db/locustag_matrix_with_genes.txt")

locustag_matrix_with_genes$COG <- Dda3937_feature_table_COG$COG[match(locustag_matrix_with_genes$Dda3937_locus,
	Dda3937_feature_table_COG$locus_tag)]
write.csv(locustag_matrix_with_genes, "analysis/locustag_matrix_with_genes_COG.txt", row.names = F)
~~~

Split by treatment. (Combines tuber cultivar data.)

~~~ r
fit_Dda3937_LB <- fit_Dda3937[grep("LB", fit_Dda3937$short),]
fit_Dda3937_PDB <- fit_Dda3937[grep("PDB", fit_Dda3937$short),]
fit_Dda3937_M9 <- fit_Dda3937[grep("M9", fit_Dda3937$short),] 
fit_Dda3937_tuber <- fit_Dda3937[grep("Atlantic|Norland|Upstate", fit_Dda3937$short),]

fit_DdiaME23_LB <- fit_DdiaME23[grep("LB", fit_DdiaME23$short),] 
fit_DdiaME23_PDB <- fit_DdiaME23[grep("PDB", fit_DdiaME23$short),] 
fit_DdiaME23_M9 <- fit_DdiaME23[grep("M9", fit_DdiaME23$short),] 
fit_DdiaME23_tuber <- fit_DdiaME23[grep("Atlantic|Norland|Upstate", fit_DdiaME23$short),]

fit_Ddia6719_LB <- fit_Ddia6719[grep("LB", fit_Ddia6719$short),] 
fit_Ddia6719_PDB <- fit_Ddia6719[grep("PDB", fit_Ddia6719$short),] 
fit_Ddia6719_M9 <- fit_Ddia6719[grep("M9", fit_Ddia6719$short),] 
fit_Ddia6719_tuber <- fit_Ddia6719[grep("Atlantic|Norland|Upstate", fit_Ddia6719$short),]
~~~

Print gene frequencies for all treatments x strains, including COG and orthogroup info.  
Frequency indicates number of reps where that gene had a significant phenotype.  
Note: these lists do not distinguish +/- fitness values. 

~~~r 
source("src/freq_functions.R")
~~~

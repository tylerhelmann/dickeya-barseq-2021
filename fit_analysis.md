## Analysis of BarSeq fitness data

#### Calculate FDR

Overall, attempted 36 genome-wide fitness experiments for each of three transposon libraries, of which 35 (*Dda*3937), 36 (*Ddia*ME23), and 33 (*Ddia*6719) passed metrics for internal consistency (Wetmore *et al*. 2015). 

We used the following cutoff for a significant phenotype: |fitness| > 1 and |t| > 4, where t is the fitness divided by the estimated standard error. 

~~~ r
R
source("src/write_genes_with_phenotype.R")
~~~

(Considering only experiments that passed internal QC metrics.)  
For *Dda*3937, across all 35 experiments x 3,706 genes, 3,715 gene fitness values (2.9%) had |fitness| > 1 and |t| > 4.  
For *Ddia*ME23, across all 36 experiments x 3,761 genes, 2,396 gene fitness values (1.8%) had |fitness| > 1 and |t| > 4.  
For *Ddia*6719, across all 33 experiments x 3,528 genes, 1,936 gene fitness values (1.7%) had |fitness| > 1 and |t| > 4.  

Based on previous methods to estimate the false discovery rate for a significant phenotype (Price *et al.* 2018, Liu *et al.* 2021) and the same significant phenotype cutoffs, we assessed fitness values generated from comparisons between replicate time0 experiments.

~~~ r
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

Therefore, for each library used in this study, the estimated false discovery rate for a significant phenotype was 0% / (2.9%, 1.8%, or 1.7%) = 0%.


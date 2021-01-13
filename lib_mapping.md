## Mapping barcoded *Mariner* transposon libraries

System: Linux CentOS 7.6 (40 core)

#### Strains:

| Strain | RefSeq accession | RefSeq assembly and GenBank assembly identical
|---|---|---|
|*Dickeya dadantii* 3937 | GCF_000147055.1 | yes
|*Dickeya dianthicola* ME23 | GCF_003403135.1 | yes
|*Dickeya dianthicola* 67-19 | GCF_014893095.1 | yes
|*Pectobacterium carotovorum* WPP14 | GCF_013488025.1 | yes

Sequencing data:

| Strain | Machine | Zipped output size | Total sequences
| --- | --- | --- | ---
| *Dda* 3937 | NextSeq | 
| *Ddia* ME23 | NextSeq | 38 Gb | 481396760
| *Ddia* 67-19 | MiSeq | 
| *Pc* WPP14 | MiSeq |


#### Mapping protocol

Import RefSeq gbk files for all strains.

~~~ bash
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/147/055/GCF_000147055.1_ASM14705v1/GCF_000147055.1_ASM14705v1_genomic.gbff.gz \
-O Dda3937.gbff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/403/135/GCF_003403135.1_ASM340313v1/GCF_003403135.1_ASM340313v1_genomic.gbff.gz \
-O DdiaME23.gbff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/893/095/GCF_014893095.1_ASM1489309v1/GCF_014893095.1_ASM1489309v1_genomic.gbff.gz \
-O Ddia6719.gbff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/013/488/025/GCF_013488025.1_ASM1348802v1/GCF_013488025.1_ASM1348802v1_genomic.gbff.gz \
-O PcWPP14.gbff.gz

gunzip *gbff.gz
~~~

Download FEBA repository.

~~~ bash
git clone -q https://bitbucket.org/berkeleylab/feba.git

# genbank2gff.pl is only a link. 
# Delete the link and replace the file with:
# https://github.com/ihh/gfftools/blob/master/genbank2gff.pl

rm -f feba/bin/genbank2gff.pl
cp genbank2gff.pl feba/bin/genbank2gff.pl
~~~

Set up strains for FEBA pipeline.

~~~ bash
for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
./feba/bin/SetupOrg.pl -gbk ${lib}.gbff \
-out ${lib}_data/ \
2>&1 | tee ${lib}_setup.log
done
~~~

[DdiaME23_setup.log](library_mapping/DdiaME23_setup.log)

#### Map reads.

Split fastq files to multiplex.  
Total lines / 40 cores.  
(Needs to be a multiple of 4 because reads in fastq files are in groups of 4 lines.)

~~~ bash
# Split fastq files.
split -l 48139676 -d DdiaME23.fastq DdiaME23- &

# Map reads in parallel.

# Map DdiaME23
for i in DdiaME23-{00..39}; do
./feba/bin/MapTnSeq.pl \
-genome DdiaME23_data/genome.fna \
-model feba/primers/model_pKMW3.2 \
-first ${i} > DdiaME23_data/split/${i}-mapped.txt \
2> DdiaME23_data/split/${i}_log.txt &
done

# Combine all data.
cat DdiaME23_data/split/DdiaME23*-mapped.txt > \
DdiaME23_data/DdiaME23-mapped.txt
~~~

- [DdiaME23 logs](library_mapping/DdiaME23_split_logs/)

Construct barcode Pool 

~~~ bash
# Fix feba/lib/PoolStats.R shebang line. 
# For me needs to be: #!/usr/bin/env Rscript

for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
./feba/bin/DesignRandomPool.pl -minN 10 \
-genes ${lib}_data/genes.tab \
-pool ${lib}.pool ${lib}_data/${lib}-mapped.txt \
2>&1 | tee ${lib}.stats
done
~~~

Library mapping stats

- [DdiaME23](library_mapping/DdiaME23.stats)

#### Summary of all libraries

| Library | Insertions in Genome | Central Insertion Strains |  Genes with Central Insertions (Total) | Median Strains per Hit Protein |
| --- | --- | --- | --- | ---
| *Dda* 3937 | |
| *Ddia* ME23 | 540176 |320479 |3804 (4182) | 62
| *Ddia* 67-19 |
| *Pc* WPP14 | 

#### Calculate gene essentiality predictions using Essentiality.pl

~~~ bash
for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
./feba/bin/Essentiality.pl -out ${lib}_data/ess \
-genome ${lib}_data/genome.fna \
-genes ${lib}_data/genes.tab \
${lib}_data/${lib}-mapped.txt \
$blatShow
done
~~~

Output files = 

- ess.genes
- ess.pos 
- ess.regions

#### To generate ess predictions, use comb.R

~~~ bash
# Open R shell and add input files.
R
source("feba/lib/comb.R")
genes.GC <- read.delim(file = "DdiaME23_data/genes.GC")
ess.genes <- read.delim(file = "DdiaME23_data/ess.genes")

# Run Essentials() and save output.
ess <- Essentials(genes.GC, ess.genes, "")
write.table(ess, file="DdiaME23_data/ess", sep="\t", row.names=F)
# Quit R shell.
q()
~~~

Note minimum gene length from Essentials()

~~~
# DdiaME23:
# Chose length  150 minimum fp rate 0.01136051 
~~~

Predicted essential genes:

- [DdiaME23](library_mapping/DdiaME23.ess)


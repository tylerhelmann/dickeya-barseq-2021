## Mapping barcoded *Mariner* transposon libraries

System used: Linux CentOS 7.6 (40 core server, 256 Gb RAM)

RB-TnSeq citation: 

Wetmore, K.M., Price, M.N., Waters, R.J., Lamson, J.S., He, J., Hoover, C.A., Blow, M.J., Bristow, J., Butland, G., Arkin, A.P., Deutschbauer, A. Rapid Quantification of Mutant Fitness in Diverse Bacteria by Sequencing Randomly Bar-Coded Transposons. mBio 6 (3) e00306-15 (2015). DOI: [10.1128/mBio.00306-15](http://doi.org/10.1128/mBio.00306-15)

#### Strains

| Strain | RefSeq accession | RefSeq assembly and GenBank assembly identical
|---|---|---|
|*Dickeya dadantii* 3937 | [GCF_000147055.1](https://www.ncbi.nlm.nih.gov/assembly/GCF_000147055.1/) | yes
|*Dickeya dianthicola* ME23 | [GCF_003403135.1](https://www.ncbi.nlm.nih.gov/assembly/GCF_003403135.1/) | yes
|*Dickeya dianthicola* 67-19 | [GCF_014893095.1](https://www.ncbi.nlm.nih.gov/assembly/GCF_014893095.1/) | yes

#### Sequence data

| Strain | Sequencer | Total reads | SRA | File name |
| --- | --- | --- | --- | --- | 
| *Dda* 3937 | MiSeq | 22,578,055 | SRR13762539 | 10430690_Dda3937.fastq.gz
| *Dda* 3937 | NextSeq 500 | 453,403,106 | SRR13455163 | 10435840_Dda3937.fastq.gz
| *Ddia* ME23 | MiSeq | 21,084,010 | SRR13762538 | 10429775_DdiaME23.fastq.gz
| *Ddia* ME23 | NextSeq 500 | 481,396,760 | SRR13444973 | 10430494_DdiaME23.fastq.gz
| *Ddia* 67-19 | MiSeq | 20,468,022 | SRR13491906 | 10435838_Ddia6719.fastq.gz
| *Ddia* 67-19 | NextSeq 500 | 474,107,039 | SRR13723386 | 10436717_Ddia6719.fastq.gz

### Mapping protocol

#### Import RefSeq gbk files for all strains

~~~ bash
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/147/055/GCF_000147055.1_ASM14705v1/GCF_000147055.1_ASM14705v1_genomic.gbff.gz \
-O Dda3937.gbff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/403/135/GCF_003403135.1_ASM340313v1/GCF_003403135.1_ASM340313v1_genomic.gbff.gz \
-O DdiaME23.gbff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/893/095/GCF_014893095.1_ASM1489309v1/GCF_014893095.1_ASM1489309v1_genomic.gbff.gz \
-O Ddia6719.gbff.gz

gunzip *gbff.gz
~~~

#### Download FEBA repository

~~~ bash
git clone -q https://bitbucket.org/berkeleylab/feba.git

# genbank2gff.pl is only a link. 
# Delete the link and replace the file with:
# https://github.com/ihh/gfftools/blob/master/genbank2gff.pl

rm feba/bin/genbank2gff.pl
cp genbank2gff.pl feba/bin/genbank2gff.pl
~~~

#### Set up strains for FEBA pipeline

(Will use "genes.GC" files for BarSeq.)

~~~ bash
for lib in Dda3937 DdiaME23 Ddia6719; do
./feba/bin/SetupOrg.pl -gbk ${lib}.gbff \
-out ${lib}_data/ \
2>&1 | tee ${lib}_setup.log
done
~~~

[Dda3937_setup.log](library_mapping/Dda3937_setup.log)  
[DdiaME23_setup.log](library_mapping/DdiaME23_setup.log)  
[Ddia6719_setup.log](library_mapping/Ddia6719_setup.log)  

[Dda3937_genes.tab](library_mapping/Dda3937_genes.tab)  
[DdiaME23_genes.tab](library_mapping/DdiaME23_genes.tab)  
[Ddia6719_genes.tab](library_mapping/Ddia6719_genes.tab)  

[Dda3937_genes.GC](barseq_inputs/Dda3937_genes.GC)  
[DdiaME23_genes.GC](barseq_inputs/DdiaME23_genes.GC)  
[Ddia6719_genes.GC](barseq_inputs/Ddia6719_genes.GC)  

#### Map reads

Split NextSeq fastq files to use all cores for NextSeq mapping. Round total lines / 40 cores.  
(Needs to be a multiple of 4 because reads in fastq files are in groups of 4 lines.)

~~~ bash
# Unzip all fastq.gz files.

# Split large (NextSeq) fastq files.
split -l 45340312 -d 10435840_Dda3937.fastq Dda3937- &
split -l 48139676 -d 10430494_DdiaME23.fastq DdiaME23- &
split -l 47410704 -d 10436717_Ddia6719.fastq Ddia6719- &

# Create tasklist to map MiSeq reads.
echo "./feba/bin/MapTnSeq.pl \
-genome Dda3937_data/genome.fna \
-model feba/primers/model_pKMW3.2 \
-first 10430690_Dda3937.fastq \
> Dda3937_data/Dda3937-MiSeq-mapped.txt \
2> Dda3937_data/Dda3937-MiSeq_log.txt" > mapping_tasklist.txt
echo "./feba/bin/MapTnSeq.pl \
-genome DdiaME23_data/genome.fna \
-model feba/primers/model_pKMW3.2 \
-first 10429775_DdiaME23.fastq \
> DdiaME23_data/DdiaME23-MiSeq-mapped.txt \
2> DdiaME23_data/DdiaME23-MiSeq_log.txt" >> mapping_tasklist.txt
echo "./feba/bin/MapTnSeq.pl \
-genome Ddia6719_data/genome.fna \
-model feba/primers/model_pKMW3.2 \
-first 10435838_Ddia6719.fastq \
> Ddia6719_data/Ddia6719-MiSeq-mapped.txt \
2> Ddia6719_data/Ddia6719-MiSeq_log.txt" >> mapping_tasklist.txt

# Add NextSeq mapping to tasklist.
for lib in Dda3937 DdiaME23 Ddia6719; do
for i in ${lib}-{00..39}; do
echo "./feba/bin/MapTnSeq.pl \
-genome ${lib}_data/genome.fna \
-model feba/primers/model_pKMW3.2 \
-first ${i} > ${lib}_data/${i}-mapped.txt \
2> ${lib}_data/${i}_log.txt"
done
done >> mapping_tasklist.txt
~~~

[mapping_tasklist.txt](library_mapping/mapping_tasklist.txt)

~~~ bash
# Map NextSeq reads in parallel, using Cornell BioHPC task manager.
/programs/bin/perlscripts/perl_fork_univ.pl \
mapping_tasklist.txt 40

# Combine mapped reads.
for lib in Dda3937 DdiaME23 Ddia6719; do
cat ${lib}_data/${lib}*-mapped.txt > \
${lib}_data/${lib}-mapped.txt &
done
~~~

- [Dda3937 logs](library_mapping/Dda3937_mapping_logs/)
- [DdiaME23 logs](library_mapping/DdiaME23_mapping_logs/)
- [Ddia6719 logs](library_mapping/Ddia6719_mapping_logs/)

#### Construct barcode "pools"

Use -minN 10 to set minimum 10 reads per barcode to be included in pool. 

~~~ bash
# Fix feba/lib/PoolStats.R shebang line. 
# For me needs to be: #!/usr/bin/env Rscript

for lib in Dda3937 DdiaME23 Ddia6719; do
./feba/bin/DesignRandomPool.pl -minN 10 \
-genes ${lib}_data/genes.tab \
-pool ${lib}.pool ${lib}_data/${lib}-mapped.txt \
2>&1 | tee ${lib}.stats &
done
~~~

Library mapping stats:

- [Dda3937.stats](library_mapping/Dda3937.stats)
- [DdiaME23.stats](library_mapping/DdiaME23.stats)
- [Ddia67-19.stats](library_mapping/Ddia6719.stats)

Pools:

- [Dda3937.pool](library_mapping/Dda3937.pool)
- [DdiaME23.pool](library_mapping/DdiaME23.pool)
- [Ddia67-19.pool](library_mapping/Ddia6719.pool)

#### Library summaries

Central insertions refer to insertions within the central 10-90% of a gene. 

| Library | Insertions in genome | Central insertion strains |  Genes with central insertions (Total) | Median strains per hit protein |
| --- | --- | --- | --- | ---
| *Dda* 3937 | 337,541 | 193,696 | 3,882 (4,213) | 37
| *Ddia* ME23 | 541,278 | 321,087 | 3,805 (4,182) | 62
| *Ddia* 67-19 | 334,893 | 200,170 | 3,728 (4,110) | 41

#### Essential gene predictions

Calculate insertion frequencies using Essentiality.pl.

~~~ bash
for lib in Dda3937 DdiaME23 Ddia6719; do
./feba/bin/Essentiality.pl -out ${lib}_data/ess \
-genome ${lib}_data/genome.fna \
-genes ${lib}_data/genes.tab \
${lib}_data/${lib}-mapped.txt \
$blatShow &
done
~~~

Intermediate output files: 

- ess.genes
- ess.pos 
- ess.regions

~~~ bash
# Open R shell and add input files.
R
source("feba/lib/comb.R")

Dda3937_genes.GC <- read.delim(file = "Dda3937_data/genes.GC")
Dda3937_ess.genes <- read.delim(file = "Dda3937_data/ess.genes")
DdiaME23_genes.GC <- read.delim(file = "DdiaME23_data/genes.GC")
DdiaME23_ess.genes <- read.delim(file = "DdiaME23_data/ess.genes")
Ddia6719_genes.GC <- read.delim(file = "Ddia6719_data/genes.GC")
Ddia6719_ess.genes <- read.delim(file = "Ddia6719_data/ess.genes")

# Run Essentials() to predict gene essentiality.
Dda3937_ess <- Essentials(Dda3937_genes.GC, Dda3937_ess.genes, "")
DdiaME23_ess <- Essentials(DdiaME23_genes.GC, DdiaME23_ess.genes, "")
Ddia6719_ess <- Essentials(Ddia6719_genes.GC, Ddia6719_ess.genes, "")

# Save output.
write.table(Dda3937_ess, file="Dda3937_data/Dda3937.ess", sep="\t", row.names=F)
write.table(DdiaME23_ess, file="DdiaME23_data/DdiaME23.ess", sep="\t", row.names=F)
write.table(Ddia6719_ess, file="Ddia6719_data/Ddia6719.ess", sep="\t", row.names=F)

# Quit R shell.
q()
~~~

Note minimum gene length from Essentials().

~~~
# Dda3937:
# Chose length  175 minimum fp rate 0.01047129 
# DdiaME23:
# Chose length  150 minimum fp rate 0.01136051 
# Ddia67-19:
# Chose length  150 minimum fp rate 0.009785382 
~~~

Predicted essential genes:

- [Dda3937](library_mapping/Dda3937.ess) (N=374)
- [DdiaME23](library_mapping/DdiaME23.ess) (N=426)
- [Ddia67-19](library_mapping/Ddia6719.ess) (N=426)

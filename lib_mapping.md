## Mapping barcoded *Mariner* transposon libraries

System: Linux CentOS 7.6

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
| *Ddia* ME23 | NextSeq | 38 Gb | 21084010
| *Ddia* 67-19 | MiSeq | 
| *Pc* WPP14 | MiSeq |

FastQC summaries of sequencing runs:

~~~ bash
export PATH=/programs/FastQC-0.11.8:$PATH

for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
fastqc ${lib}.fastq &
done
~~~

Results:

- [Dda3937_fastqc.html](library_mapping/Dda3937_fastqc.html)
- [DdiaME23_fastqc.html](library_mapping/DdiaME23_fastqc.html)
- [Ddia67-19_fastqc.html](library_mapping/Ddia67-19_fastqc.html)
- [PcWPP14_fastqc.html](library_mapping/PcWPP14_fastqc.html)

--

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
-out ${lib}_data/ 2>&1 | tee ${lib}_setup.log
done
~~~

Map reads. (Need to split to multiplex?)

Fastq file names = \${lib}_reads.fastq

~~~ bash
for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
./feba/bin/MapTnSeq.pl -genome ${lib}_data/genome.fna \
-model feba/primers/model_pKMW3.2 \
-first ${lib}_reads.fastq \
> ${lib}_data/${lib}_mapped.txt
done
~~~

Construct barcode Pool. Output = pools and stats files.

~~~ bash
for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
./feba/bin/DesignRandomPool.pl -minN 10 \
-genes ${lib}_data/genes.tab \
-pool ${lib}.pool ${lib}_data/${lib}_mapped.txt \
2>&1 | tee ${lib}.stats
done
~~~

#### Summary of all libraries

| Library | Total Mutant Strains | Central Insertion Strains |  Genes with Central Insertions (Total) | Strains per Hit Protein |
| --- | --- | --- | --- | ---
| *Dda* 3937 | |
| *Ddia* ME23 | 
| *Ddia* 67-19 |
| *Pc* WPP14 | 

#### Calculate gene essentiality predictions using Essentiality.pl

~~~ bash
./feba/bin/Essentiality.pl -out data/ess \
-genome data/genome.fna \
-genes data/genes.tab data/B728a-all-mapped.txt \
$blatShow
~~~

Output files = 

- ess.genes
- ess.pos 
- ess.regions

#### To generate ess predictions, use comb.R

Open R shell and add input files.

~~~ 
R
> source("feba/lib/comb.R")
> genes.GC <- read.delim(file = "data/genes.GC")
> ess.genes <- read.delim(file = "data/ess.genes")
~~~

Run Essentials() and save output.

~~~
> ess <- Essentials(genes.GC, ess.genes, "")
> write.table(ess, file="data/ess", sep="\t", row.names=F)
> # Quit R shell
> q()
~~~


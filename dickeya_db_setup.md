### PyParanoid "Dickeya" database.

System: macOS Catalina (10.15.7) (4 cores)

PyParanoid citation: 

Melnyk, R.A., Hossain, S.S. & Haney, C.H. Convergent gain and loss of genomic islands drive lifestyle changes in plant-associated Pseudomonas. ISME J 13, 1575–1588 (2019). DOI: [10.1038/s41396-019-0372-5](https://doi.org/10.1038/s41396-019-0372-5)

##### Dependencies

For OSX, install using Homebrew.

~~~ bash
brew tap brewsci/bio
brew install diamond
brew install hmmer
brew install mcl
brew install cd-hit
brew install muscle
~~~

Versions used here:

- cd-hit 4.8.1_1
- diamond 0.9.36
- hmmer 3.3.1
- mcl 14-137
- muscle 3.8.1551

--

#### Set up PyParanoid directory within working directory

~~~ bash
git clone https://github.com/ryanmelnyk/PyParanoid
~~~

~~~ python
python3
>>>import pyparanoid.genomedb as gdb
>>>gdb.setupdirs("genomedb")
>>>exit()
~~~

#### Download NCBI RefSeq protein sequences for *Dickeya dadantii* 3937, *D. dianthicola* ME23, *D. dianthicola* 67-19, and *Pectobacterium carotovorum* WPP14. 

(Note: Check that these locusIds are compatible with BarSeq output.)

- Dda3937 = GCF_000147055.1
- DdiaME23 = GCF_003403135.1
- Ddia67-19 = GCF_014893095.1

~~~ bash
# Download protein sequence files for all strains. 
# Need to be in genomedb/pep/ folder. 
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/147/055/GCF_000147055.1_ASM14705v1/GCF_000147055.1_ASM14705v1_protein.faa.gz \
-O genomedb/pep/Dickeya_dadantii_3937.pep.fa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/403/135/GCF_003403135.1_ASM340313v1/GCF_003403135.1_ASM340313v1_protein.faa.gz \
-O genomedb/pep/Dickeya_dianthicola_ME23.pep.fa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/893/095/GCF_014893095.1_ASM1489309v1/GCF_014893095.1_ASM1489309v1_protein.faa.gz \
-O genomedb/pep/Dickeya_dianthicola_67_19.pep.fa.gz

gunzip genomedb/pep/*pep.fa.gz

# Create PyParanoid strainlist. (Remove ".pep.fa".)
ls genomedb/pep | \
sed 's/.pep.fa//' \
> genomedb/strainlist.txt
~~~

[strainlist.txt](dickeya_db/strainlist.txt)  

#### Build genome database: dickeya_db.

~~~ bash
BuildGroups.py --clean --verbose  --cpus 4 genomedb/ \
genomedb/strainlist.txt dickeya_db
~~~

Terminal output:

~~~

~~~

- [clusterstats.out](dickeya_db/clusterstats.out)  
- [Homolog matrix](dickeya_db/homolog_matrix.txt)  
- [Locustag matrix](dickeya_db/locustag_matrix.txt)  
- [Consensus sequences](dickeya_db/all_groups.faa)
- [Group descriptions](dickeya_db/group_descriptions.txt)

--

#### Convert protein Ids to RefSeq locus tags

Download RefSeq strain "features" tables, needed to match protein Ids (used for ortholog groups) to locus tags (used for RB-TnSeq).

~~~ bash
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/147/055/GCF_000147055.1_ASM14705v1/GCF_000147055.1_ASM14705v1_feature_table.txt.gz \
-O dickeya_db/Dda3937_feature_table.txt.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/403/135/GCF_003403135.1_ASM340313v1/GCF_003403135.1_ASM340313v1_feature_table.txt.gz \
-O dickeya_db/DdiaME23_feature_table.txt.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/893/095/GCF_014893095.1_ASM1489309v1/GCF_014893095.1_ASM1489309v1_feature_table.txt.gz \
-O dickeya_db/Ddia67_19_feature_table.txt.gz


gunzip dickeya_db/*feature_table.txt.gz
~~~

Use features tables to match RefSeq locusIds to protein accessions in locustag_matrix.

~~~ r
R
source("barseq_analysis/add_genes_to_orthogroups.R")
q()
~~~

Output: [locustag\_matrix\_with\_genes](dickeya_db/locustag_matrix_with_genes.txt)

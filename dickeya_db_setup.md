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

#### Download NCBI RefSeq protein sequences for *Dickeya dadantii* 3937, *D. dianthicola* ME23, and *D. dianthicola* 67-19. 

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
Formatting 3 fasta files...
Making diamond databases for 3 strains...
Running DIAMOND on all 3 strains...
	Done!
Getting gene lengths...
Parsing diamond results for 3 strains...
	Done!
Running InParanoid on 3 pairs of strains...
Sequential mode...
	0 remaining...
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/out
Parsing 3 output files.
	Done!
[mclIO] writing </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/mcl/data.mci>
.......................................
[mclIO] wrote native interchange 11004x11004 matrix with 21134 entries to stream </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/mcl/data.mci>
[mclIO] wrote 11004 tab entries to stream </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/mcl/data.tab>
[mcxload] tab has 11004 entries
[mclIO] reading </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/mcl/data.mci>
.......................................
[mclIO] read native interchange 11004x11004 matrix with 21134 entries
[mcl] pid 58618
 ite   chaos  time hom(avg,lo,hi) m-ie m-ex i-ex fmv
  1     0.68  0.03 1.00/0.74/1.22 1.00 1.00 1.00   0
  2     0.77  0.03 1.00/0.77/1.00 1.00 1.00 1.00   0
  3     0.88  0.03 1.00/0.62/1.00 1.00 1.00 1.00   0
  4     0.84  0.03 1.00/0.57/1.30 1.00 1.00 1.00   0
  5     0.79 18446744073709.57 1.00/0.65/1.29 1.00 1.00 1.00   0
  6     0.32  0.03 1.00/0.73/1.16 1.00 1.00 1.00   0
  7     0.34  0.03 1.00/0.58/1.00 1.00 1.00 0.99   0
  8     0.48  0.03 1.00/0.64/1.00 1.00 1.00 0.99   0
  9     0.37  0.03 1.00/0.74/1.00 1.00 1.00 0.99   0
 10     0.44 18446744073709.57 1.00/0.69/1.00 1.00 1.00 0.99   0
 11     0.28  0.03 1.00/0.81/1.00 1.00 1.00 0.99   0
 12     0.03  0.03 1.00/0.97/1.00 1.00 1.00 0.99   0
 13     0.00  0.03 1.00/1.00/1.00 1.00 1.00 0.99   0
 14     0.00  0.04 1.00/1.00/1.00 1.00 1.00 0.99   0
[mcl] cut <3> instances of overlap
[mcl] jury pruning marks: <100,100,100>, out of 100
[mcl] jury pruning synopsis: <100.0 or really really really good> (cf -scheme, -do log)
[mclIO] writing </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/mcl/mcl.out>
.......................................
[mclIO] wrote native interchange 11004x3821 matrix with 11004 entries to stream </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/mcl/mcl.out>
[mcl] 3821 clusters found
[mcl] output is in /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/mcl/mcl.out

Please cite:
    Stijn van Dongen, Graph Clustering by Flow Simulation.  PhD thesis,
    University of Utrecht, May 2000.
       (  http://www.library.uu.nl/digiarchief/dip/diss/1895620/full.pdf
       or  http://micans.org/mcl/lit/svdthesis.pdf.gz)
OR
    Stijn van Dongen, A cluster algorithm for graphs. Technical
    Report INS-R0010, National Research Institute for Mathematics
    and Computer Science in the Netherlands, Amsterdam, May 2000.
       (  http://www.cwi.nl/ftp/CWIreports/INS/INS-R0010.ps.Z
       or  http://micans.org/mcl/lit/INS-R0010.ps.Z)

[mclIO] reading </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/mcl/mcl.out>
.......................................
[mclIO] read native interchange 11004x3821 matrix with 11004 entries
Writing fasta files and parsing descriptions...
3822 groups equal to or larger than 2 sequences.
Clustering sequences...
Sequential mode...
	3000 remaining...
	2000 remaining...
	1000 remaining...
	0 remaining...
Aligning groups...
Sequential mode...
	3000 remaining...
	2000 remaining...
	1000 remaining...
	0 remaining...
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/clustered
Building hmms...
Sequential mode...
	3000 remaining...
	2000 remaining...
	1000 remaining...
	0 remaining...
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/aligned
Emitting consensus sequences...
Sequential mode...
	3000 remaining...
	2000 remaining...
	1000 remaining...
	0 remaining...
Writing multi-hmm file...
Writing multi-fasta consensus file...
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/hmms
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/consensus_seqs
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/m8
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/paranoid_output
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/dmnd_tmp
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/faa
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/homolog_faa
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya-barseq-2021/dickeya_db/mcl
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
source("src/add_genes_to_orthogroups.R")
q()
~~~

Output: [locustag\_matrix\_with\_genes](dickeya_db/locustag_matrix_with_genes.txt)

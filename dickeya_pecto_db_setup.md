### PyParanoid "Dickeya/Pecto" database.

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
- PcWPP14 = GCF_013488025.1

~~~ bash
# Download protein sequence files for all strains. 
# Need to be in genomedb/pep/ folder. 
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/147/055/GCF_000147055.1_ASM14705v1/GCF_000147055.1_ASM14705v1_protein.faa.gz \
-O genomedb/pep/Dickeya_dadantii_3937.pep.fa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/003/403/135/GCF_003403135.1_ASM340313v1/GCF_003403135.1_ASM340313v1_protein.faa.gz \
-O genomedb/pep/Dickeya_dianthicola_ME23.pep.fa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/893/095/GCF_014893095.1_ASM1489309v1/GCF_014893095.1_ASM1489309v1_protein.faa.gz \
-O genomedb/pep/Dickeya_dianthicola_67-19.pep.fa.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/013/488/025/GCF_013488025.1_ASM1348802v1/GCF_013488025.1_ASM1348802v1_protein.faa.gz \
-O genomedb/pep/Pectobacterium_carotovorum_WPP14.pep.fa.gz

gunzip genomedb/pep/*pep.fa.gz

# Create PyParanoid strainlist.
ls genomedb/pep > genomedb/strainlist.txt
~~~

Remove ".pep.fa" from strainlist.txt. (Use text editor.)

[strainlist.txt](dickeya_pecto_db/strainlist.txt)  

#### Build genome database: dickeya\_pecto_db.

~~~ bash
BuildGroups.py --clean --verbose  --cpus 4 genomedb/ \
genomedb/strainlist.txt dickeya_pecto_db
~~~

Terminal output:

~~~
Formatting 4 fasta files...
Making diamond databases for 4 strains...
Running DIAMOND on all 4 strains...
	Done!
Getting gene lengths...
Parsing diamond results for 4 strains...
	Done!
Running InParanoid on 6 pairs of strains...
Sequential mode...
	0 remaining...
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/out
Parsing 6 output files.
	Done!
[mclIO] writing </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/mcl/data.mci>
.......................................
[mclIO] wrote native interchange 14358x14358 matrix with 39108 entries to stream </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/mcl/data.mci>
[mclIO] wrote 14358 tab entries to stream </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/mcl/data.tab>
[mcxload] tab has 14358 entries
[mclIO] reading </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/mcl/data.mci>
.......................................
[mclIO] read native interchange 14358x14358 matrix with 39108 entries
[mcl] pid 55978
 ite   chaos  time hom(avg,lo,hi) m-ie m-ex i-ex fmv
  1     1.08  0.03 1.00/0.66/1.46 1.02 1.02 1.02   0
  2     1.36  0.04 1.00/0.64/1.14 1.00 1.00 1.02   0
  3     1.79  0.04 0.99/0.37/1.33 1.00 1.00 1.02   0
  4     2.13  0.05 0.99/0.40/1.48 1.00 1.00 1.01   0
  5     1.31  0.04 0.99/0.38/1.29 1.00 0.99 1.00   0
  6     1.15  0.04 0.99/0.48/1.18 1.00 0.99 0.99   0
  7     0.97  0.04 1.00/0.53/1.14 1.00 0.99 0.98   0
  8     1.03  0.04 1.00/0.54/1.00 1.00 0.99 0.97   0
  9     0.91  0.04 1.00/0.63/1.00 1.00 1.00 0.97   0
 10     0.72  0.04 1.00/0.58/1.00 1.00 1.00 0.97   0
 11     0.48  0.04 1.00/0.65/1.00 1.00 1.00 0.96   0
 12     0.50  0.04 1.00/0.63/1.00 1.00 1.00 0.96   0
 13     0.33  0.04 1.00/0.76/1.00 1.00 1.00 0.96   0
 14     0.25  0.04 1.00/0.76/1.00 1.00 1.00 0.96   0
 15     0.15  0.04 1.00/0.85/1.00 1.00 1.00 0.96   0
 16     0.02  0.04 1.00/0.98/1.00 1.00 1.00 0.96   0
 17     0.00  0.04 1.00/1.00/1.00 1.00 1.00 0.96   0
 18     0.00  0.04 1.00/1.00/1.00 1.00 1.00 0.96   0
[mcl] cut <5> instances of overlap
[mcl] jury pruning marks: <100,100,99>, out of 100
[mcl] jury pruning synopsis: <99.9 or perfect> (cf -scheme, -do log)
[mclIO] writing </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/mcl/mcl.out>
.......................................
[mclIO] wrote native interchange 14358x4016 matrix with 14358 entries to stream </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/mcl/mcl.out>
[mcl] 4016 clusters found
[mcl] output is in /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/mcl/mcl.out

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

[mclIO] reading </Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/mcl/mcl.out>
.......................................
[mclIO] read native interchange 14358x4016 matrix with 14358 entries
Writing fasta files and parsing descriptions...
4017 groups equal to or larger than 2 sequences.
Clustering sequences...
Sequential mode...
	4000 remaining...
	3000 remaining...
	2000 remaining...
	1000 remaining...
	0 remaining...
Aligning groups...
Sequential mode...
	4000 remaining...
	3000 remaining...
	2000 remaining...
	1000 remaining...
	0 remaining...
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/clustered
Building hmms...
Sequential mode...
	4000 remaining...
	3000 remaining...
	2000 remaining...
	1000 remaining...
	0 remaining...
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/aligned
Emitting consensus sequences...
Sequential mode...
	4000 remaining...
	3000 remaining...
	2000 remaining...
	1000 remaining...
	0 remaining...
Writing multi-hmm file...
Writing multi-fasta consensus file...
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/hmms
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/consensus_seqs
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/m8
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/paranoid_output
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/dmnd_tmp
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/faa
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/homolog_faa
Cleaning up /Users/tylerhelmann/Documents/USDA/Projects/Tuber_TnSeq/dickeya_pecto_db/mcl

~~~

- [clusterstats.out](dickeya_pecto_db/clusterstats.out)  
- [Homolog matrix](dickeya_pecto_db/homolog_matrix.txt)  
- [Locustag matrix](dickeya_pecto_db/locustag_matrix.txt)  
- [Consensus sequences](dickeya_pecto_db/all_groups.faa)
- [Group descriptions](dickeya_pecto_db/group_descriptions.txt)


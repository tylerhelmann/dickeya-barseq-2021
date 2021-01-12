### PyParanoid "Dickeya/Pecto" database.

Run: 1/12/2021

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

Ortholog database to construct: "dickeya\_pecto_db"

#### Download RefSeq NCBI assemblies for 3937, ME23, 67-19, and WPP14. 

(Note: Check that these locusIds are compatible with BarSeq output.)

- 3937 = GCF_000147055.1
- ME23 = GCF_003403135.1
- 67-19 = GCF_014893095.1
- WPP14 = GCF_013488025.1

Copy protein sequence files for both strains.  
Create PyParanoid strainlist.

~~~ bash
# For dickeya_pecto_db:
cp data_raw/assemblies/GCF_000147055.1*protein.faa \
genomedb/pep/Dickeya_dadantii_3937.pep.fa
cp data_raw/assemblies/GCF_003403135.1*protein.faa \
genomedb/pep/Dickeya_dianthicola_ME23.pep.fa
cp data_raw/assemblies/GCF_014893095.1*protein.faa \
genomedb/pep/Dickeya_dianthicola_67-19.pep.fa
cp data_raw/assemblies/GCF_013488025.1*protein.faa \
genomedb/pep/Pectobacterium_carotovorum_WPP14.pep.fa

ls genomedb/pep > genomedb/strainlist.txt
~~~

Remove ".pep.fa" from strainlist.txt. (Use text editor.)

#### Build genome database: dickeya\_pecto_db.

~~~ bash
BuildGroups.py --clean --verbose  --cpus 4 genomedb/ \
genomedb/strainlist.txt dickeya_pecto_db
~~~

>Formatting 4 fasta files...  
Making diamond databases for 4 strains...  
Running DIAMOND on all 4 strains...  
Parsing diamond results for 4 strains...  
Running InParanoid on 6 pairs of strains...  
Parsing 6 output files.  
Writing fasta files and parsing descriptions...  
4017 groups equal to or larger than 2 sequences.  
Clustering sequences...  
Aligning groups...  
Building hmms...  
Emitting consensus sequences...  
Writing multi-hmm file...  
Writing multi-fasta consensus file...
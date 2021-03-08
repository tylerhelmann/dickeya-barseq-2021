## BarSeq: Genome-wide fitness of *Dickeya dadantii* 3937, *D. dianthicola* ME23, and *D. dianthicola* 67-19

System used: Linux CentOS 7.6 (40 core server, 256 Gb RAM)

RB-TnSeq citation: 

Wetmore, K.M., Price, M.N., Waters, R.J., Lamson, J.S., He, J., Hoover, C.A., Blow, M.J., Bristow, J., Butland, G., Arkin, A.P., Deutschbauer, A. Rapid Quantification of Mutant Fitness in Diverse Bacteria by Sequencing Randomly Bar-Coded Transposons. mBio 6 (3) e00306-15 (2015). DOI: [10.1128/mBio.00306-15](http://doi.org/10.1128/mBio.00306-15)

#### Conditions tested:

- LB
- PDB (potato dextrose broth)
- M9 minimal medium + 0.4% (v/v) glycerol
- Potato tuber, cv. "Atlantic"
- Potato tuber, cv. "Dark Red Norland"
- Potato tuber, cv. "Upstate Abundance"

--

#### Download inputs

Download FEBA repository.

~~~ bash
git clone -q https://bitbucket.org/berkeleylab/feba.git

# genbank2gff.pl is only a link. 
# Delete the link and replace the file with:
# https://github.com/ihh/gfftools/blob/master/genbank2gff.pl

rm -f feba/bin/genbank2gff.pl
cp genbank2gff.pl feba/bin/genbank2gff.pl
~~~

Copy the following inputs:

- Experimental metadata ([exp.txt](barseq_inputs/exp.txt))
- Gene lists 
	- 	[Dda3937_genes.GC](barseq_inputs/Dda3937_genes.GC)
	-  [DdiaME23_genes.GC](barseq_inputs/DdiaME23_genes.GC)
	-  [Ddia6719_genes.GC](barseq_inputs/Ddia6719_genes.GC)
- Mapped pool files 
	- [Dda3937.pool](library_mapping/Dda3937.pool)
	- [DdiaME23.pool](library_mapping/DdiaME23.pool)
	- [Ddia6719.pool](library_mapping/Ddia6719.pool)

#### Run MultiCodes.pl on all samples

Copy all BarSeq reads to inputs/. 

Create tasklist containing the following commands.   
This step counts barcode abundance for each sample ([seqfiles.txt](barseq_inputs/seqfiles.txt)).

~~~ bash
for i in $(cat inputs/seqfiles.txt); do
echo "gzip -dc inputs/${i}.fastq.gz | \
./feba/bin/MultiCodes.pl \
-out counts/${i} -index ${i} \
>& counts/${i}.log"
done > tasklist.txt
~~~

Run all commands from [tasklist](barseq_inputs/tasklist.txt). (Final # = nCPU.)  
(This task manager is specific to Cornell BioHPC servers.)

~~~ bash
mkdir counts/

/programs/bin/perlscripts/perl_fork_univ.pl tasklist.txt 40
~~~

#### Run CombineBarSeq.pl

Match barcodes with library.  
Use reference files listing library-specific indicies. 

- [Dda3937_codes.txt](barseq_inputs/Dda3937_codes.txt)
- [DdiaME23_codes.txt](barseq_inputs/DdiaME23_codes.txt)
- [Ddia6719_codes.txt](barseq_inputs/Ddia6719_codes.txt)

~~~ bash
mkdir results

for lib in Dda3937 DdiaME23 Ddia6719; do
./feba/bin/combineBarSeq.pl \
    results/${lib} \
    inputs/${lib}.pool \
    $(cat ${lib}_codes.txt) &
done	
~~~

Reads used:

- [Dda3937.colsum](barseq_out/Dda3937.colsum)
- [DdiaME23.colsum](barseq_out/DdiaME23.colsum)
- [Ddia6719.colsum](barseq_out/Ddia6719.colsum)

#### Run BarSeqR.pl for each library

Calculate per gene fitness.  

~~~ bash
# Fix feba/lib/PoolStats.R and feba/bin/RunFEBA.R shebang line. 
# For me needs to be: #!/usr/bin/env Rscript

for lib in Dda3937 DdiaME23 Ddia6719; do
mkdir results/${lib}

./feba/bin/BarSeqR.pl \
     -org ${lib} \
     -exps inputs/exp.txt \
     -genes inputs/${lib}_genes.GC \
     -pool inputs/${lib}.pool \
     -indir results \
     -outdir results/${lib} \
    ${lib} &
    
done
~~~

Output:  

- [Dda3937](barseq_out/Dda3937)  
- [DdiaME23](barseq_out/DdiaME23)  
- [Ddia6719](barseq_out/Ddia6719)  

All non-time0 experiments passed QC requirements except TCH193 (Dda3937), TCH202, TCH205, and TCH232 (Ddia6719). See logs:

- [Dda3937 log](barseq_out/Dda3937/log)
- [DdiaME23 log](barseq_out/DdiaME23/log)
- [Ddia6719 log](barseq_out/Ddia6719/log)

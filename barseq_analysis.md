## BarSeq: Genome-wide fitness of *Dickeya dadantii* 3937, *D. dianthicola* ME23, *D. dianthicola* 67-19 and *Pectobacterium carotovorum* WPP14

System: Linux CentOS 7.6 (24 core server)

RB-TnSeq citation: 

Wetmore, K.M., Price, M.N., Waters, R.J., Lamson, J.S., He, J., Hoover, C.A., Blow, M.J., Bristow, J., Butland, G., Arkin, A.P., Deutschbauer, A. Rapid Quantification of Mutant Fitness in Diverse Bacteria by Sequencing Randomly Bar-Coded Transposons. mBio 6 (3) e00306-15 (2015). DOI: 10.1128/mBio.00306-15

#### Conditions tested:

- LB
- PDB (potato dextrose broth)
- M9 minimal medium + 0.4% (v/v) glycerol
- Potato tuber, cv. "Atlantic"
- Potato tuber, cv. "Norland"
- Potato tuber, cv. "Upstate"

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
- Gene lists (ex: [Dda3937_genes.GC](barseq_inputs/Dda3937_genes.GC))
- Mapped pool files (ex: [Dda3937.pool](library_mapping/Dda3937.pool))

#### Run MultiCodes.pl on all samples

Copy all BarSeq reads to inputs/. 

Create tasklist containing the following commands.   
This step counts barcode abundance for each sample.

~~~ bash
for i in $(cat inputs/seqfiles.txt); do
echo "gzip -dc inputs/TCH${i}.fastq.gz | \
./feba/bin/MultiCodes.pl \
-out counts/TCH${i} -index TCH${i} \
>& counts/TCH${i}.log"
done > tasklist.txt
~~~

Run all commands from tasklist. (Final # = nCPU.)  
(This task manager is specific to Cornell BioHPC servers.)

~~~ bash
mkdir counts/

/programs/bin/perlscripts/perl_fork_univ.pl tasklist.txt 24
~~~

#### Run CombineBarSeq.pl

Match indicies with library.  
Create separate files listing library-specific indicies. 

~~~ bash
mkdir results

for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
./feba/bin/combineBarSeq.pl \
    results/${lib} \
    inputs/${lib}.pool \
	$(cat ${lib}_codes.txt)
done
	
~~~

(Where does log output? Save to separate files.)

#### Run BarSeqR.pl for each library

~~~ bash
# Fix feba/lib/PoolStats.R and feba/bin/RunFEBA.R shebang line. 
# For me needs to be: #!/usr/bin/env Rscript

# Calculate per gene fitness.
for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
mkdir results/${pool}

./feba/bin/BarSeqR.pl \
     -org ${lib} \
     -exps inputs/exp.txt \
     -genes inputs/${lib}_genes.GC \
     -pool inputs/${lib}.pool \
     -indir results \
     -outdir results/${lib} \
    ${lib}
    
done
~~~


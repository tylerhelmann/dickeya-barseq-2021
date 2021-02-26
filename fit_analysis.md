## Analysis of BarSeq fitness data

#### Add ortholog groups to strong.tab lists

Split strong.tab files by treatment.  

~~~ bash
mkdir -p barseq_analysis/strong

for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
for treatment in LB PDB M9 Atlantic Norland Upstate; do

cat barseq_out/${lib}/strong.tab | \
grep ${treatment} \
> barseq_analysis/strong/${lib}_${treatment}_strong.tab

done
done
~~~

To match gene locusIds with PyParanoid groups, search locustag\_matrix\_with\_genes.txt metadata.
Run for strong.tab gene lists from all strains & conditions.

~~~ bash
for sample in $(ls barseq_analysis/strong/*strong.tab); do
for gene in $(cat $sample | cut -f 1); do

if cat dickeya_pecto_db/locustag_matrix_with_genes.txt | \
grep -q $gene
then
cat dickeya_pecto_db/locustag_matrix_with_genes.txt | \
grep -m 1 $gene | \
cut -f 1 -d ,
else
echo NA
fi

done > ${sample}_groups.txt
done
~~~

Use 'paste' to add column of group numbers to strong.tab tables.

~~~ bash
for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
for sample in LB PDB M9 Atlantic Norland Upstate; do

paste barseq_analysis/strong/${lib}_${sample}_strong.tab \
barseq_analysis/strong/${lib}_${sample}_strong.tab_groups.txt \
> barseq_analysis/strong/${lib}_${sample}_strong.tab

done
done
~~~

#### Calculate overlap between treatments and then strains

Print list of all unique groups from a given file.

~~~ bash
for lib in Dda3937 DdiaME23 Ddia6719 PcWPP14; do
for sample in LB PDB M9 Atlantic Norland Upstate; do

cat barseq_analysis/strong/${lib}_${sample}_strong.tab | \
cut -f 8 | \
uniq > barseq_analysis/strong/${lib}_${sample}_groups_unique.txt

done
done

~~~
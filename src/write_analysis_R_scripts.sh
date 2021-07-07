#! bash 

echo "require(magrittr)"

for lib in Dda3937 DdiaME23 Ddia6719; do
for treatment in LB PDB M9 tuber; do

echo "freq_${lib}_${treatment} <- table(fit_${lib}_${treatment}\$locusId) %>% as.data.frame"

echo "freq_${lib}_${treatment}\$desc <- fit_${lib}\$desc[match(freq_${lib}_${treatment}\$Var1, fit_${lib}\$locusId)]"
echo "freq_${lib}_${treatment}\$COG <- locustag_matrix_with_genes\$COG[match(freq_${lib}_${treatment}\$Var1, locustag_matrix_with_genes\$${lib}_locus)]"
echo "freq_${lib}_${treatment}\$group <- locustag_matrix_with_genes\$X[match(freq_${lib}_${treatment}\$Var1, locustag_matrix_with_genes\$${lib}_locus)]"

echo "write.csv(freq_${lib}_${treatment}, \"analysis/${lib}_${treatment}.csv\", row.names = F)"

done
done

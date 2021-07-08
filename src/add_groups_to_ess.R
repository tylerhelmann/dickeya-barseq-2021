
# Load ess tables from library mapping.
Dda3937_ess <- read.delim("library_mapping/Dda3937.ess", header = T)
DdiaME23_ess <- read.delim("library_mapping/DdiaME23.ess", header = T)
Ddia6719_ess <- read.delim("library_mapping/Ddia6719.ess", header = T)

# Load group data from PyParanoid.
groups <- read.csv("dickeya_db/locustag_matrix_with_genes.txt", header = T)

# Add group data to ess tables. 
Dda3937_ess$group <- groups$X[match(Dda3937_ess$locusId, groups$Dda3937_locus)]
DdiaME23_ess$group <- groups$X[match(DdiaME23_ess$locusId, groups$DdiaME23_locus)]
Ddia6719_ess$group <- groups$X[match(Ddia6719_ess$locusId, groups$Ddia6719_locus)]

# Save new ess tables with groups. 
write.csv(Dda3937_ess, "analysis/Dda3937.ess.csv", row.names = F)
write.csv(DdiaME23_ess, "analysis/DdiaME23.ess.csv", row.names = F)
write.csv(Ddia6719_ess, "analysis/Ddia6719.ess.csv", row.names = F)


# Starting with the PyParanoid locustag_matrix, convert protein accessions to RefSeq locusIds.

library(magrittr)
library(tidyr)

# Load locustag_matrix.
locustag_matrix <- read.delim("dickeya_pecto_db/locustag_matrix.txt", header = T)

# Import RefSeq "feature tables" to match protein ID ("product_accession") with "locus_tag".
features_Dda3937 <- read.delim("dickeya_pecto_db/Dda3937_feature_table.txt", header = T)
features_DdiaME23 <- read.delim("dickeya_pecto_db/DdiaME23_feature_table.txt", header = T)
features_Ddia6719 <- read.delim("dickeya_pecto_db/Ddia67_19_feature_table.txt", header = T)
features_PcWPP14 <- read.delim("dickeya_pecto_db/PcWPP14_feature_table.txt", header = T)

# Filter feature tables for CDS only, to use protein accession values present.
features_Dda3937 <- features_Dda3937[which(features_Dda3937$X..feature == "CDS"),]
features_DdiaME23 <- features_DdiaME23[which(features_DdiaME23$X..feature == "CDS"),]
features_Ddia6719 <- features_Ddia6719[which(features_Ddia6719$X..feature == "CDS"),]
features_PcWPP14 <- features_PcWPP14[which(features_PcWPP14$X..feature == "CDS"),]

# Split groups containing multiple orthologs within a single strain. 
# Note: duplicates other columns.
locustag_matrix <- separate_rows(locustag_matrix, "Dickeya_dadantii_3937", sep = ";")
locustag_matrix <- separate_rows(locustag_matrix, "Dickeya_dianthicola_ME23", sep = ";")
locustag_matrix <- separate_rows(locustag_matrix, "Dickeya_dianthicola_67_19", sep = ";")
locustag_matrix <- separate_rows(locustag_matrix, "Pectobacterium_carotovorum_WPP14", sep = ";")

# Add locusIds.
locustag_matrix$Dda3937_locus <- features_Dda3937$locus_tag[match(locustag_matrix$Dickeya_dadantii_3937,
                                                                  features_Dda3937$product_accession)]
locustag_matrix$DdiaME23_locus <- features_DdiaME23$locus_tag[match(locustag_matrix$Dickeya_dianthicola_ME23,
                                                                    features_DdiaME23$product_accession)]
locustag_matrix$Ddia6719_locus <- features_Ddia6719$locus_tag[match(locustag_matrix$Dickeya_dianthicola_67_19,
                                                                    features_Ddia6719$product_accession)]
locustag_matrix$PcWPP14_locus <- features_PcWPP14$locus_tag[match(locustag_matrix$Pectobacterium_carotovorum_WPP14,
                                                                  features_PcWPP14$product_accession)]

# Save output.
write.csv(locustag_matrix, "dickeya_pecto_db/locustag_matrix_with_genes.txt",
          row.names = F)




# Import GenBank x RefSeq locusIds.
# Feature table: https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/147/055/GCF_000147055.1_ASM14705v1/GCF_000147055.1_ASM14705v1_feature_table.txt.gz
Dda3937_feature_list <- read.delim("dickeya_db/Dda3937_feature_table.txt", header = T)

# Trim. (Ex: "old_locus_tag=Dda3937_00155" to "Dda3937_00155" only)
Dda3937_feature_list$attributes <- gsub(".*=", "", Dda3937_feature_list$attributes)

# Annotate genes by list.
Dda3937_feature_list$COG <- "none"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% amino_acid_transport_and_metabolism$Locus.Tag] <- "amino acid transport and metabolism"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% carbohydrate_transport_and_metabolism$Locus.Tag] <- "carbohydrate transport and metabolism"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% cell_cycle_control_cell_division_chromosome_partitioning$Locus.Tag] <- "cell cycle control, cell division, chromosome partitioning"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% cell_motility$Locus.Tag] <- "cell motility"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% cell_wall_membrane_envelope_biogenesis$Locus.Tag] <- "cell wall/membrane/envelope biogenesis"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% coenzyme_transport_and_metabolism$Locus.Tag] <- "coenzyme transport and metabolism"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% defense_mechanisms$Locus.Tag] <- "defense mechanisms"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% energy_production_and_conversion$Locus.Tag] <- "energy production and conversions"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% extracellular_structures$Locus.Tag] <- "extracellular structures"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% function_unknown$Locus.Tag] <- "function unknown"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% general_function_prediction_only$Locus.Tag] <- "general function prediction only"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% inorganic_ion_transport_and_metabolism$Locus.Tag] <- "inorganic ion transport and metabolism"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% intracellular_trafficking_secretion_and_vesicular_transport$Locus.Tag] <- "intracellular trafficking, secretion, and vesicular transport"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% lipid_transport_and_metabolism$Locus.Tag] <- "lipid transport and metabolism"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% mobilome_prophages_transposons$Locus.Tag] <- "mobilome: prophages, transposons"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% nucleotide_transport_and_metabolism$Locus.Tag] <- "nucleotide transport and metabolism"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% posttranslational_modification_protein_turnover_chaperones$Locus.Tag] <- "postranslational modification, protein turnover, chaperones"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% replication_recombination_and_repair$Locus.Tag] <- "replication, recombination, and repair"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% RNA_processing_and_modification$Locus.Tag] <- "RNA processing and modification"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% secondary_metabolites_biosynthesis_transport_and_catabolism$Locus.Tag] <- "secondary metabolites biosynthesis, transport, and catabolism"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% signal_transduction_mechanisms$Locus.Tag] <- "signal transduction mechanisms"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% transcription$Locus.Tag] <- "transcription"
Dda3937_feature_list$COG[Dda3937_feature_list$attributes %in% translation_ribosomal_structure_and_biogenesis$Locus.Tag] <- "translation, ribosomal structure, and biogenesis"

# Save file.
write.csv(Dda3937_feature_list, "analysis/Dda3937_feature_table_COG.txt", row.names = F)

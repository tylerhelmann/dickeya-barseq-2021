# Scripts and data used in Helmann *et al*. 2021

#### Title: Genome-wide identification of genes important for growth of *Dickeya dadantii* and *D. dianthicola* in potato (*Solanum tuberosum*) tubers

Abstract: 

*Dickeya* species are causal agents of soft rot diseases in many economically important crops, including soft rot disease of potato (*Solanum tuberosum*). Using random barcode transposon-site sequencing (RB-TnSeq), we generated genome-wide mutant fitness profiles of *D. dadantii* 3937, *D. dianthicola* ME23, and *D. dianthicola* 67-19 isolates collected after passage through in vitro (LB, Potato Dextrose Broth, and M9 minimal medium) and in vivo (tubers) conditions. The potato cultivars “Atlantic”, “Dark Red Norland”, and “Upstate Abundance” provided highly similar local conditions for bacterial growth. Using the homolog detection software PyParanoid, we matched fitness values for orthologous genes in the three strains. Direct comparison of fitness among the strains highlighted shared and variable traits important for growth. Bacterial growth in minimal medium required many metabolic traits that were also essential for competitive growth *in planta*, such as amino acid, carbohydrate, and nucleotide biosynthesis. Growth in tubers specifically required the pectin degradation gene *kduD*. Disruption in three putative DNA-binding proteins had strain-specific effects on competitive fitness in tubers. Though the Soft Rot *Pectobacteriaceae* can cause disease with little host specificity, it remains to be seen the extent to which strain-level variation impacts virulence. 

Strains included in this project:

- *Dickeya dadantii* 3937
- *Dickeya dianthicola* ME23
- *Dickeya dianthicola* 67-19

### Generating a PyParanoid ortholog database

[dickeya\_db\_setup.md](dickeya_db_setup.md)

Data included in [dickeya\_db/](dickeya_db/)

### Mapping barcoded *mariner* transposon libraries in these strains

[lib_mapping.md](lib_mapping.md)

Data included in [library\_mapping/](library_mapping/)

Includes predicted essential genes tables.  
Process tables to add ortholog groups: [ess_analysis.md](ess_analysis.md)

### Measuring genome-wide fitness with BarSeq *in vitro* and *in planta*

[barseq_analysis.md](barseq_analysis.md)

Data included in [barseq\_inputs/](barseq\_inputs/) and [barseq_out/](barseq_out/)

### General analysis

[fit_analysis.md](fit_analysis.md)
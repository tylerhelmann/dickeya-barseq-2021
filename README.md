# Scripts and data used in Helmann *et al*. 2022

Publication: [https://doi.org/10.3389/fmicb.2022.778927](https://doi.org/10.3389/fmicb.2022.778927)

Citation: Helmann TC, Filiatrault MJ and Stodghill PV (2022) Genome-Wide Identification of Genes Important for Growth of *Dickeya dadantii* and *Dickeya dianthicola* in Potato (*Solanum tuberosum*) Tubers. *Front. Microbiol.* 13:778927. doi: 10.3389/fmicb.2022.778927

Preprint: [https://doi.org/10.1101/2021.09.16.460530](https://doi.org/10.1101/2021.09.16.460530)

#### Title: Genome-wide identification of genes important for growth of *Dickeya dadantii* and *D. dianthicola* in potato (*Solanum tuberosum*) tubers

Abstract: 

*Dickeya* species are causal agents of soft rot diseases in many economically important crops, including soft rot disease of potato (*Solanum tuberosum*). Using random barcode transposon-site sequencing (RB-TnSeq), we generated genome-wide mutant fitness profiles of *Dickeya dadantii* 3937, *Dickeya dianthicola* ME23, and *Dickeya dianthicola* 67-19 isolates collected after passage through several *in vitro* and *in vivo* conditions. Though all three strains are pathogenic on potato, *D. dadantii* 3937 is a well-characterized model while *D. dianthicola* strains ME23 and 67-19 are recent isolates. Strain ME23 specifically was identified as a representative strain from a 2014 outbreak on potato. This study generated comparable gene fitness measurements across ecologically relevant conditions for both model and non-model strains. Tubers from the potato cultivars “Atlantic”, “Dark Red Norland”, and “Upstate Abundance” provided highly similar conditions for bacterial growth. Using the homolog detection software PyParanoid, we matched fitness values for orthologous genes in the three bacterial strains. Direct comparison of fitness among the strains highlighted shared and variable traits important for growth. Bacterial growth in minimal medium required many metabolic traits that were also essential for competitive growth *in planta*, such as amino acid, carbohydrate, and nucleotide biosynthesis. Growth in tubers specifically required the pectin degradation gene *kduD*. Disruption in three putative DNA-binding proteins had strain-specific effects on competitive fitness in tubers. Though the Soft Rot *Pectobacteriaceae* can cause disease with little host specificity, it remains to be seen the extent to which strain-level variation impacts virulence.

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
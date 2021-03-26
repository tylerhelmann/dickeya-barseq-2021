
library(magrittr)

create_freq_lists <- function(){
  
  freq_Dda3937_LB <<- table(fit_Dda3937_LB$locusId) %>% as.data.frame
  freq_Dda3937_M9 <<- table(fit_Dda3937_M9$locusId) %>% as.data.frame
  freq_Dda3937_tuber <<- table(fit_Dda3937_tuber$locusId) %>% as.data.frame
  
  freq_DdiaME23_LB <<- table(fit_DdiaME23_LB$locusId) %>% as.data.frame
  freq_DdiaME23_M9 <<- table(fit_DdiaME23_M9$locusId) %>% as.data.frame
  freq_DdiaME23_tuber <<- table(fit_DdiaME23_tuber$locusId) %>% as.data.frame
  
  freq_Ddia6719_LB <<- table(fit_Ddia6719_LB$locusId) %>% as.data.frame
  freq_Ddia6719_M9 <<- table(fit_Ddia6719_M9$locusId) %>% as.data.frame
  freq_Ddia6719_tuber <<- table(fit_Ddia6719_tuber$locusId) %>% as.data.frame
  
}

add_gene_desc_and_COG <- function(){
  
  freq_Dda3937_LB$desc <<- fit_Dda3937$desc[match(freq_Dda3937_LB$Var1, fit_Dda3937$locusId)]
  freq_Dda3937_M9$desc <<- fit_Dda3937$desc[match(freq_Dda3937_M9$Var1, fit_Dda3937$locusId)]
  freq_Dda3937_tuber$desc <<- fit_Dda3937$desc[match(freq_Dda3937_tuber$Var1, fit_Dda3937$locusId)]
  
  freq_Dda3937_LB$COG <<- locustag_matrix_with_genes$COG[match(freq_Dda3937_LB$Var1, locustag_matrix_with_genes$Dda3937_locus)]
  freq_Dda3937_M9$COG <<- locustag_matrix_with_genes$COG[match(freq_Dda3937_M9$Var1, locustag_matrix_with_genes$Dda3937_locus)]
  freq_Dda3937_tuber$COG <<- locustag_matrix_with_genes$COG[match(freq_Dda3937_tuber$Var1, locustag_matrix_with_genes$Dda3937_locus)]
  
  freq_DdiaME23_LB$desc <<- fit_DdiaME23$desc[match(freq_DdiaME23_LB$Var1, fit_DdiaME23$locusId)]
  freq_DdiaME23_M9$desc <<- fit_DdiaME23$desc[match(freq_DdiaME23_M9$Var1, fit_DdiaME23$locusId)]
  freq_DdiaME23_tuber$desc <<- fit_DdiaME23$desc[match(freq_DdiaME23_tuber$Var1, fit_DdiaME23$locusId)]
  
  freq_DdiaME23_LB$COG <<- locustag_matrix_with_genes$COG[match(freq_DdiaME23_LB$Var1, locustag_matrix_with_genes$DdiaME23_locus)]
  freq_DdiaME23_M9$COG <<- locustag_matrix_with_genes$COG[match(freq_DdiaME23_M9$Var1, locustag_matrix_with_genes$DdiaME23_locus)]
  freq_DdiaME23_tuber$COG <<- locustag_matrix_with_genes$COG[match(freq_DdiaME23_tuber$Var1, locustag_matrix_with_genes$DdiaME23_locus)]
  
  freq_Ddia6719_LB$desc <<- fit_Ddia6719$desc[match(freq_Ddia6719_LB$Var1, fit_Ddia6719$locusId)]
  freq_Ddia6719_M9$desc <<- fit_Ddia6719$desc[match(freq_Ddia6719_M9$Var1, fit_Ddia6719$locusId)]
  freq_Ddia6719_tuber$desc <<- fit_Ddia6719$desc[match(freq_Ddia6719_tuber$Var1, fit_Ddia6719$locusId)]
  
  freq_Ddia6719_LB$COG <<- locustag_matrix_with_genes$COG[match(freq_Ddia6719_LB$Var1, locustag_matrix_with_genes$Ddia6719_locus)]
  freq_Ddia6719_M9$COG <<- locustag_matrix_with_genes$COG[match(freq_Ddia6719_M9$Var1, locustag_matrix_with_genes$Ddia6719_locus)]
  freq_Ddia6719_tuber$COG <<- locustag_matrix_with_genes$COG[match(freq_Ddia6719_tuber$Var1, locustag_matrix_with_genes$Ddia6719_locus)]
  
}

save_freq_lists <- function(){
  
  write.csv(freq_Dda3937_LB, "analysis/Dda3937_LB.csv", row.names = F)
  write.csv(freq_Dda3937_M9, "analysis/Dda3937_M9.csv", row.names = F)
  write.csv(freq_Dda3937_tuber, "analysis/Dda3937_tuber.csv", row.names = F)
  
  write.csv(freq_DdiaME23_LB, "analysis/DdiaME23_LB.csv", row.names = F)
  write.csv(freq_DdiaME23_M9, "analysis/DdiaME23_M9.csv", row.names = F)
  write.csv(freq_DdiaME23_tuber, "analysis/DdiaME23_tuber.csv", row.names = F)
  
  write.csv(freq_Ddia6719_LB, "analysis/Ddia6719_LB.csv", row.names = F)
  write.csv(freq_Ddia6719_M9, "analysis/Ddia6719_M9.csv", row.names = F)
  write.csv(freq_Ddia6719_tuber, "analysis/Ddia6719_tuber.csv", row.names = F)
  
}


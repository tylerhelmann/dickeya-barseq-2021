

library(magrittr)

# Save list of genes with significant phenotypes, defined as:
# |fitness| > 1 and |t| > 4.

# Code adapted from strong.tab file creation in:
# https://bitbucket.org/berkeleylab/feba/src/master/lib/FEBA.R

# Also, remove gene fitness values from experiments that failed QC metrics.

listSigGenes <- function(fit, name_to_save){
  d = which(abs(fit$lrn) > 1 & abs(fit$t) > 4, arr.ind=T)
  out = data.frame(locusId=fit$g[d[,1]], name=names(fit$lrn)[d[,2]], lrn=fit$lrn[d], t=fit$t[d])
  out = merge(genes[,c("locusId", "sysName", "desc")], merge(fit$expsUsed[,c("name","short")], out))
  
  successful_exps <- fit$q$name[fit$q$u]
  out <- out[which(out$name %in% successful_exps),]
  
  write.csv(out, file = name_to_save, row.names = F)
}

returnFalsePos <- function(fit){
  # List Time0 experiments.
  time0_exps <- fit$q$name[fit$q$short=="Time0"]
  print(paste(fit$expsUsed$SetName[1], ":", length(time0_exps), "time0 experiments"))
  
  # For each, count gene fitness values that pass significance cutoffs.
  for (i in time0_exps) {
    print((abs(fit$lrn[i]) > 1 & abs(fit$t[i]) > 4) %>% sum)
  }
}

# Run this function for fit data across all three Dickeya libraries.

load("barseq_out/Dda3937/fit.image")
listSigGenes(fit, "analysis/Dda3937_phenotype.tab")
returnFalsePos(fit) 

load("barseq_out/DdiaME23/fit.image")
listSigGenes(fit, "analysis/DdiaME23_phenotype.tab")
returnFalsePos(fit)

load("barseq_out/Ddia6719/fit.image")
listSigGenes(fit, "analysis/Ddia6719_phenotype.tab")
returnFalsePos(fit)




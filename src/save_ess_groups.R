
# Write lists of group names for predicted essential genes.

Dda3937_ess <- read.csv("analysis/Dda3937.ess.csv", header = T)
DdiaME23_ess <- read.csv("analysis/DdiaME23.ess.csv", header = T)
Ddia6719_ess <- read.csv("analysis/Ddia6719.ess.csv", header = T)

# Save only "group" column for genes that are predicted essential.
write(Dda3937_ess$group[which(Dda3937_ess$ess)], "analysis/Dda3937_ess_groups.txt")
write(DdiaME23_ess$group[which(DdiaME23_ess$ess)], "analysis/DdiaME23_ess_groups.txt")
write(Ddia6719_ess$group[which(Ddia6719_ess$ess)], "analysis/Ddia6719_ess_groups.txt")


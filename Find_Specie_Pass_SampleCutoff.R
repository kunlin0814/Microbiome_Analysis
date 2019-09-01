library(dplyr)
library(readxl)

sample_species <- read_excel("/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx", sheet = "TCGA_Gtex_sig_gt20")
significant_species <- read_excel("/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx", sheet = "Gtex_TCGA_species_differ_adjust")
TCGA_species <- sample_species$TCGA_species
TCGA_sample_ratio <- sample_species$TCGA_samplegtcutoff_ratio
Gtex_species <- sample_species$Gtex_species
Gtex_sample_ratio <- sample_species$Gtex_samplegtcutoff_ratio
Significant_species <- significant_species$Species
adjust_pvalue <- sample_species$Benjamini_Hochberg_FDR
total_adjust_pvalue <- significant_species$`Benjamini and Hochberg , FDR`
TCGA_overlap <- c()
Gtex_overlap <- c()


TCGA_List <- TCGA_sample_ratio
names(TCGA_List) <- TCGA_species

Gtex_List <- Gtex_sample_ratio
names(Gtex_List) <- Gtex_species

for (i in Top40){
  if (i %in% TCGA_species){
    TCGA_overlap <- c(TCGA_overlap, i)
  }
}
for (i in Top40){
  if (i %in% Gtex_species){
    Gtex_overlap <- c(Gtex_overlap, i)
  }
}

TCGA_overlap_species <- c()
TCGA_overlap_species_pvalue <- c()
Gtex_overlap_species <- c()
Gtex_overlap_species_pvalue <- c()
TCGA_pvalue_sample_amount <- c()
Gtex_pvalue_sample_amount <- c()
## create a list( dict like structure)
Species_adj_pvalue <- total_adjust_pvalue
names(Species_adj_pvalue) <- Top40
for (i in Top40){
  if (i %in% TCGA_overlap){
    TCGA_overlap_species <- c(TCGA_overlap_species,i)
    TCGA_overlap_species_pvalue <- c(TCGA_overlap_species_pvalue,Species_adj_pvalue[[i]])
    TCGA_pvalue_sample_amount <- c(TCGA_pvalue_sample_amount,TCGA_List[[i]] )
  }
  if (i %in% Gtex_overlap){
    Gtex_overlap_species <- c(Gtex_overlap_species,i)
    Gtex_overlap_species_pvalue <- c(Gtex_overlap_species_pvalue,Species_adj_pvalue[[i]])
    Gtex_pvalue_sample_amount <- c(Gtex_pvalue_sample_amount,Gtex_List[[i]])
  }
}
combine <- data.frame(TCGA_overlap=TCGA_overlap_species,TCGA_overlap_pvalue=TCGA_overlap_species_pvalue,
                      TCGA_sample_ratio= TCGA_pvalue_sample_amount, 
                      Gtex_sample_ratio = Gtex_pvalue_sample_amount)
write.table(combine,"/Users/kun-linho/Desktop/Species_pass_Sample_cutoff.txt",row.names = F, quote= F, sep = '\t')

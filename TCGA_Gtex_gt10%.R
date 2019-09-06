## in this script, I was going to give a cutoff for TCGA sample ratio, but now I decide to keep everything 
## and use excel to sort the TCGA ratio for me

library(dplyr)
library(readxl)
library(Biobase)

Gtex_sig_data <- read_excel("/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx", sheet = 'Gtex_species_significant')
TCGA_sig_data <- read_excel("/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx", sheet = 'TCGA_species_significant')
Gtex_sig_data <- as.matrix(Gtex_sig_data)
TCGA_sig_data <- as.matrix(TCGA_sig_data)
col_names <-colnames(Gtex_sig_data)
colnames(Gtex_sig_data) <- NULL
colnames(TCGA_sig_data) <- NULL
Gtex_sample_amount <- length(Gtex_sig_data[,1])
TCGA_sample_amount <- length(TCGA_sig_data[,1])
sample_amout_cuttoff <- 0.2
Gtex_species_gtcutoff <- c()
TCGA_species_gtcutoff <- c()
Gtex_sample_number <- c()
TCGA_sample_number <- c()
TCGA_each_species_median <- c()
Gtex_each_species_median <- c()
species_name <- c()


# for ( i in 1:length(col_names)){
#   TCGA_median_value <- median(TCGA_sig_data[ ,i])
#   Gtex_median_value <- median(Gtex_sig_data[ ,i])
#   TCGA_each_species_median <- c(TCGA_each_species_median, TCGA_median_value)
#   Gtex_each_species_median <- c(Gtex_each_species_median, Gtex_median_value)
#   species_name <- c(species_name,col_names[i] )
# }
# TCGA_List <- TCGA_each_species_median
# names(TCGA_List) <- species_name
# 
# Gtex_List <- Gtex_each_species_median
# names(Gtex_List) <- species_name

for (i in 1:length(col_names)){
  Gtex_sample_gtcutoff <- c()
  for (j in 1:Gtex_sample_amount){
    Gtex_species_enrichment <- Gtex_sig_data[j,i] 
    if (Gtex_species_enrichment > 0){
      Gtex_sample_gtcutoff <- c(Gtex_sample_gtcutoff, Gtex_species_enrichment)
    }
  }
  if (length(Gtex_sample_gtcutoff) >= 0){
    Gtex_species_gtcutoff <- c(Gtex_species_gtcutoff,col_names[i] )
    Gtex_sample_number <- c(Gtex_sample_number,length(Gtex_sample_gtcutoff)/Gtex_sample_amount)
    Gtex_median_value <- median(Gtex_sig_data[ ,i] )
    Gtex_each_species_median <- c(Gtex_each_species_median, Gtex_median_value)
  }
  else {
    print(paste("Gtex ",col_names[i],"didn't pass", sep="",collapse="" ))
  }
}
for (i in 1:length(col_names)){
  TCGA_sample_gtcutoff <- c()
  for (j in 1:TCGA_sample_amount){
    TCGA_species_enrichment <- TCGA_sig_data[j,i] 
    if (TCGA_species_enrichment > 0){
      TCGA_sample_gtcutoff <- c(TCGA_sample_gtcutoff, TCGA_species_enrichment)
    }
  }
  if (length(TCGA_sample_gtcutoff) >= 0){
    TCGA_species_gtcutoff <- c(TCGA_species_gtcutoff,col_names[i] )
    TCGA_sample_number <- c(TCGA_sample_number ,length(TCGA_sample_gtcutoff)/TCGA_sample_amount)
    TCGA_median_value <- median(TCGA_sig_data[ ,i] )
    TCGA_each_species_median <- c(TCGA_each_species_median,TCGA_median_value )
    
  }
  else {
    print( paste("TCGA ",col_names[i],"didn't pass", sep="",collapse="" ))
  }
}

n <- max(length(TCGA_species_gtcutoff),length(Gtex_species_gtcutoff))
new_Gtex_species_gtcutoff = c(Gtex_species_gtcutoff, rep(NA,n - length(Gtex_species_gtcutoff)))
new_TCGA_species_gtcutoff = c(TCGA_species_gtcutoff, rep(NA,n - length(TCGA_species_gtcutoff)))
new_TCGA_sample_number <- c(TCGA_sample_number, rep(NA,n - length(TCGA_sample_number)))
new_Gtex_sample_number <- c(Gtex_sample_number, rep(NA,n - length(Gtex_sample_number)))
new_Gtex_each_species_median = c(Gtex_each_species_median, rep(NA,n - length(Gtex_each_species_median)))
new_TCGA_each_species_median = c(TCGA_each_species_median, rep(NA,n - length(TCGA_each_species_median)))

df <- data.frame(TCGA_species=new_TCGA_species_gtcutoff, TCGA_samplegtcutoff_ratio =new_TCGA_sample_number, TCGA_species_median=new_TCGA_each_species_median,  
                 Gtex_species=new_Gtex_species_gtcutoff, Gtex_samplegtcutoff_ratio=new_Gtex_sample_number,Gtex_species_median=new_Gtex_each_species_median)
#write.table(df, file= '/Users/kun-linho/Desktop/TCGA_Gtex_TotalSpecies_Sign_nocutoff.txt', row.names = F, quote= F, sep = '\t')


################# second part #####################

significant_species <- read_excel("/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx", sheet = "Gtex_TCGA_species_differ_adjust")

TCGA_species <- df$TCGA_species
TCGA_sample_ratio <- df$TCGA_samplegtcutoff_ratio
Gtex_species <- na.omit(df$Gtex_species)
Gtex_sample_ratio <- df$Gtex_samplegtcutoff_ratio
Significant_species <- significant_species$Species
TCGA_median <- df$TCGA_species_median
Gtex_median <- df$Gtex_species_median

total_adjust_pvalue <- significant_species$`Benjamini and Hochberg , FDR`

TCGA_overlap <- c()
Gtex_overlap <- c()


for (i in TCGA_species){
  if (i %in% TCGA_species){
    TCGA_overlap <- c(TCGA_overlap, i)
  }
}
for (i in Gtex_species){
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
names(Species_adj_pvalue) <- Significant_species

TCGA_amount_list <- df$TCGA_samplegtcutoff_ratio
names(TCGA_amount_list) <- df$TCGA_species


Gtex_amount_list <- c(na.omit(df$Gtex_samplegtcutoff_ratio))
names(Gtex_amount_list) <- c(as.character(na.omit(df$Gtex_species)))


for (i in TCGA_species){
  if (i %in% TCGA_overlap){
    TCGA_overlap_species <- c(TCGA_overlap_species,i)
    TCGA_overlap_species_pvalue <- c(TCGA_overlap_species_pvalue,Species_adj_pvalue[[i]])
    TCGA_pvalue_sample_amount <- c(TCGA_pvalue_sample_amount,TCGA_amount_list[[i]] )
   
  } 
  }
 for (i in Gtex_species){ 
    Gtex_overlap_species <- c(Gtex_overlap_species,i)
    Gtex_overlap_species_pvalue <- c(Gtex_overlap_species_pvalue,Species_adj_pvalue[[i]])
    Gtex_pvalue_sample_amount <- c(Gtex_pvalue_sample_amount,Gtex_amount_list[[i]])
  }

Gtex_median <- as.numeric(na.omit(Gtex_median))

Gtex_df <- data.frame(Gtex_species =Gtex_overlap_species, Gtex_species_pvalue = Gtex_overlap_species_pvalue, Gtex_amount_ratio = Gtex_pvalue_sample_amount, Gtex_species_median = Gtex_median )
TCGA_df <- data.frame(TCGA_species = TCGA_overlap_species, TCGA_species_pvalue = TCGA_overlap_species_pvalue, TCGA_amount_ratio = TCGA_pvalue_sample_amount,TCGA_species_median = TCGA_median)

final_Median_Pvalue_ratio <- cbind(Gtex_df,TCGA_df)



write.table(final_Median_Pvalue_ratio, file= '/Users/kun-linho/Desktop/TCGA_Gtex_TotalSpecies_final_Median_Pvalue_ratio_summary.txt', row.names = F, quote= F, sep = '\t')


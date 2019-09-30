## this script takes each sample of all species reads( species overlap between TCGA and GTex)
# and then do the statistic analysis to find the significant species, and then adjust p_value
# you can also apply the sample ratio cutoff for Gtex or TCGA, if not, then the sample ratio cutoff is 0
# the final output is the significant species with p value and sample ratio 
# and the median of each species

library(dplyr)
library(readxl)
library(Biobase)
library(FSA)

## here we need an input file for the overlap species, but some of them are stastically significant, some of them are not
TCGA_all_species <- read_excel('/Users/kun-linho/Desktop/Colon.xlsx',sheet = 'with_cutofcolon_species_summary') 
Gtex_all_species <- read_excel('/Users/kun-linho/Desktop/Colon.xlsx',sheet = 'with_cut_Gtex_species_summary')
#Overlap_species  <- colnames(TCGA_all_species) 
TCGA_all_species_list <- list()
Gtex_all_species_list <- list()

TCGA_all_species <- as.matrix(TCGA_all_species)
Gtex_all_species <- as.matrix(Gtex_all_species)

Overlap_species  <- colnames(TCGA_all_species) 
#Overlap_species1 <- colnames(Gtex_all_species)
for (i in 1:length(Overlap_species)){
  TCGA_all_species_list[[Overlap_species[i]]] = TCGA_all_species[,i]
  Gtex_all_species_list[[Overlap_species[i]]] = Gtex_all_species[,i]
}

## to get the plot for the species distribution and for each species distribution 
Df  <- paste("distribution", ".", "TCGA_colon_Gtex.pdf", sep="", collapse="");
pdf(file=Df, w=7, h=5)
par( mar=c(2.1,4.1,2.1,1.1) )
layout(m=matrix(1:2, 2, 1))
log2_Gtex_significant_total <- list()
log2_TCGA_significant_total <- list()
Gtex_significant_total <- list()
TCGA_significant_total <- list()
significant_species_name <- c()
non_sig_species_name <- c()
TCGA_sign_value <- c()
Gtex_sign_value <- c()
p_value_species <- c()
species <- c()
for (i in 2:length(Overlap_species)){
  TCGA_species_value <- TCGA_all_species[, i]
  Gtex_species_value <- Gtex_all_species[, i]
  wilcox <- wilcox.test(as.numeric(TCGA_species_value),as.numeric(Gtex_species_value), alt="two.sided",paired = F, correct=T)
  p_value=wilcox$p.value
  if (p_value < 0.05){ # here the p_value is the raw pvalue of wilcox text
    significant_species <- Overlap_species[i] 
    TCGA_sign_value <- TCGA_all_species[, i]
    TCGA_log2_value <- log2(as.numeric(TCGA_all_species[, i]) + 0.000001)
    Gtex_sign_value <- Gtex_all_species[, i]
    Gtex_log2_value <- log2(as.numeric(Gtex_all_species[, i] )+ 0.000001)
    TCGA_significant_total[[significant_species]] <- TCGA_sign_value
    log2_TCGA_significant_total[[paste(significant_species,'log2',sep="_", collapse="")]] <- TCGA_log2_value
    TCGA_gt_0  <- log2_TCGA_significant_total[[paste(significant_species,'log2',sep="_", collapse="")]] >log2(0+0.000001)
    hist_value <- log2_TCGA_significant_total[[paste(significant_species,'log2',sep="_", collapse="")]][TCGA_gt_0]
    hist(as.numeric(hist_value),breaks = 100, xlab = 'Enrichemnt',main = paste("TCGA of" ,paste(significant_species,'log2',sep="_", collapse="")))
    Gtex_significant_total[[significant_species]] <- Gtex_sign_value
    log2_Gtex_significant_total[[paste( significant_species,'log2',sep="_", collapse="")]] <- Gtex_log2_value
    Gtex_gt_0 <- log2_Gtex_significant_total[[paste(significant_species,'log2',sep="_", collapse="")]] >log2(0+0.000001)
    hist_value1 <-log2_Gtex_significant_total[[paste(significant_species,'log2',sep="_", collapse="")]][Gtex_gt_0]
    hist(as.numeric(hist_value1), breaks = 100,xlab = 'Enrichemnt',main = paste("Gtex of" ,paste(significant_species,'log2',sep="_", collapse="")))
    p_value_species <- c(p_value_species, p_value )
    species <- c(species, Overlap_species[i] )
    
  }
}

dev.off()

species_pvalue <- tibble(Species_pvalue=p_value_species, Species= species )



#write.table(species_pvalue, file ="/Users/kun-linho/Desktop/Species_pvalue.txt", row.names=F, sep ="\t",quote = F  )

### Once we have the statistically significant species, we need to adjust the pvalue ####
Data = species_pvalue[order(species_pvalue$Species_pvalue),]
headtail(Data)
adjust_pvalue <- p.adjust(Data$Species_pvalue, method ="hochberg", n = length(Data$Species_pvalue))
Data$Bonferroni = p.adjust(Data$Species_pvalue, method = "bonferroni")
Data$BH = p.adjust(Data$Species_pvalue, method = "BH")
Data$Holm = p.adjust(Data$ Species_pvalue, method = "holm")
Data$Hochberg = p.adjust(Data$ Species_pvalue, method = "hochberg")
Data$Hommel = p.adjust(Data$ Species_pvalue, method = "hommel")
Data$BY = p.adjust(Data$ Species_pvalue, method = "BY")

#write.table(Data, file ="/Users/kun-linho/Desktop/Species_adjust_different_methods.txt", row.names=F, sep ="\t",quote = F  )
data_with_adjust_pvalue <- data.frame(BH_adjust_p= Data$BH, Species=Data$Species, row_P= Data$Species_pvalue )
data_with_adjust_pvalue <- data_with_adjust_pvalue[order(data_with_adjust_pvalue$Species), ]

### data_with_adjust_pvalue contains row p value and adjust p value ####
TCGA_significant_Species_list <- list()
Gtex_significant_Species_list <- list()

for (i in species_pvalue$Species){
  TCGA_significant_Species_list[[i]]= TCGA_all_species_list[[i]]
  Gtex_significant_Species_list[[i]]= Gtex_all_species_list[[i]]
}

TCGA_list_dataframe <-as.data.frame(TCGA_significant_Species_list)
Gtex_list_dataframe <- as.data.frame(Gtex_significant_Species_list)
#data.frame(matrix(unlist(TCGA_significant_Species_list), nrow = max(lengths(TCGA_significant_Species_list)),byrow=T),stringsAsFactors=F)
#Gtex_list_dataframe <- data.frame(matrix(unlist(Gtex_significant_Species_list), nrow = max(lengths(Gtex_significant_Species_list)), byrow=T),stringsAsFactors=F)
#colnames(TCGA_list_dataframe) <- species_pvalue$Species
#colnames(Gtex_list_dataframe) <- species_pvalue$Species

## here we need significant species read as input for each sample ##  
#Gtex_sig_data <- read_excel("/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx", sheet = 'Gtex_species_significant')
#TCGA_sig_data <- read_excel("/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx", sheet = 'TCGA_species_significant')
col_names <-colnames(TCGA_list_dataframe)
Gtex_sig_data <- as.matrix(Gtex_list_dataframe)
TCGA_sig_data <- as.matrix(TCGA_list_dataframe)
#colnames(Gtex_sig_data) <- NULL
#colnames(TCGA_sig_data) <- NULL
Gtex_sample_amount <- length(Gtex_sig_data[,1])
TCGA_sample_amount <- length(TCGA_sig_data[,1])
sample_amout_cuttoff <- 0
Gtex_species_gtcutoff <- c()
TCGA_species_gtcutoff <- c()
Gtex_sample_number <- c()
TCGA_sample_number <- c()
TCGA_each_species_median <- c()
Gtex_each_species_median <- c()
species_name <- c()


# for ( i in 1:length(col_names)){
#   TCGA_median_value <- median(as.numeric(TCGA_sig_data[ ,i]))
#   Gtex_median_value <- median(as.numeric(Gtex_sig_data[ ,i]))
#   TCGA_each_species_median <- c(TCGA_each_species_median, TCGA_median_value)
#   Gtex_each_species_median <- c(Gtex_each_species_median, Gtex_median_value)
#   species_name <- c(species_name,col_names[i] )
# }
# TCGA_List <- TCGA_each_species_median
# names(TCGA_List) <- species_name
# 
# Gtex_List <- Gtex_each_species_median
# names(Gtex_List) <- species_name

### here we want to apply species read not 0 and apply sample ratio cutoff
for (i in 1:length(col_names)){
  Gtex_sample_number_for_eachspecies <- 0
  for (j in 1:Gtex_sample_amount){
    Gtex_species_enrichment <- as.numeric(Gtex_sig_data[j,i])  
    if (Gtex_species_enrichment >0) { # if each sample reads for each species gt 0
      Gtex_sample_number_for_eachspecies <- Gtex_sample_number_for_eachspecies + 1
    }
  }
  if (Gtex_sample_number_for_eachspecies >= Gtex_sample_amount*sample_amout_cuttoff) { ### here we can put the sample ratio cutoff >= how much
    Gtex_species_gtcutoff <- c(Gtex_species_gtcutoff,col_names[i] )
    Gtex_sample_number <- c(Gtex_sample_number,Gtex_sample_number_for_eachspecies/Gtex_sample_amount)
    Gtex_median_value <- median(as.numeric(Gtex_sig_data[ ,i] ))
    Gtex_each_species_median <- c(Gtex_each_species_median, Gtex_median_value)
  }
  
}


for (i in 1:length(col_names)){
  TCGA_sample_number_for_eachspecies <- 0
  for (j in 1:TCGA_sample_amount){
    TCGA_species_enrichment <- as.numeric(TCGA_sig_data[j,i]) 
    if (TCGA_species_enrichment > 0){
      TCGA_sample_number_for_eachspecies <- TCGA_sample_number_for_eachspecies + 1
    }
  }
  if (TCGA_sample_number_for_eachspecies >= TCGA_sample_amount*sample_amout_cuttoff){
    TCGA_species_gtcutoff <- c(TCGA_species_gtcutoff,col_names[i] )
    TCGA_sample_number <- c(TCGA_sample_number ,TCGA_sample_number_for_eachspecies/TCGA_sample_amount)
    TCGA_median_value <- median(as.numeric(TCGA_sig_data[ ,i] ))
    TCGA_each_species_median <- c(TCGA_each_species_median,TCGA_median_value )
    
  }
}

n <- max(length(TCGA_species_gtcutoff),length(Gtex_species_gtcutoff))
new_Gtex_species_gtcutoff = c(Gtex_species_gtcutoff, rep(NA,n - length(Gtex_species_gtcutoff)))
new_TCGA_species_gtcutoff = c(TCGA_species_gtcutoff, rep(NA,n - length(TCGA_species_gtcutoff)))
new_TCGA_sample_number <- c(TCGA_sample_number, rep(NA,n - length(TCGA_sample_number)))
new_Gtex_sample_number <- c(Gtex_sample_number, rep(NA,n - length(Gtex_sample_number)))
new_Gtex_each_species_median = c(Gtex_each_species_median, rep(NA,n - length(Gtex_each_species_median)))
new_TCGA_each_species_median = c(TCGA_each_species_median, rep(NA,n - length(TCGA_each_species_median)))
## need to adjust the order of p values
df <- data.frame(TCGA_species=new_TCGA_species_gtcutoff, TCGA_samplegtcutoff_ratio =new_TCGA_sample_number, TCGA_species_median=new_TCGA_each_species_median,  
                 Gtex_species=new_Gtex_species_gtcutoff, Gtex_samplegtcutoff_ratio=new_Gtex_sample_number,Gtex_species_median=new_Gtex_each_species_median)
TCGA_species <- df$TCGA_species
TCGA_sample_ratio <- df$TCGA_samplegtcutoff_ratio
Gtex_species <- df$Gtex_species
Gtex_sample_ratio <- df$Gtex_samplegtcutoff_ratio
Significant_species <- data_with_adjust_pvalue$Species
adjust_pvalue <- data_with_adjust_pvalue$BH_adjust_p
total_adjust_pvalue <- data_with_adjust_pvalue$BH_adjust_p
TCGA_overlap <- c()
Gtex_overlap <- c()


TCGA_List <- TCGA_sample_ratio
names(TCGA_List) <- TCGA_species

Gtex_List <- Gtex_sample_ratio
names(Gtex_List) <- Gtex_species

for (i in Significant_species){
  if (i %in% TCGA_species){
    TCGA_overlap <- c(TCGA_overlap, i)
  }
}
for (i in Significant_species){
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
for (i in Significant_species){
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
combine <- data.frame(TCGA_Gtexoverlap=TCGA_overlap_species,
                      TCGA_overlap_pvalue=TCGA_overlap_species_pvalue,
                      TCGA_sample_ratio= TCGA_pvalue_sample_amount,
                      TCGA_species_median= df$TCGA_species_median,
                      Gtex_sample_ratio = Gtex_pvalue_sample_amount,
                      Gtex_species_median = df$Gtex_species_median)
combine <- combine[order(-combine$TCGA_sample_ratio),]
write.table(combine,"/Users/kun-linho/Desktop/TCGA_colon_Gtex_significant_species_summary.txt",row.names = F, quote= F, sep = '\t')

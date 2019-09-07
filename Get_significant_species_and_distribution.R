library(dplyr)
library(readxl)
library(Biobase)


# the input file is the overlap species between TCGA and Gtex and the reads for each sample
# the script is try to find the statistically signifiant species use wilcox test 
# and also plot the distribution for each statistically significant species
# once we get the raw p_value, we will adjust the pvalue using the other scripts (Get_significant_spcies_and_distribution)
TCGA_all_species <-  read_excel('/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx',sheet = 'TCGA_species') 
Gtex_all_species <- read_excel('/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx',sheet = 'Gtex_species')

TCGA_all_species <- as.matrix(TCGA_all_species)
Gtex_all_species <- as.matrix(Gtex_all_species)

col_names <-colnames(TCGA_all_species) 
col_names1 <- colnames(Gtex_all_species)

Df  <- paste("distribution", ".", "TCGA_Gtex.pdf", sep="", collapse="");
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
for (i in 2:length(col_names)){
  TCGA_species_value <- TCGA_all_species[, i]
  Gtex_species_value <- Gtex_all_species[, i]
  wilcox <- wilcox.test(as.numeric(TCGA_species_value),as.numeric(Gtex_species_value), alt="two.sided",paired = F, correct=T)
  p_value=wilcox$p.value
  if (p_value < 0.05){ # here the p_value is the raw pvalue of wilcox text
    significant_species <- col_names[i] 
    TCGA_sign_value <- TCGA_all_species[, i]
    TCGA_log2_value <- log2(as.numeric(TCGA_all_species[, i])+0.00001)
    Gtex_sign_value <- Gtex_all_species[, i]
    Gtex_log2_value <- log2(as.numeric(Gtex_all_species[, i] )+0.00001)
    TCGA_significant_total[[significant_species]] <- TCGA_sign_value
    log2_TCGA_significant_total[[paste(significant_species,'log2',sep="_", collapse="")]] <- TCGA_log2_value
    TCGA_gt_0 <- log2_TCGA_significant_total[[paste(significant_species,'log2',sep="_", collapse="")]] >log2(0+0.00001)
    hist_value <-log2_TCGA_significant_total[[paste(significant_species,'log2',sep="_", collapse="")]][TCGA_gt_0]
    hist(as.numeric(hist_value),breaks = 100, xlab = 'Enrichemnt',main = paste("TCGA of" ,paste(significant_species,'log2',sep="_", collapse="")))
    Gtex_significant_total[[significant_species]] <- Gtex_sign_value
    log2_Gtex_significant_total[[paste( significant_species,'log2',sep="_", collapse="")]] <- Gtex_log2_value
    Gtex_gt_0 <- log2_Gtex_significant_total[[paste(significant_species,'log2',sep="_", collapse="")]] >log2(0+0.00001)
    hist_value1 <-log2_Gtex_significant_total[[paste(significant_species,'log2',sep="_", collapse="")]][Gtex_gt_0]
    hist(as.numeric(hist_value1), breaks = 100,xlab = 'Enrichemnt',main = paste("Gtex of" ,paste(significant_species,'log2',sep="_", collapse="")))
    p_value_species <- c(p_value_species, p_value )
    species <- c(species, col_names[i] )
    
  }
  else 
    print(paste(col_names[i],">0.05"))
}

dev.off()

species_pvalue <- data_frame(Species_pvalue=p_value_species, Species= species )
write.table(species_pvalue, file ="/Users/kun-linho/Desktop/Species_pvalue.txt", row.names=F, sep ="\t",quote = F  )

library('FSA')
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
write.table(data_with_adjust_pvalue, file ="/Users/kun-linho/Desktop/Species_hochberg_adjustpvalue.txt", row.names=F, sep ="\t",quote = F  )

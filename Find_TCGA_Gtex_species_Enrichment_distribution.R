# this script take input file of Gtex and TCGA species enrichment (species count /total_read) of each sample 
# to plot the distribution of  all species and tranfrom to log2 or not
# the purpose of this script is try to identify of the thersheld of the species enrichemnt (from the two png file)
# to know what enrichment value to use to identify the what is the cutoff value of the background enrichment (not random)
#library(readxl)


# /Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Enrichment_Diversity/TCGA_blood_CRC_familyEnrichmentDiversity_sum.txt
# /Volumes/Research_Data/Microbiome_analysis/Gtex/Gtex_gt_cutoff/Enrichment/Gtex_blood_familyEnrichmentDiversity_sum.txt

#datatype <-c('TCGA','Gtex')

categories <- c('species','phylum','family')
for (category in categories) {
TCGA_enrichment <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Enrichment_Diversity/TCGA_blood_CRC_",category,"EnrichmentDiversity_sum.txt",sep =""),
                              header = T, sep = '\t',
                              stringsAsFactors = F)
#read_excel("/Users/kun-linho/Desktop/Colon.xlsx",sheet ='Total_Species_distribution')
TCGA_enrichment <- as.matrix(TCGA_enrichment)
Gtex_enrichment <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/Gtex/Gtex_gt_cutoff/Enrichment/Gtex_blood_",category,"EnrichmentDiversity_sum.txt",sep=""),
                              header = T, sep = '\t',
                              stringsAsFactors = F)
Gtex_enrichment <- as.matrix(Gtex_enrichment)
#Gtex_TCGA_enrichment$Gtex_log2
TCGA_blood_enrichment_log2 <- TCGA_enrichment[,5]
TCGA_blood_enrichment <- TCGA_enrichment[,4]
Gtex_blood_enrichment_log2 <- Gtex_enrichment[,5]
Gtex_blood_enrichment <- Gtex_enrichment[,4]

#a <- c(min(TCGA_blood_enrichment_log2),a)

png(paste("enrichment_Gtex_total_",category,".png",sep=""),width=6000,height=4000,res=600)
hist(as.numeric(Gtex_blood_enrichment), breaks = 1000, xlab = "Gtex_blood_enrichment(FPM)", main = paste("Total",category,"_Gtex_blood_enrichment(FPM)",sep = ""))
dev.off()
png(paste("log2_enrichment_Gtex_total_",category,".png",sep=""),width=6000,height=4000,res=600)
hist(as.numeric(Gtex_blood_enrichment_log2), breaks = 1000, xlim= c(-5,18),xlab = "Gtex_blood_enrichment(FPM)", main = paste("log2_Total",category,"_Gtex_blood_enrichment(FPM)",sep = ""))
abline(v=3.17, col="purple")
dev.off()
png(paste("log2_enrichment_TCGA_CRC_blood_",category,"_enrichment.png",sep=""),width=6000,height=4000,res=600)
hist(as.numeric(TCGA_blood_enrichment_log2), breaks = 1000, xlim= c(-5,18),xlab = "TCGA_CRC_blood_enrichment(FPM)", main = paste("log2_Total",category,"_TCGA_CRC_blood_enrichment(FPM)",sep = ""))
abline(v=10, col="purple")
dev.off()
png(paste("enrichment_TCGA_CRC_blood_",category,"_enrichment.png",sep=""),width=6000,height=4000,res=600)
hist(as.numeric(TCGA_blood_enrichment), breaks = 10000, xlab = "TCGA_CRC_blood_enrichment(FPM)", main = paste("Total",category,"_TCGA_CRC_blood_enrichment(FPM)",sep = ""))
dev.off()
    }



## the following function are unclear and i forgot

# log2_TCGA <- read_excel('/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx',sheet = 'log2TCGA_significant_species')
# log2_Gtex <- read_excel('/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx',sheet = 'log2Gtex_significant_species')
# TCGA_value <- read_excel('/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx',sheet = 'TCGA_species_significant')
# Gtex_value <- read_excel('/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx',sheet = 'Gtex_species_significant')
# all_log2_value <- rbind(log2_TCGA,log2_Gtex)
# colnames(all_log2_value) <- NULL
# colnames(Gtex_value) <- NULL
# colnames(TCGA_value) <- NULL
# colnames(log2_TCGA) <- NULL
# colnames(log2_Gtex) <- NULL
# all_log2_value <- as.matrix(all_log2_value)
# Gtex_value <- as.matrix(Gtex_value)
# TCGA_value <- as.matrix(TCGA_value)
# log2_TCGA <- as.matrix(log2_TCGA)
# log2_Gtex <- as.matrix(log2_Gtex)
# TCGA_value_gt0 <- TCGA_value[TCGA_value>0]
# Gtex_value_gt0 <- Gtex_value[Gtex_value>0]
# log2_TCGA_gt0 <- log2_TCGA[log2_TCGA >log2(0+0.00001)]
# log2_Gtex_gt0 <- log2_Gtex[log2_Gtex >log2(0+0.00001)]
# hist(as.numeric(all_log2_value),breaks = 10000, xlab = 'Enrichemnt',main = " Include 0 Total_species_Gtex_TCGA", ylim = c(0,40), xlim = c(-16,6))
# dev.off()
# 
# Df  <- 'TCGA_Gtex_total_species.pdf'
# pdf(file=Df, w=7, h=5)
# par( mar=c(2.1,4.1,2.1,1.1) )
# layout(m=matrix(1:2,2,1))
# hist(as.numeric(log2_TCGA),breaks = 100000, xlab = 'Enrichemnt',main = " Include 0 Total_species_TCGA_log2", ylim = c(0,40), xlim = c(-18,6))
# hist(as.numeric(log2_Gtex),breaks = 100000, xlab = 'Enrichemnt',main = " Include 0 Total_species_Gtex_log2", ylim = c(0,40), xlim = c(-18,6))
# hist(as.numeric(TCGA_value),breaks = 1000000, xlab = 'Enrichemnt',main = " Include 0 Total_species_TCGA", ylim = c(0,40), xlim = c(0,2))
# hist(as.numeric(Gtex_value),breaks = 1000000, xlab = 'Enrichemnt',main = " Include 0 Total_species_Gtex", ylim = c(0,100), xlim = c(0,2))
# 
# dev.off()
# 
# Df  <- 'Exclude 0 TCGA_Gtex_total_species.pdf'
# pdf(file=Df, w=7, h=5)
# par( mar=c(2.1,4.1,2.1,1.1) )
# layout(m=matrix(1:2, 2, 1))
# hist(as.numeric(TCGA_value_gt0),breaks = 15000, xlab = 'Enrichemnt',main = "Exclude 0 Total_species_TCGA", ylim = c(0,40), xlim = c(0,5))
# hist(as.numeric(Gtex_value_gt0),breaks = 10000, xlab = 'Enrichemnt',main = "Exclude 0 Total_species_Gtex", ylim = c(0,40), xlim = c(0,5))
# hist(as.numeric(log2_TCGA_gt0),breaks = 15000, xlab = 'Enrichemnt',main = " Exclude 0 log2_Total_species_TCGA", ylim = c(0,40), xlim = c(-10,6))
# hist(as.numeric(log2_Gtex_gt0),breaks = 15000, xlab = 'Enrichemnt',main = " Exclude 0 log2_Total_species_Gtex", ylim = c(0,40), xlim = c(-10,6))
# 
# dev.off()
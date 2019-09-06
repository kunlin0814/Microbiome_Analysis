# this script take input file of Gtex and TCGA species enrichment (species count /total_read) of each sample 
# to plot the distribution of  all species and tranfrom to log2 or not
# the purpose of this script is try to identify of the thersheld of the species enrichemnt (from the two png file)
# to know what enrichment value to use to identify the what is the cutoff value of the background enrichment (not random)


Gtex_TCGA_enrichment <- read_excel("/Users/kun-linho/Desktop/08_06microbiome_Study.xlsx",sheet ='Histogram_Gtex_TCGA_blood')
Gtex_totl_sepc_enrichment <- Gtex_TCGA_enrichment$Gtex_log2
TCGA_blood_spec_enrichment <- Gtex_TCGA_enrichment$TCGA_blood_log2
png("enrichment_Gtex_total_species.png",width=6000,height=4000,res=600)
hist(as.numeric(Gtex_totl_sepc_enrichment), breaks = 1000, xlab = 'all_species_enrichment(FPM)', main = 'log2_Gtex_all_species_enrichment(FPM)')
dev.off()
png("enrichment_TCGA_blood_spec_enrichment.png",width=6000,height=4000,res=600)
hist(as.numeric(TCGA_blood_spec_enrichment), breaks = 1000, xlab = 'all_species_enrichment(FPM)', main = 'log2_TCGA_blood_all_species_enrichment(FPM)')
dev.off()




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
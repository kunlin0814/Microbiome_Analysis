library(MASS)
library(stats)
library(Biobase)
library(gplots)
dat1<-read.table("/Users/kun-linho/Desktop/heatmaptest.txt",sep="\t",header=T, stringsAsFactors = F)
d<-dat1[,-c(1,4,5,6,7)]
rownames(d) <- dat1[, 1]

candidate <- read.table("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_species_family_phylum_data/CRC_candidate_Species.txt",
                        stringsAsFactors = F)
candidate_species <- sort(c(candidate$V1))

final <- NULL
for (i in candidate_species){
total_file_name <- NULL

Gtex <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/Gtex_blood/total_gtex_",i,".txt",sep=""),
                   sep = '\t',
                   skip  = 1,
                   header = T)
                   

TCGA_blood <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/Blood_result/total_TCGA_blood_",i,".txt",sep=""),
                   sep = '\t',
                   skip  = 1,
                   header = T
                  )

TCGA_tumor <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/TCGA_tumor/total_TCGA_tumor_",i,".txt",sep=""),
                         sep = '\t',
                         skip  = 1,
                         header = T
                        )

TCGA_adj <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/adj_result/total_TCGA_adj_",i,".txt",sep=""),
                         sep = '\t',
                         skip  = 1,
                           header = T)
                         
each_species <- rbind(TCGA_blood,TCGA_tumor,Gtex)
each_species_file <- each_species$X.1
each_species_value <- each_species$X
final <- cbind(each_species_value,final)

}
colnames(final) <- c(candidate_species)

final <- as.data.frame(final)
row.names(final) <- each_species_file
final <- as.matrix(final)

png("Group-testing.png",width=6000,height=8000,res=150)
#par(mar=c(0.1,0.1,0.1,10))
#par(mac=c(5, 2, 2, 10))

par(oma=c(30,5,0.001,30))
heatmap.2(final,col=colorRampPalette(c("green","white","red"))(10),
               scale="row", key=TRUE, keysize=0.2,
              density.info="none", trace="none", dendrogram="none",Colv= F,Rowv=F,
              cexRow=4,cexCol=4,srtCol=45,
              symm=F,symkey=T,symbreaks=T)
dev.off()


margins=c(5,10), lwid=c(0.3,0.8),
cexRow=0.8, cexCol=0.1,
,Colv= F,Rowv=F,
a <- scale(d)
b <- mtcars
df <- scale(mtcars)
heatmap.2(a, scale = "none", col=colorRampPalette(c("navy","white","red"))(100), 
          trace = "none", density.info = "none",dendrogram="none")
dev.off()

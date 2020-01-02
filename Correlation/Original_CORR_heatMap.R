library(MASS)
library(stats)
library(Biobase)
library(gplots)
# dat1<-read.table("/Users/kun-linho/Desktop/heatmaptest.txt",sep="\t",header=T, stringsAsFactors = F)
# d<-dat1[,-c(1,4,5,6,7)]
# rownames(d) <- dat1[, 1]

candidate <- read.table("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_spceis/CRC_candidate_speceis.txt",
                        stringsAsFactors = F)
candidate_species <- sort(c(candidate$V1))
#total_length <- NULL
final <- NULL
for (i in candidate_species){
total_file_name <- NULL

Gtex <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/Gtex_blood/total_gtex_",i,".txt",sep=""),
                   sep = '\t',
                   skip  = 1,
                   header = T,
                   stringsAsFactors = F)
                   

TCGA_blood <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/Blood_result/total_TCGA_blood_",i,".txt",sep=""),
                   sep = '\t',
                   skip  = 1,
                   header = T,
                   stringsAsFactors = F
                  )

TCGA_tumor <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/TCGA_tumor/total_TCGA_tumor_",i,".txt",sep=""),
                         sep = '\t',
                         skip  = 1,
                         header = T,
                         stringsAsFactors = F
                        )

#TCGA_adj <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/adj_result/total_TCGA_adj_",i,".txt",sep=""),
#                         sep = '\t',
#                         skip  = 1,
#                           header = T,
#                       stringsAsFactors = F
#                         )
each_species <- rbind(TCGA_blood,TCGA_tumor,Gtex)

each_species_file <- each_species$X.1
each_species_value <- each_species$X
final <- cbind(final,each_species_value)
#total_length <- c(total_length, length(TCGA_tumor$X.1))
}
colnames(final) <- c(candidate_species)
row.names(final) <- c(each_species_file)
final <- as.data.frame(final)
#final$file_name<- each_species_file
#new_final <- final[order(final$Aspergillus_fumigatus),]
new_final <- as.matrix(final)


png("CRC_Microbiome.png",width=8000,height=8000,res=100)
par(oma=c(55,7,0,40))



heatmap.2(new_final,col=colorRampPalette(c("green","white","red"))(10),
               scale='column', key=TRUE, keysize=0.3,key.title = "",
              density.info="none", trace="none", dendrogram="none",Colv= F,Rowv=F,
              cexRow=4,cexCol=8,srtCol=45,
          tracecol=NA,
          lhei=c(0.2,4),
              symm=F,symkey=T,symbreaks=T )
dev.off()

#  heatmap.2(fpkm3, col=my_palette,Colv = F,Rowv = T, dendrogram = "none",key.title = '',
#            ColSideColors = type_Color, 
#            tracecol=NA,scale="row",labCol = FALSE,lhei=c(3,10))
#  dev.off()
# margins=c(5,10), lwid=c(0.3,0.8),
# cexRow=0.8, cexCol=0.1,
# ,Colv= F,Rowv=F,
# a <- scale(d)
# b <- mtcars
# df <- scale(mtcars)
# heatmap.2(a, scale = "none", col=colorRampPalette(c("navy","white","red"))(100), 
#           trace = "none", density.info = "none",dendrogram="none")
# dev.off()

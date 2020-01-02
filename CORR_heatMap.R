library(MASS)
library(stats)
library(Biobase)
library(gplots)

## this script needs to use files containing the microbe read counts in each sample (TCGA_blood, TCGA_tumor Gtex)  
## ex: TCGA_Blood_candidate_Family_Aspergillaceae.txt, which contains the file name and this species read counts in each TCGA_blood samples
## TCGA_Blood_candidate_Family_Aspergillaceae.txt will derived from the python script "micro_species_enrich_find_specific.py or *find_family.py"

## this script also needs to use the candidate microbes( Phylum, Family, Species) files as another argument (candidate variable)
## the output file in this script is the heatmap plot show the enrichment among all of the candidate microbes

Categories <- c("Species","Family","Phylum")
for (Category in Categories){
candidate <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_species_family_phylum_data/CRC_candidate_",Category,".txt",sep=""),
                        stringsAsFactors = F)
candidate_species <- sort(c(candidate$V1))
#total_length <- NULL
final <- NULL
for (i in candidate_species){
  total_file_name <- NULL
  #total_candidate_Species_Gtex_Delftia_acidovorans
  Gtex <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/Gtex_blood/",Category,"/total_candidate_",Category,"_Gtex_",i,".txt",sep=""),
                     sep = '\t',
                     header = T)
  
  
  TCGA_blood <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_microbe/",Category,"/ENRICH/Blood/TCGA_Blood_candidate_",Category,"_",i,".txt",sep=""),
                           sep = '\t',
                           header = T)
  
  TCGA_tumor <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_microbe/",Category,"/ENRICH/Tumor/TCGA_Tumor_candidate_",Category,"_",i,".txt",sep=""),
                            sep = '\t',
                            header = T)
  
  #TCGA_adj <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/adj_result/total_TCGA_adj_",i,".txt",sep=""),
  #                         sep = '\t',
  #                         skip  = 1,
  #                           header = T,
  #                       stringsAsFactors = F
  #                         )
  each_species <- rbind(TCGA_tumor,TCGA_blood,Gtex)
  each_species_file <- each_species[,1]
  each_species_value <- each_species[,2]
  final <- cbind(final,each_species_value)
  #total_length <- c(total_length, length(TCGA_tumor$X.1))
}
colnames(final) <- c(candidate_species)

final <- as.data.frame(final)
row.names(final) <- each_species_file
final <- as.matrix(final)

#final$file_name<- each_species_file
#new_final <- final[order(final$Aspergillus_fumigatus),]
#final <- as.matrix(final)


png(paste("CRC_Microbiome",Category,".png",sep=""),width=8000,height=9000,res=100)  
par(oma=c(65,7,0,40))



heatmap.2(final,col=colorRampPalette(c("green","white","red"))(10),
          scale='column', key=TRUE, keysize=0.3,key.title = "",
          density.info="none", trace="none", dendrogram="none",Colv= F,Rowv=F,
          cexRow=4,cexCol=8,srtCol=60,
          tracecol=NA,
          lhei=c(0.2,4),
          symm=F,symkey=T,symbreaks=T )
dev.off()
}
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

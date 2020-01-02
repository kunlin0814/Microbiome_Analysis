library(MASS)
library(stats)
library(Biobase)
library(gplots)
#dat1<-read.table("/Users/kun-linho/Desktop/heatmaptest.txt",sep="\t",header=T, stringsAsFactors = F)
#d<-dat1[,-c(1,4,5,6,7)]
#rownames(d) <- dat1[, 1]
Categories <- c("Species","Family","Phylum")
for (Category in Categories){
candidate <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_species_family_phylum_data/CRC_candidate_",
              Category,".txt",sep =""),
              stringsAsFactors = F)
  
  candidate_species <- sort(c(candidate$V1))
  png(paste("Enrichment_CRC_",Category,".png",sep=""),width=8000,height=9000,res=100)
  final <- NULL
  
  for (i in candidate_species){
    
   # total_file_name <- NULL
#total_candidate_Species_Gtex_Aspergillus_fumigatus.txt
Gtex <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/Gtex_blood/",Category,"/total_candidate_",Category,"_Gtex_",i,".txt",sep=""),
                       sep = '\t',
                       header = T)
    
#print(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CRC_Gtex_cutoff_candidate_species_enrichment/Gtex_blood/",Category,"/total_candidate_",Category,"_Gtex_",i,".txt",sep=""))
    
TCGA_blood <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_microbe/",Category,
              "/ENRICH/Blood/TCGA_Blood_candidate_",Category,"_",i,".txt",sep=""),
              sep = '\t',
              header = T)
    
TCGA_tumor <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_microbe/",Category,
                                   "/ENRICH/Tumor/TCGA_Tumor_candidate_",Category,"_",i,".txt",sep=""),
                             sep = '\t',
                             header = T)
    
    # TCGA_adj <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_microbe/",Category,
    #                              "/ENRICH/Adj/TCGA_Adj_candidate_",Category,"_",i,".txt",sep=""),
    #                        sep = '\t',
    #                        header = T)
    
    each_species <- rbind(TCGA_tumor,TCGA_blood,Gtex)
    each_species_file <- each_species[,1]
    each_species_value <- each_species[,2]
    final <- cbind(each_species_value,final)
  }
  colnames(final) <- c(candidate_species)
  
  final <- as.data.frame(final)
  row.names(final) <- each_species_file
  final <- as.matrix(final)
  
  
  #par(mar=c(0.1,0.1,0.1,10))
  #par(mac=c(5, 2, 2, 10))
  par(oma=c(65,7,0,40))
  heatmap.2(final,col=colorRampPalette(c("green","white","red"))(10),
            scale="column", key=TRUE, keysize=0.2,key.title = "",
            density.info="none", trace="none", dendrogram="none",Colv= F,Rowv=F,
            cexRow=4,cexCol=8,srtCol=60,
            lhei=c(0.2,4),tracecol=NA,
            symm=F,symkey=T,symbreaks=T)
  dev.off()
  
}


# margins=c(5,10), lwid=c(0.3,0.8),
# cexRow=0.8, cexCol=0.1,
# ,Colv= F,Rowv=F,
# a <- scale(d)
# b <- mtcars
# df <- scale(mtcars)
# heatmap.2(a, scale = "none", col=colorRampPalette(c("navy","white","red"))(100), 
#           trace = "none", density.info = "none",dendrogram="none")
# dev.off()

library(minerva)
library(ggplot2)
library("plyr")  

median <- read.table("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/TCGA_CRC_Gtex_significant_species_summary.txt",
                     header =T,
                     sep = '\t',
                     stringsAsFactors = F)
median$median_diff=median$TCGA_species_median-median$Gtex_species_median

Corr <- read.table("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CORR/CORR_blood_species.result",
                   header =T,
                   sep ='\t',
                   stringsAsFactors = F)

# convert NA to 0
Corr[is.na(Corr)] <- 0
corr_colnames <- colnames(Corr) 
Corr <- as.matrix(Corr)

#colnames(Corr) <- NULL
median_colnames <- colnames(median)
median <- as.matrix(median)



col_name <- c(median_colnames,corr_colnames)

median_final_result <- NULL # can directly assign null value for any data strcutre and then assign value
Corr_final_result <- NULL
for (i in 1:nrow(median)) {
  if (as.numeric(median[i,4]) - as.numeric(median[i,6]) > 0) {
    spe <- median[i,1]}
    for (j in 1:nrow(Corr)){
      if ((grepl(spe,Corr[j,1])) && (as.numeric(Corr[j,3]) > 0.3) && grepl(spe,median[i,1])){
        Corr_final_result <- rbind(Corr_final_result , as.vector(Corr[j,]))
        median_final_result <- rbind(median_final_result,as.vector(median[i,]))}
      } # use as.vector to avoid column names
  
}
Corr_final_result <- unique(Corr_final_result)
median_final_result <- unique(median_final_result)
final_result <- cbind(median_final_result,Corr_final_result)
colnames(final_result) <- col_name
final_result <- as.data.frame(final_result)


#args    <- commandArgs(trailingOnly=TRUE)
# if (length(args)==0) {
#   stop("At least one argument must be supplied (input file).n", call.=FALSE)
#input_file <- args[1]

input_file <- as.vector(final_result$TCGA_Gtexoverlap)
  #'Aspergillus_fumigatus.blood'
  #args[1]
#output_file <- args[2]
for (i in 1:length(input_file)){
Species <-input_file[i]
data <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_spceis/",Species,".blood", sep=""),
                   sep ='\t',
                   header = T,
                   stringsAsFactors = F)




#print(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_spceis/",Species,".blood",sep = ""))
x <-  data$X01
y <-  data$X10
max_value <- which(x%in% max(x))

#x <- x[-c(max_value)]
#y <- y[-c(max_value)]

S<-cor(x,y, method="spearman")
Sp<-cor.test(x,y,method="spearman")$p.value
P<-cor(x,y, method="pearson")
Pp<-cor.test(x,y,method="pearson")$p.value
#/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_spceis/Aspergillus_fumigatus.blood
#/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/
#data$CaseID <- as.factor(data$CaseID)
#data$X10 <- as.factor(data$X10)
png(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_spceis/",Species,".png",sep = ""),width=3000,height=2400,res=300)
p <- ggplot(data, aes(x= x, y=y)) + 
  ggtitle(Species)+
  geom_point(size=2)+
  xlab("Tumor samples") +
  ylab("Blood_Samples") +
  annotate(geom="text", x=max(x)*0.3, y=max(y), label=paste("Spearman",S,sep = " = "), color="blue")+
  annotate(geom="text", x=max(x)*0.3, y=max(y)-(max(y)/3)*0.25, label=paste("S-pvalue",Sp,sep = " = "), color="red")+
  annotate(geom="text", x=max(x)*0.3, y=max(y)-(max(y)/3)*(0.25*2), label=paste("Pearson",P,sep = " = "), color="blue")+
annotate(geom="text", x=max(x)*0.3, y=max(y)-(max(y)/3)*(0.25*3), label=paste("P-pvalue",Pp,sep = " = "), color="red")+
  theme(axis.text=element_text(size=14),
    axis.title=element_text(size=14,face="bold"),
    plot.title = element_text(color = "black", size = 20, face = "bold"))
plot(p)
dev.off()
}



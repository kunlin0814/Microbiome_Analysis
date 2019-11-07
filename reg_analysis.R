library(minerva)
library(ggplot2)
args    <- commandArgs(trailingOnly=TRUE)
# if (length(args)==0) {
#   stop("At least one argument must be supplied (input file).n", call.=FALSE)
input_file <- args[1]
  #'Aspergillus_fumigatus.blood'
  #args[1]
#output_file <- args[2]
data <- read.table(input_file,
                   sep ='\t',
                   header = T,
                   stringsAsFactors = F)

file_name <- input_file
Species <- unlist(strsplit(file_name,split='/'))[8]
x <-  data$X01
y <-  data$X10
S<-cor(x,y, method="spearman")
Sp<-cor.test(x,y,method="spearman")$p.value
P<-cor(x,y, method="pearson")
Pp<-cor.test(x,y,method="pearson")$p.value
          
#data$CaseID <- as.factor(data$CaseID)
#data$X10 <- as.factor(data$X10)
png(paste("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/",Species,".png",sep = ""),width=3000,height=2400,res=300)
ggplot(data, aes(x=X01, y=X10)) + 
  ggtitle(Species)+
  geom_point(size=2)+
  xlab("Tumor samples") +
  ylab("Blood_Samples") +
  annotate(geom="text", x=0.25*max(x), y=max(y), label=paste("Spearman",S,sep = " = "), color="blue")+
  annotate(geom="text", x=0.25*max(x), y=max(y)-(0.3*max(y)*0.3), label=paste("S-pvalue",Sp,sep = " = "), color="red")+
  annotate(geom="text", x=0.25*max(x), y=max(y)-(0.3*max(y)*0.6), label=paste("Pearson",P,sep = " = "), color="blue")+
  annotate(geom="text", x=0.25*max(x), y=max(y)-(0.3*max(y)*0.9), label=paste("P-pvalue",Pp,sep = " = "), color="red")+
  theme(axis.text=element_text(size=14),
    axis.title=element_text(size=14,face="bold"),
    plot.title = element_text(color = "black", size = 20, face = "bold"))
dev.off()

#-(0.3*max(y)0.6)
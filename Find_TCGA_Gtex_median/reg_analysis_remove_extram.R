data <- read.table("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_spceis/Delftia_acidovorans.blood",
                   sep ='\t',
                   header = T,
                   stringsAsFactors = F)
x <-  data$X01
y <-  data$X10
max_value <- which(x%in% max(x))
S<-cor(x,y, method="spearman")
Sp<-cor.test(x,y,method="spearman")$p.value
P<-cor(x,y, method="pearson")
Pp<-cor.test(x,y,method="pearson")$p.value
#/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_spceis/Aspergillus_fumigatus.blood
#/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/
#data$CaseID <- as.factor(data$CaseID)
#data$X10 <- as.factor(data$X10)
png(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_spceis/","Delftia_acidovorans.blood_new",".png",sep = ""),width=3000,height=2400,res=300)
p <- ggplot(data, aes(x= x, y=y)) + 
  ggtitle("Delftia_acidovorans")+
  geom_point(size=2)+
  xlab("Tumor samples") +
  ylab("Blood_Samples") +
  xlim(0,50)+
  annotate(geom="text", x=50*0.3, y=max(y), label=paste("Spearman",S,sep = " = "), color="blue")+
  annotate(geom="text", x=50*0.3, y=max(y)-(max(y)/3)*0.25, label=paste("S-pvalue",Sp,sep = " = "), color="red")+
  annotate(geom="text", x=50*0.3, y=max(y)-(max(y)/3)*(0.25*2), label=paste("Pearson",P,sep = " = "), color="blue")+
  annotate(geom="text", x=50*0.3, y=max(y)-(max(y)/3)*(0.25*3), label=paste("P-pvalue",Pp,sep = " = "), color="red")+
  theme(axis.text=element_text(size=14),
        axis.title=element_text(size=14,face="bold"),
        plot.title = element_text(color = "black", size = 20, face = "bold"))
plot(p)
dev.off()

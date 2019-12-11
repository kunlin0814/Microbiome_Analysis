library(minerva)
library(ggplot2)

## we need to identify the input file location, where we put correlation file
## ex: Aspergillus_fumigatus.blood (the file gives you the count of the microbe reads in tumor and blood samples)

draw_correlation_plot <- function(category,candidate, x_range,y_range){
data <- read.table(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_microbe/",category,"/CORR/",candidate,".blood",sep=""),
                   sep ='\t',
                   header = T,
                   stringsAsFactors = F)

x <-  data$X01
y <-  data$X10
S<-cor(x,y, method="spearman")
Sp<-cor.test(x,y,method="spearman")$p.value
P<-cor(x,y, method="pearson")
Pp<-cor.test(x,y,method="pearson")$p.value

#data$CaseID <- as.factor(data$CaseID)
#data$X10 <- as.factor(data$X10)
plot_result <- png(paste("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Candidate_microbe/CORR_plot/Close_",category,"_",candidate,".png",sep = ""),width=3000,height=2400,res=300)
plot_figure <- ggplot(data, aes(x=X01, y=X10)) + 
  geom_point(size=2)+
  xlab("Tumor samples") +
  ylab("Blood_Samples") +
  xlim(x_range)+
  ylim(y_range)+
  ggtitle(paste("Correlation_of",category,candidate,sep="_"))+
  annotate(geom="text", x=0.20*max(x_range), y=max(y_range), label=paste("Spearman",S,sep = " = "), color="blue")+
  annotate(geom="text", x=0.20*max(x_range), y=max(y_range)-(0.3*max(y_range)*0.3), label=paste("S-pvalue",Sp,sep = " = "), color="red")+
  annotate(geom="text", x=0.20*max(x_range), y=max(y_range)-(0.3*max(y_range)*0.6), label=paste("Pearson",P,sep = " = "), color="blue")+
  annotate(geom="text", x=0.20*max(x_range), y=max(y_range)-(0.3*max(y_range)*0.9), label=paste("P-pvalue",Pp,sep = " = "), color="red")+
  theme(axis.text=element_text(size=14),
        axis.title=element_text(size=14,face="bold"),
        plot.title = element_text(color = "black", size = 20, face = "bold"))

plot(plot_figure)
dev.off()
return(plot_result)
}

draw_correlation_plot("Phylum","Bacteroidetes",c(0,100000),c(0,3000))
#-(0.3*max(y)0.6)


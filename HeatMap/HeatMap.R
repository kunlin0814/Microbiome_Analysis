library(MASS)
library(stats)
library(Biobase)
library(gplots)
dat1<-read.table("/Users/kun-linho/Desktop/Group-testing",sep="\t",header=T)
d<-dat1[,-1]
rownames(d) <- dat1[, 1]
png("Group-testing.png",width=6000,height=6000,res=600)
hm<-heatmap.2(as.matrix(t(d)),col=colorRampPalette(c("navy","white","red"))(100), 
              margins=c(5,10), lwid=c(0.3,0.8),scale="column", key=TRUE, keysize=0.5, 
              density.info="none", trace="none", dendrogram="none",Colv= FALSE,Rowv=FALSE,
              cexRow=0.8, cexCol=0.1,symm=F,symkey=T,symbreaks=T)
dev.off()

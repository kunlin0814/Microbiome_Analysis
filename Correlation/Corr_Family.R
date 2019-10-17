library(minerva)

conn <- file("/scratch/kh31516/TCGA/colon/results/CORR/Family/blood",open="r")
linn <-readLines(conn)
result<-cbind("Family", "MIC", "spearman","pVspearman","pearson","pVpearson","Case")
write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/colon/results/CORR/CORR_blood_Family.result")
for (i in 1:length(linn)){
	Family=unlist(strsplit(linn[i], "[.]"))[1]
	dat <- read.table(paste("/scratch/kh31516/TCGA/colon/results/CORR/",linn[i],sep=""), header=T)
	x <- dat[,2]
	y <- dat[,3]
	M<-mine(x, y)$MIC
	S<-cor(x,y, method="spearman")
	Sp<-cor.test(x,y,method="spearman")$p.value
	P<-cor(x,y, method="pearson")
	Pp<-cor.test(x,y,method="pearson")$p.value
	count<-max(colSums( dat[,c(2,3)]!= 0))
	result<-cbind(Family,M,S,Sp,P,Pp,count)
	write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/colon/results/CORR/CORR_blood_Family.result")
}

close(conn)


conn <- file("/scratch/kh31516/TCGA/colon/results/CORR/Family/adjacent",open="r")
linn <-readLines(conn)
result<-cbind("Family", "MIC", "spearman","pVspearman","pearson","pVpearson","Case")
write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/colon/results/CORR/CORR_adjacent_Family.result")
for (i in 1:length(linn)){
	Family=unlist(strsplit(linn[i], "[.]"))[1]
	dat <- read.table(paste("/scratch/kh31516/TCGA/colon/results/CORR/",linn[i],sep=""), header=T)
	x <- dat[,2]
	y <- dat[,3]
	M<-mine(x, y)$MIC
	S<-cor(x,y, method="spearman")
	Sp<-cor.test(x,y,method="spearman")$p.value
	P<-cor(x,y, method="pearson")
	Pp<-cor.test(x,y,method="pearson")$p.value
	count<-max(colSums( dat[,c(2,3)]!= 0))
	result<-cbind(Family,M,S,Sp,P,Pp,count)
	write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/colon/results/CORR/CORR_adjacent_Family.result")
}

close(conn)


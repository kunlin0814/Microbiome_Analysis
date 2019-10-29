library(minerva)

## Phylum Corr in TCGA Blood vs Tumor ##
conn_blood_phylum <- file("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/Phylum/blood",open="r")
linn <-readLines(conn_blood_phylum)
result<-cbind("Phylum", "MIC", "spearman","pVspearman","pearson","pVpearson","Case")
write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_blood_phylum.result")
for (i in 1:length(linn)){
	Phylum=unlist(strsplit(linn[i], "[.]"))[1]
	dat <- read.table(paste("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/",linn[i],sep=""), header=T)
	x <- dat[,2]
	y <- dat[,3]
	M<-mine(x, y)$MIC
	S<-cor(x,y, method="spearman")
	Sp<-cor.test(x,y,method="spearman")$p.value
	P<-cor(x,y, method="pearson")
	Pp<-cor.test(x,y,method="pearson")$p.value
	count<-max(colSums( dat[,c(2,3)]!= 0))
	result<-cbind(Phylum,M,S,Sp,P,Pp,count)
	write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_blood_phylum.result")
}



## Phylum Corr in TCGA adjacent vs Tumor ##
conn_adj_phylum <- file("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/Phylum/adjacent",open="r")
linn <-readLines(conn_adj_phylum)
result<-cbind("Phylum", "MIC", "spearman","pVspearman","pearson","pVpearson","Case")
write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_adjacent_Phylum.result")
for (i in 1:length(linn)){
	Phylum=unlist(strsplit(linn[i], "[.]"))[1]
	dat <- read.table(paste("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/",linn[i],sep=""), header=T)
	x <- dat[,2]
	y <- dat[,3]
	M<-mine(x, y)$MIC
	S<-cor(x,y, method="spearman")
	Sp<-cor.test(x,y,method="spearman")$p.value
	P<-cor(x,y, method="pearson")
	Pp<-cor.test(x,y,method="pearson")$p.value
	count<-max(colSums( dat[,c(2,3)]!= 0))
	result<-cbind(Phylum,M,S,Sp,P,Pp,count)
	write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_adjacent_Phylum.result")
}




## Family Corr in TCGA Blood vs Tumor ##

conn_family_blood <- file("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/Family/blood",open="r") ## file names of all samples 
linn <-readLines(conn_family_blood)
result<-cbind("Family", "MIC", "spearman","pVspearman","pearson","pVpearson","Case") # header

## output file name and location
write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_blood_Family.result")
for (i in 1:length(linn)){ ## read each file
  Family=unlist(strsplit(linn[i], "[.]"))[1]
  dat <- read.table(paste("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/",linn[i],sep=""), header=T)
  x <- dat[,2]
  y <- dat[,3]
  M<-mine(x, y)$MIC  ## here is we do the Maximal information coefficient 
  S<-cor(x,y, method="spearman") ## here is we do the spearman correlation
  Sp<-cor.test(x,y,method="spearman")$p.value
  P<-cor(x,y, method="pearson") ## here is we do the pearson correlation
  Pp<-cor.test(x,y,method="pearson")$p.value
  count<-max(colSums( dat[,c(2,3)]!= 0)) ## the number of the cases for this Family
  result<-cbind(Family,M,S,Sp,P,Pp,count)
  write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_blood_Family.result")
}

close(conn_family_blood)

## Family Corr in TCGA Adjacent vs Tumor ##

conn_family_adj <- file("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/Family/adjacent",open="r")
linn <-readLines(conn_family_adj)
result<-cbind("Family", "MIC", "spearman","pVspearman","pearson","pVpearson","Case")
write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_adjacent_Family.result")
for (i in 1:length(linn)){
	Family=unlist(strsplit(linn[i], "[.]"))[1]
	dat <- read.table(paste("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/",linn[i],sep=""), header=T)
	x <- dat[,2]
	y <- dat[,3]
	M<-mine(x, y)$MIC
	S<-cor(x,y, method="spearman")
	Sp<-cor.test(x,y,method="spearman")$p.value
	P<-cor(x,y, method="pearson")
	Pp<-cor.test(x,y,method="pearson")$p.value
	count<-max(colSums( dat[,c(2,3)]!= 0))
	result<-cbind(Family,M,S,Sp,P,Pp,count)
	write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_adjacent_Family.result")
}



## Species Corr in TCGA Blood vs Tumor ##
conn_speceis_blood <- file("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/Species/blood",open="r") ## file names of all samples 
linn <-readLines(conn_speceis_blood)
result<-cbind("Species", "MIC", "spearman","pVspearman","pearson","pVpearson","Case") # header

## output file name and location
write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_blood_species.result")
for (i in 1:length(linn)){ ## read each file
  Species=unlist(strsplit(linn[i], "[.]"))[1]
  dat <- read.table(paste("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/",linn[i],sep=""), header=T)
  x <- dat[,2]
  y <- dat[,3]
  M<-mine(x, y)$MIC  ## here is we do the Maximal information coefficient 
  S<-cor(x,y, method="spearman") ## here is we do the spearman correlation
  Sp<-cor.test(x,y,method="spearman")$p.value
  P<-cor(x,y, method="pearson") ## here is we do the pearson correlation
  Pp<-cor.test(x,y,method="pearson")$p.value
  count<-max(colSums( dat[,c(2,3)]!= 0)) ## the number of the cases for this species
  result<-cbind(Species,M,S,Sp,P,Pp,count)
  write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_blood_species.result")
}




## Species Corr in TCGA Adjacent vs Tumor ##
conn_species_adj <- file("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/Species/adjacent",open="r")
linn <-readLines(conn_species_adj)
result<-cbind("Species", "MIC", "spearman","pVspearman","pearson","pVpearson","Case")
write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_adjacent_species.result")
for (i in 1:length(linn)){
	Species=unlist(strsplit(linn[i], "[.]"))[1]
	dat <- read.table(paste("/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/",linn[i],sep=""), header=T)
	x <- dat[,2]
	y <- dat[,3]
	M<-mine(x, y)$MIC
	S<-cor(x,y, method="spearman")
	Sp<-cor.test(x,y,method="spearman")$p.value
	P<-cor(x,y, method="pearson")
	Pp<-cor.test(x,y,method="pearson")$p.value
	count<-max(colSums( dat[,c(2,3)]!= 0))
	result<-cbind(Species,M,S,Sp,P,Pp,count)
	write.table(result,append = TRUE,col.names=F,row.names=F,sep="\t",quote=F,file="/scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/CORR_adjacent_species.result")
}

close(conn_blood_phylum)
close(conn_adj_phylum)
close(conn_family_blood)
close(conn_family_adj)
close(conn_speceis_blood)
close(conn_species_adj)


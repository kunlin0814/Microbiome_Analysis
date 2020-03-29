#G39020.TCGA-BR-4255-01A-01D-A290-08.4.bam.sam-readsID-PhylumFamilySpecies-PhylumSum
#/Volumes/KUN DATA/TCGA/Stomach/G39020.TCGA-BR-4255-01A-01D-A290-08.4.bam/HumanMicroBiome/G39020.TCGA-BR-4255-01A-01D-A290-08.4.bam.sam-readsID-PhylumFamilySpecies-PhylumSum

#install.packages("stringr")
#library(tidverse)

tcga_current <-read.table("C:/Users/abc73_000/Desktop/TCGA_Stomach_indrive.txt",
                          header = FALSE,
                          stringsAsFactors = FALSE)


#for( i in t(tcga_current$V1) )

count_total<- function(i){

  phylum_count <- read.csv(paste("F:/TCGA/Stomach/",i,"/HumanMicroBiome/",i,".sam-readsID-PhylumFamilySpecies-PhylumSum",sep="",collapse=""),
                         header = FALSE,
                         stringsAsFactors = FALSE)
sum <- 0
for (i in 1:length(phylum_count)){
  sum <- sum + as.numeric(strsplit(phylum_count$V1," ")[[i]][2])
}
print(sum)

}
#summation <- c()
for (i in (tcga_current$V1)){
  
  count_total(i)
  #summation <- c(summation,sum)
  #id <- c(id,tcga_current$V1)
  #total_cunt <- c(total_cunt,sum)
  
}




phylum_count <- read.csv("F:/TCGA/Stomach/TCGA-F1-6874-10A-01D-1880/HumanMicroBiome/TCGA-F1-6874-10A-01D-1880.sam-readsID-PhylumFamilySpecies-PhylumSum",
                               header =FALSE,
                               stringsAsFactors = FALSE)

#strsplit(phylum_count$V1," ")[[1]][2]

# 1~13
sum <- 0
for (i in 1:length(phylum_count)){
 sum <- sum + as.numeric(strsplit(phylum_count$V1," ")[[i]][2])
}
print(sum)    



for( i in tcga_current$V1 ){
  print(i)}

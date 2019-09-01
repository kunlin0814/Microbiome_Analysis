Find_Sig_Species("/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx",'Gtex_species_significant',"/Users/kun-linho/Desktop/Species_TCGA_Gtex_distribution.xlsx",'TCGA_species_significant',cutoffvalue=0.20)


Find_Sig_Species <- function(Gtex_file,Gtex_sheet,TCGA_file,TCGA_sheet, Gtex_species, cutoffvalue){
  library(dplyr)
  library(readxl)
  library(Biobase)
  Gtex_sig_data <- read_excel(Gtex_file, sheet = Gtex_sheet)
  TCGA_sig_data <- read_excel(TCGA_file, sheet = TCGA_sheet)
  Gtex_sig_data <- as.matrix(Gtex_sig_data)
  TCGA_sig_data <- as.matrix(TCGA_sig_data)
  col_names <-colnames(Gtex_sig_data)
  colnames(Gtex_sig_data) <- NULL
  colnames(TCGA_sig_data) <- NULL
  Gtex_sample_amount <- length(Gtex_sig_data[,1])
  TCGA_sample_amount <- length(TCGA_sig_data[,1])
  cutoff <- cutoffvalue
  Gtex_species_gtcutoff <- c()
  TCGA_species_gtcutoff <- c()
  Gtex_sample_number <- c()
  TCGA_sample_number <- c()
  
  for (i in 1:length(col_names)){
    Gtex_sample_gtcutoff <- c()
    for (j in 1:Gtex_sample_amount){
      Gtex_species_enrichment <- Gtex_sig_data[j,i] 
      if (Gtex_species_enrichment > 0){
        Gtex_sample_gtcutoff <- c(Gtex_sample_gtcutoff, Gtex_species_enrichment)
      }
    }
    if (length(Gtex_sample_gtcutoff) >= Gtex_sample_amount*cutoff){
      Gtex_species_gtcutoff <- c(Gtex_species_gtcutoff,col_names[i] )
      Gtex_sample_number <- c(Gtex_sample_number,length(Gtex_sample_gtcutoff)/Gtex_sample_amount)
    }
    else {
      print(paste(col_names[i],"didn't pass", sep="",collapse="" ))
    }
  }
  
  for (i in 1:length(col_names)){
    TCGA_sample_gtcutoff <- c()
    for (j in 1:TCGA_sample_amount){
      TCGA_species_enrichment <- TCGA_sig_data[j,i] 
      if (TCGA_species_enrichment > 0){
        TCGA_sample_gtcutoff <- c(TCGA_sample_gtcutoff, TCGA_species_enrichment)
      }
    }
    if (length(TCGA_sample_gtcutoff) >= TCGA_sample_amount*cutoff){
      TCGA_species_gtcutoff <- c(TCGA_species_gtcutoff,col_names[i] )
      TCGA_sample_number <- c(TCGA_sample_number ,length(TCGA_sample_gtcutoff)/TCGA_sample_amount)
    }
    else {
      print(paste(col_names[i],"didn't pass", sep="",collapse="" ))
    }
  }
  n <- max(length(TCGA_species_gtcutoff),length(Gtex_species_gtcutoff))
  new_Gtex_species_gtcutoff = c(Gtex_species_gtcutoff, rep(NA,n - length(Gtex_species_gtcutoff)))
  new_TCGA_species_gtcutoff = c(TCGA_species_gtcutoff, rep(NA,n - length(TCGA_species_gtcutoff)))
  new_TCGA_sample_number <- c(TCGA_sample_number, rep(NA,n - length(TCGA_sample_number)))
  new_Gtex_sample_number <- c(Gtex_sample_number, rep(NA,n - length(Gtex_sample_number)))
  
  df <- data.frame(TCGA_species=new_TCGA_species_gtcutoff, TCGA_samplegtcutoff_ratio =new_TCGA_sample_number,  Gtex_species=new_Gtex_species_gtcutoff, Gtex_samplegtcutoff_ratio=new_Gtex_sample_number)
  write.table(df, file =paste('/Users/kun-linho/Desktop/TCGA_Gtex_TotalSpecies_Sign_gt',cutoff,'.txt',sep="",collapse="" ), row.names = F, quote= F, sep = '\t')
}




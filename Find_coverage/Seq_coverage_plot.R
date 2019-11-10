library(readxl)
coverageSTC <- read_excel("/Volumes/Research_Data/Microbiome_analysis/TCGA_STC_CRC_info_summary.xlsx",sheet ='STC_sequence_Coverage')
coveragecolon <- read_excel("/Volumes/Research_Data/Microbiome_analysis/TCGA_STC_CRC_info_summary.xlsx",sheet ='Colon_seq_coverage')
coverafeGtex <- read_excel("/Volumes/Research_Data/Microbiome_analysis/TCGA_STC_CRC_info_summary.xlsx",sheet ='Gtex_blood_Coverage')
coverafeRectum <- read_excel("/Volumes/Research_Data/Microbiome_analysis/TCGA_STC_CRC_info_summary.xlsx",sheet ='RECTUM-Coverage')

STCseqDepth <- coverageSTC$seqDepthf...4
colonseqDepth <- coveragecolon$seqDepthf
GtexseqDepth <- coverafeGtex$seqDepthf
RectumDepth <- coverafeRectum$seqDepthf...4
CRC_Depth <- NULL
CRC_Depth <- c(as.vector(colonseqDepth),as.vector(RectumDepth))
length(CRC_Depth)
length(CRC_Depth[CRC_Depth > 10])

png("Coverage_TCGA_STC.png",width=6000,height=4000,res=600)
hist(as.numeric(STCseqDepth), breaks = 500, xlab = 'Depth of Coverage', main = 'Coverage_TCGA_Stomach', ylab="# of samples",xaxt = "n",
     cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
axis(1, at=seq(0, 60, by=1),cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
dev.off()

png("Coverage_TCGA_colon.png",width=6000,height=4000,res=600)
hist(as.numeric(colonseqDepth), breaks = 500, xlab = 'Depth of Coverage', main = 'Coverage_TCGA_Colon', ylab="# of samples",xaxt = "n",
     cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
axis(1, at=seq(0, 60, by=1),cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
dev.off()

png("Coverage_Gtex_blood.png",width=6000,height=4000,res=600)
hist(as.numeric(GtexseqDepth), breaks = 500, xlab = 'Depth of Coverage', main = 'Coverage_Gtex_blood', ylab="# of samples",xaxt = "n",
     cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
axis(1, at=seq(0, 20, by=1),cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
dev.off()

png("Coverage_RECTUM.png",width=6000,height=4000,res=600)
hist(as.numeric(RectumDepth), breaks = 500, xlab = 'Depth of Coverage', main = 'Coverage_TCGA_RECTUM', ylab="# of samples",xaxt = "n",
     cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
axis(1, at=seq(0, 60, by=1),cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

png("Coverage_CRC.png",width=6000,height=4000,res=600)
hist(as.numeric(CRC_Depth), breaks = 500, xlab = 'Depth of Coverage', main = 'Coverage_TCGA_CRC', ylab="# of samples",xaxt = "n",
     cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)
axis(1, at=seq(0, 60, by=1),cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5)

dev.off()

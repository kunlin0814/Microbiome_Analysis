library(ggplot2)
library(dplyr)
#library(agricolae)

#adj <- read.table("/Users/kun-linho/Desktop/Microbiome_enrichment/fuso_enrichment/adj_TCGA_fuso_enrichment.txt",sep="\t",header = T )
#adj <- na.omit(adj) 
#TCGA_blood <-read.table('/Users/kun-linho/Desktop/Microbiome_enrichment/fuso_enrichment/blood_TCGA_fuso_enrichment.txt',sep='\t', header = T)
#TCGA_blood <- na.omit(TCGA_blood)
#TCGA_tumor <- read.table('/Users/kun-linho/Desktop/Microbiome_enrichment/fuso_enrichment/tumor_TCGA_fuso_enrichment.txt',sep='\t',header = T)
#Gtex_blood <- read.table('/Users/kun-linho/Desktop/Microbiome_enrichment/fuso_enrichment/Gtex_blood_fuso_enrichment.txt',sep='\t',header = T)
#adj_value <- adj$Ratio
#TCGA_blood_value <- TCGA_blood$Ratio
#TCGA_tumor_value <- TCGA_tumor$Ratio
#Gtex_blood_value <- TCGA_tumor$Ratio
#cbind(adj_value,TCGA_blood_value)

#n <- max(length(adj_value), length(TCGA_blood_value),length(TCGA_tumor_value),length(Gtex_blood_value))
#length(adj_value) <-n
#length(TCGA_blood_value) <- n
#length(TCGA_tumor_value) <- n
#length(Gtex_blood_value) <- n
#combine_vector <- cbind(adj_value,TCGA_blood_value,TCGA_tumor_value,Gtex_blood_value)



data <- read.table("C:/Users/abc73_000/Desktop/Anova_data.txt",sep='\t', header=T)
data <- na.omit(data)

data$Cancer_type <-paste(data$Type,data$Cancer, sep="_")
output <- data
output$Cases <- factor(output$Cases,levels = unique(output$Cases))

dodge <- position_dodge(width = 0.5)

ggplot(data=output,aes(x= Cases, y=Ratio, fill=Cancer_type )) + 
  geom_bar(stat ="identity", position=dodge, width = 0.3) +
  ylim(-20, 1500)+
  theme_minimal() 


output <- data
output$Type <- factor(output$Type,levels = unique(output$Type))


CRC_data <- data %>% 
  filter(Cancer=='CRC')

CRC_Tumor <- CRC_data %>% 
  filter(Type=='Tumor')

CRC_Blood<- CRC_data %>% 
    filter(Type=='Blood-derived normal')

Std_data <- data %>% 
  filter(Cancer=='Stomach') 





png("CRC_tumor_Fusobacterium_ulcerans.png",width=6000,height=6000,res=600)
library(RColorBrewer)
library(wesanderson)

p <-ggplot(data=output,aes(x= Cases, y=Ratio)) + 
  geom_bar(stat ="identity")+
  theme_minimal()

p+scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))



dev.off()

Std_blood <- Std_data %>% 
  filter(Type=='Blood-derived normal')
Std_tumor <- Std_data %>% 
  filter(Type=='Tumor')

Std_adj <- Std_data %>% 
  filter(Type=='Adjacent Normal')

Gtex_data <- data %>% 
  filter(Type=='Gtex_noraml')


wilcox.test(CRC_Blood$Ratio,CRC_Tumor$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(Std_blood$Ratio,Std_adj$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(Std_adj$Ratio,Std_tumor$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(Std_blood$Ratio,Std_tumor$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(CRC_Blood$Ratio,Std_adj$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(CRC_Blood$Ratio,Std_blood$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(CRC_Blood$Ratio,Std_tumor$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(CRC_Tumor$Ratio,Std_tumor$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(CRC_Tumor$Ratio,Std_adj$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(CRC_Tumor$Ratio,Std_blood$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(CRC_Blood$Ratio,Gtex_data$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(CRC_Tumor$Ratio,Gtex_data$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(Std_adj$Ratio,Gtex_data$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(Std_blood$Ratio,Gtex_data$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(Std_tumor$Ratio,Gtex_data$Ratio, alt="two.sided",paired = F, correct=T,exact=F)

data %>% 
ggplot(aes(x= Cases,y=Ratio,color=Cancer)) + 
  geom_bar(stat ="identity", fill="white") +  #alpha = transparency, 
  #if I put geom_point(color="red"), that is another way to change color 
  #scale_x_continuous(trans ="log10")+ another way to find logx
  #geom_smooth(method= 'lm') # add a linear regression line
  facet_wrap(~ Type)

data %>% 
  filter(Cancer==S
  )


# anova
res.aov <- aov(Ratio ~ Type, data=data)
summary(res.aov)
TukeyHSD(res.aov)

#full_join(TCGA_blood,adj)


wilcox.test(TCGA_tumor$Ratio,Gtex_blood$Ratio, alt="two.sided",paired = F, correct=T,exact=F)
wilcox.test(adj$Ratio,Gtex_blood$Ratio, alt="two.sided",paired = F, correct=T)
wilcox.test(TCGA_blood$Ratio,Gtex_blood$Ratio, alt="two.sided",paired = F, correct=T)
attach(data)
names(data)
class(Ratio)
class(Type)
levels(Type)
counts <- table(data$Ratio, data$Type)
png("TCGA_Gtex_microbiome_enrichment.png", width = 4000, height = 2000, res=500)
barplot(counts,ylim=c(0,1000))
dev.off()
kruskal.test(Ratio ~ Type, data=data)


t.test(TCGA_tumor$Ratio,Gtex_blood$Ratio)




#plot(TCGA_tumor$Ratio, ylim=c(0,100))
#combine_group <- data.frame(cbind(TCGA_blood$Ratio,TCGA_tumor$Ratio,Gtex_blood$Ratio))
#summary(combine_group)
aov(y ~ A, data=c(adj$Ratio,TCGA_blood$Ratio,TCGA_tumor$Ratio))

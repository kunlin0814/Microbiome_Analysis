#!/usr/bin/env python3


"""
This script take one input file derived from the the script calculating the median difference between TCGA and Gtex.
This script take another input file derived from the script calculating the correlation between TCGA blood and TCGA tumor.
It will create an ouput file that shows the speceis that has greater median difference in TCGA and has correlation in TCGA blood and tumor

"""

categories = ['Species','Family','Phylum']
# /Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/New_Median/Median_difference_result/TCGA_CRC_Gtex_significant_Family_summary.txt
for category in categories :
    ## input file 1, which is the file contains the median difference information ##
    with open ("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/New_Median/Median_difference_result/TCGA_CRC_Gtex_significant_"+category+"_summary.txt",'r')as f:
        file = f.read()
        median = file.split('\n')[:-1]
    ## /Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CORR/CORR_blood_Phylum.result
    ## input file 2, which is the file contains the correlation information ##
    with open("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/CORR/CORR_blood_"+category+".result", 'r')as f:
        file1 = f.read()
        corr = file1.split('\n')[:-1]
        
        
    overlap = open ("/Volumes/Research_Data/Microbiome_analysis/CRC_combine_with_cufOff/Overlap_Median_CORR/"+category+"_median_corr_overlap_withcutoff.txt",'w')    
    
    overlap.write('TCGA_Gtexoverlap\tTCGA_overlap_pvalue\tTCGA_sample_ratio\tTCGA_'+category+'_median\tGtex_sample_ratio\tGtex_'+category+'_median\tMedian_diff\t'+category+'\tMIC\tspearman\tpVspearman\tpearson\tpVpearson\tCase\n')
    
    for i in range(1,len(median)):
        difference = float(median[i].split('\t')[3])-float(median[i].split('\t')[5])
        if difference > 0 : ## the criteria is TCGA median reads of the species greater than that of Gtex
            species = median[i].split('\t')[0]
            pvalue = median[i].split('\t')[1]
            TCGA_sample_ratio = median[i].split('\t')[2]
            TCGA_species_median = median[i].split('\t')[3]
            Gtex_sample_ratio = median[i].split('\t')[4]
            Gtex_species_median = median[i].split('\t')[5]
            overlap.write(str(species)+'\t'+str(pvalue)+'\t'+str(TCGA_sample_ratio)+'\t'+str(TCGA_species_median)+'\t'+str(Gtex_sample_ratio)+'\t'+str(Gtex_species_median)+'\t'+str(difference)+'\t')
            for j in range(len(corr)):
                if species in corr[j]:
                    CORRspecies= str(corr[j].split('\t')[0])
                    MIC = str(corr[j].split('\t')[1])
                    spearman = str(corr[j].split('\t')[2])
                    pVspearman= str(corr[j].split('\t')[3])
                    pearson = str(corr[j].split('\t')[4])
                    pVpearson = str(corr[j].split('\t')[5])
                    Case = str(corr[j].split('\t')[6])
                    overlap.write(CORRspecies+'\t'+MIC+'\t'+spearman+'\t'+pVspearman+'\t'+pearson+'\t'+pVpearson+'\t'+Case+'\n')
                
        
        
        
    overlap.close()
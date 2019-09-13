#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# here the input is the species-summary-sort-fill0
# the script will create the enrichment and diversity of each samples 
# and then use shell script to get total_sample enrichment and diversity

import sys
import math
file_name=sys.argv[1] # here the input is the species-summary-sort-fill0
total_reads_file=sys.argv[2] # total read file for each sample
with open (total_reads_file, 'r')as f1:
    file1=f1.read()
    
total_read=int(file1)   

with open (file_name, 'r')as f:
    file=f.read()

total=file.split('\n')[:-1]
score={}
for i in range(len(total)):
    name=total[i].split()[0]
    value=total[i].split()[1]
    score[name]=value
sum=0
for i in score.values():
    sum+=int(i)

total_species_enrichment=(sum/total_read)*1000000
ni=0
"""
Shannon=0
denominator=sum*(sum-1)
for i in score.values():
    ni+=int(i)*(int(i)-1)
    Shannon+=(int(i)/sum)*math.log2(int(i)/sum)
Shannon = -1 * Shannon
"""
#Simpson=1-(ni/denominator)

#specific_species_value=int(score['Pseudomonas_fluorescens'])
#specific_species_enrichment= float(specific_species_value*1000000/total_read)

log2_total_species_enrichment = math.log2(float(total_species_enrichment)+0.00001)

output=open('diversity_calculation_species' + '.txt' ,'w')
#output.write(total_reads_file+'\t'+'total_read'+'\t'+'total_species_counts'+'\t'+'total_species_enrichment'+'\t'+'log2_total_species_enrichment'+'\n')
output.write(total_reads_file+'\t'+str(total_read)+'\t'+str(sum)+'\t'+str(total_species_enrichment)+'\t'+ str(log2_total_species_enrichment)+'\n')
output.close()
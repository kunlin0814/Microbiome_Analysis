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

species_enrichment=(sum/total_read)*1000000
ni=0

Shannon=0
denominator=sum*(sum-1)
for i in score.values():
    ni+=int(i)*(int(i)-1)
    Shannon+=(int(i)/sum)*math.log2(int(i)/sum)
Shannon = -1 * Shannon
#Simpson=1-(ni/denominator)

log2_total_species_enrichment = math.log2(float(species_enrichment)+(1/len(total)))

output=open('speciesDiversity_calculation' + '.txt' ,'w')
#output.write(total_reads_file+'\t'+'total_read'+'\t'+'total_species_counts'+'\t'+'species_enrichment'+'\t'+'Shannon_diversity'+'\n')
output.write(total_reads_file+'\t'+str(total_read)+'\t'+str(sum)+'\t'+str(species_enrichment)+'\t'+str(Shannon)+'\n')
output.close()
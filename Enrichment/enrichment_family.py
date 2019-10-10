#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun 13 14:05:02 2019

@author: kun-linho
"""
# here the input is the family-summary-sort-fill0
# the script will create the enrichment of each samples 
# and then use shell script to get total_sample enrichment

import sys
import math
file_name=sys.argv[1]
total_reads_file=sys.argv[2]

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

family_enrichment=(sum/total_read)*1000000
ni=0

log2_family_enrichment = math.log2(float(family_enrichment)+(1/len(total)))

output=open('familyEnrichment_calculation' + '.txt' ,'w')
#output.write(total_reads_file+'\t'+'total_read'+'\t'+'total_family_count'+'\t'+'family_enrichment'+'\t'+'log2_family_enrichment'+'\n')
output.write(total_reads_file+'\t'+str(total_read)+'\t'+str(sum)+'\t'+str(family_enrichment)+'\t'+str(log2_family_enrichment)+'\n')
output.close()
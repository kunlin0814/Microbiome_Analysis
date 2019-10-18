#!/usr/bin/env python3
# -*- coding: utf-8 -*-

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
phylum_enrichment=(sum/total_read)*1000000
"""
ni=0
Shannon=0
denominator=sum*(sum-1)
for i in score.values():
    ni+=int(i)*(int(i)-1)
    Shannon+=(int(i)/sum)*math.log2(int(i)/sum)
Shannon = -1 * Shannon
"""
log2_phylum_enrichment = math.log2(float(phylum_enrichment)+0.00001)
#Simpson=1-(ni/denominator)
#fuso_value=int(score['Fusobacteria'])
output=open('enrichment_phylum' + '.txt' ,'w')
#output.write(total_reads_file+'\t'+'total_read'+'\t'+'total_phylum_counts'+'\t'+'phylum_enrichment'+'\t'+'log2_phylum_enrichment'+'\n')
output.write(total_reads_file+'\t'+str(total_read)+'\t'+str(sum)+'\t'+str(phylum_enrichment)+'\t'+str(log2_phylum_enrichment)+'\n')
output.close()
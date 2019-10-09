#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jun 13 14:05:02 2019

@author: kun-linho
"""

import sys
file_name=sys.argv[1]
total_reads_file=sys.argv[2]
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

fuso_value=int(score['Fusobacteriaceae'])

with open(total_reads_file,'r') as f:
    file1=f.read()
total_read=int(file1)

ratio=fuso_value/total_read

output=open('fuso_enrich_family' + '.txt' ,'w')
output.write(total_reads_file+'\t'+'Fusobacteria'+'\n')
output.write(total_reads_file+'\t'+str(fuso_value)+'\n')
output.close()
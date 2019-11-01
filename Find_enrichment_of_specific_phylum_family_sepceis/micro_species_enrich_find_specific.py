#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# input 1: file name of .sam-readsID-PhylumFamilySpecies-SpeciesSum-sort
# input 2: file name of *-TotalReads

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

## species enrichment
fuso_value=int(score['Fusobacterium_ulcerans'])

with open(total_reads_file,'r') as f:
    file1=f.read()
total_read=int(file1)

ratio=fuso_value/total_read

output=open('fuso_enrich_species' + '.txt' ,'w')
output.write(total_reads_file+'\t'+'Fusobacterium_ulcerans'+'\n')
output.write(total_reads_file+'\t'+str(fuso_value)+'\n')
output.close()


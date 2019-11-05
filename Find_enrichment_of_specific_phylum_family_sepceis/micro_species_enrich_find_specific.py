#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
file_name=sys.argv[1]
total_reads_file=sys.argv[2]
candidate_species = sys.argv[3]
#species_result = sys.argv[4]

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


species_value=int(score[candidate_species])

with open(total_reads_file,'r') as f:
    file1=f.read()
total_read=int(file1)

ratio=float((species_value/total_read)*1000000)

output=open(candidate_species + '_value.txt' ,'w')
#output.write('file_name'+'\t'+ candidate_species +'\n')
output.write(total_reads_file.split('-')[0]+'\t'+str(ratio)+'\n')
output.close()


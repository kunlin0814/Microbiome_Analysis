#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
file_name=sys.argv[1]
total_reads_file=sys.argv[2]
candidate_Family = sys.argv[3]
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


species_value=int(score[candidate_Family])

with open(total_reads_file,'r') as f:
    file1=f.read()
total_read=int(file1)

ratio=float((species_value/total_read)*1000000)

output=open(candidate_Family + '_Family_value.txt' ,'w')
#output.write('file_name'+'\t'+ candidate_Family +'\n')
output_name = total_reads_file.split('-TotalReads')[0]
output.write(output_name+'\t'+str(ratio)+'\n')
output.close()


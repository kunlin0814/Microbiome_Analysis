# -*- coding: utf-8 -*-

import re 
pattern = r'\d+'
with open ("len4.txt") as f:
    file = f.read();

each_first = file.split("\n")[:-1]


for i in range(0,len(each_first)):
    if each_first[i]== '*':
        each_first[i]= '0M0'

if (len(each_first)%2 != 0) :
    each_first.append('0M0')
        
total =[] 

for i in range(0,len(each_first)):
    string = str(each_first[i])
    each = re.findall(pattern,string)
    for j in range(len(each)):
        if each[j]=='':
            each[j]=0
        total.append(each[j])    
summary = []
for i in range(0,len(total),2):
    first = int(total[i])
    second = int (total[i+1])
    sum = first + second
    summary.append(sum)


Max_value = max(summary)
print (Max_value)



#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 22 10:58:18 2019

@author: kun-linho
"""

import sys

with open ('/scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/total_species_sort.txt' ,'r') as f:
    total_file=f.read()
    total_name=total_file.split('\n')[:-1]
    
    
output=open('Gtex_species_summary' + '.txt' ,'w')
# Gtex_file_name=['/Users/kun-linho/Desktop/SAMN04595834.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0','/Users/kun-linho/Desktop/SAMN04595942.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0','/Users/kun-linho/Desktop/SAMN04596006.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0']

summary={}
for i in total_name:
    with open (i ,'r')as f:
        file= f.read()
        #file_name=i.split('/')[7] #[7]
        Gtex=file.split('\n')[:-1]
        for i in range(len(Gtex)):
            name=Gtex[i].split()[0]
            value=Gtex[i].split()[1]
            if int(value) != 0 :
                if name in summary.keys():
                    summary[name] += 1
                else:
                    summary[name] = 1
               
for i in summary.keys(): 
    output.write("Species"+ '\t '+ str(i) + '\t'+  "ratio"+ '\t'+ str(summary[i]/len(total_name)))
    output.write('\n')
    
output.close()    
        


    
    #total_name.append(name)

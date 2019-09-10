#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
This script needs to use the total file names that will be analyized in a txt file, 
Here we only analyze the blood samples, the output result will give you the how many cases have this species
"""
import sys

with open ('/scratch/kh31516/TCGA/Stomach/results/total_species_sort_TCGA.txt' ,'r') as f:
    total_file=f.read()
    total_name=total_file.split('\n')[:-1]
    
    
output=open('Colon_TCGA_species_summary' + '.txt' ,'w')
# Gtex_file_name=['/Users/kun-linho/Desktop/SAMN04595834.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0','/Users/kun-linho/Desktop/SAMN04595942.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0','/Users/kun-linho/Desktop/SAMN04596006.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0']

summary={}
for i in total_name:
    with open (i ,'r')as f:
        file= f.read()
        file_name=i.split('/')[7] #[7]
        #Gtex=file.split('\n')[:-1]
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

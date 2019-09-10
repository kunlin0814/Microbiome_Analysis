#!/usr/bin/env python3
# -*- coding: utf-8 -*-


# we don't apply the total reads cutoff to find the overlap species with Gtex
import sys
# take the file names as an input ex: sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0
with open ('/scratch/kh31516/TCGA/Stomach/results/total_species_sort_TCGA.txt' ,'r') as f: 
    total_file=f.read()
    total_name=total_file.split('\n')[:-1]
    
    
output=open('TCGA_species_summary' + '.txt' ,'w')
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

Gtex_summary = {}
TCGA_summary = {}
Gtex_overlap = {}
TCGA_overlap = {}
Gtex_uniq = {}
TCGA_uniq = {}

            
with open ('/Users/kun-linho/Desktop/nocut_Gtex_species_summary.txt' , 'r' )as f:
    Gtex_file = f.read()
    Gtex = Gtex_file.split('\n')[1:-1]
    
for i in range(len(Gtex)) :
    Gtex_species = Gtex[i].split('\t')[0]
    Gtex_ratio =  Gtex[i].split('\t')[1]
    Gtex_summary[Gtex_species]=Gtex_ratio
    
    

with open ('/Users/kun-linho/Desktop/nocut_TCGA_species_summary.txt', 'r' )as f1:
    TCGA_file = f1.read()
    TCGA = TCGA_file.split('\n')[1:-1]

for i in range(len(TCGA)) :
    TCGA_species = TCGA[i].split('\t')[0]
    TCGA_ratio =  TCGA[i].split('\t')[1]
    TCGA_summary[TCGA_species]=TCGA_ratio


for i in Gtex_summary.keys():
    if i in TCGA_summary.keys():
        Gtex_overlap[i] = Gtex_summary[i]
    else:
        Gtex_uniq[i]= Gtex_summary[i]

for i in TCGA_summary.keys():
    if i in Gtex_summary.keys():
        TCGA_overlap[i] = TCGA_summary[i]
    else:
        TCGA_uniq[i] =TCGA_summary[i]


g_overlap = open ('/Users/kun-linho/Desktop/no_cut_micr_Gtex_overlap.txt', 'w')

for i in Gtex_overlap.keys():
    g_overlap.write(str(i) + '\t' + str(Gtex_overlap[i]))
    g_overlap.write('\n')

g_overlap.close()

T_overlap = open ('/Users/kun-linho/Desktop/no_cut_micr_TCGA_overlap.txt', 'w')
for i in TCGA_overlap.keys():
    T_overlap.write(str(i) + '\t' + str(TCGA_overlap[i]))
    T_overlap.write('\n')

T_overlap.close()

G_uniq = open ('/Users/kun-linho/Desktop/no_cut_micr_Gtex_uniq.txt', 'w')
for i in Gtex_uniq.keys():
    G_uniq.write(str(i) +'\t' + str(Gtex_uniq[i]))
    G_uniq.write('\n')

G_uniq.close()

T_uniq = open('/Users/kun-linho/Desktop/no_cut_micr_TCGA_uniq.txt', 'w') 
for i in TCGA_uniq.keys():
    T_uniq.write(str(i)+ '\t' + str(TCGA_uniq[i]))
    T_uniq.write('\n')
    
    
T_uniq.close()
    
        

    
    
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# we don't apply the total reads cutoff to find the overlap species with Gtex
import sys
# take the file names as an input ex: sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0
with open ('/scratch/kh31516/TCGA/Stomach/results/total_species_sort-fiil0_TCGA.txt' ,'r') as f: 
    TCGA_total_file=f.read()
    TCGA_total_name=TCGA_total_file.split('\n')[:-1]

with open ('/scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/total_gtex_file_species_sort-fill0.txt','r') as f1:
    Gtex_total_file = f1.read()
    Gtex_total_name = Gtex_total_file.split('\n')[:-1]
       
TCGA_output = open('/scratch/kh31516/TCGA/Stomach/TCGA_species_summary' + '.txt' ,'w')
# Gtex_file_name=['/scratch/kh31516/TCGA/Stomach/SAMN04595834.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0','/scratch/kh31516/TCGA/Stomach/SAMN04595942.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0','/scratch/kh31516/TCGA/Stomach/SAMN04596006.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0']
GTex_output = open('/scratch/kh31516/TCGA/Stomach/Gtex_species_summary' + '.txt' ,'w')

TCGA_summary={}
for i in TCGA_total_name:
    with open (i ,'r')as f:
        file= f.read()
        #file_name=i.split('/')[7] #[7]
        TCGA_species = file.split('\n')[:-1]
        for i in range(len(TCGA_species)):
            name=TCGA_species[i].split()[0]
            value=TCGA_species[i].split()[1]
            if int(value) != 0 :
                if name in TCGA_summary.keys():
                    TCGA_summary[name] += 1
                else:
                    TCGA_summary[name] = 1
               
for i in TCGA_summary.keys(): 
    TCGA_output.write("Species"+ '\t '+ str(i) + '\t'+  "ratio"+ '\t'+ str(TCGA_summary[i]/len(TCGA_total_name)))
    TCGA_output.write('\n')
    
TCGA_output.close()


Gtex_summary={}
for i in Gtex_total_name:
    with open (i ,'r')as f:
        file= f.read()
        #file_name=i.split('/')[7] #[7]
        Gtex_species = file.split('\n')[:-1]
        for i in range(len(Gtex_species)):
            name=Gtex_species[i].split()[0]
            value=Gtex_species[i].split()[1]
            if int(value) != 0 :
                if name in Gtex_summary.keys():
                    Gtex_summary[name] += 1
                else:
                    Gtex_summary[name] = 1
               
for i in Gtex_summary.keys(): 
    GTex_output.write("Species"+ '\t '+ str(i) + '\t'+  "ratio"+ '\t'+ str(Gtex_summary[i]/len(Gtex_total_name)))
    GTex_output.write('\n')
    
GTex_output.close()   



Gtex_Species_summary = {}
TCGA_Species_summary = {}
Gtex_Species_overlap = {}
TCGA_Species_overlap = {}
Gtex_Species_uniq = {}
TCGA_Species_uniq = {}

            
with open ('/scratch/kh31516/TCGA/Stomach/Gtex_species_summary.txt' , 'r' )as f:
    Gtex_file = f.read()
    Gtex = Gtex_file.split('\n')[:-1]
    
for i in range(len(Gtex)) :
    Gtex_species = Gtex[i].split('\t')[1]
    Gtex_ratio =  Gtex[i].split('\t')[3]
    Gtex_Species_summary[Gtex_species]=Gtex_ratio
    
with open ('/scratch/kh31516/TCGA/Stomach/TCGA_species_summary.txt', 'r' )as f1:
    TCGA_file = f1.read()
    TCGA = TCGA_file.split('\n')[:-1]

for i in range(len(TCGA)) :
    TCGA_species = TCGA[i].split('\t')[1]
    TCGA_ratio =  TCGA[i].split('\t')[3]
    TCGA_Species_summary[TCGA_species]=TCGA_ratio


for i in Gtex_Species_summary.keys():
    if i in TCGA_Species_summary.keys():
        Gtex_Species_overlap[i] = Gtex_Species_summary[i]
    else:
        Gtex_Species_uniq[i]= Gtex_Species_summary[i]

for i in TCGA_Species_summary.keys():
    if i in Gtex_Species_summary.keys():
        TCGA_Species_overlap[i] = TCGA_Species_summary[i]
    else:
        TCGA_Species_uniq[i] =TCGA_Species_summary[i]


g_overlap = open ('/scratch/kh31516/TCGA/Stomach/no_cut_micr_Gtex_Species_overlap.txt', 'w')

for i in Gtex_Species_overlap.keys():
    g_overlap.write(str(i) + '\t' + str(Gtex_Species_overlap[i]))
    g_overlap.write('\n')

g_overlap.close()

T_overlap = open ('/scratch/kh31516/TCGA/Stomach/no_cut_micr_TCGA_Species_overlap.txt', 'w')
for i in TCGA_Species_overlap.keys():
    T_overlap.write(str(i) + '\t' + str(TCGA_Species_overlap[i]))
    T_overlap.write('\n')

T_overlap.close()

G_uniq = open ('/scratch/kh31516/TCGA/Stomach/no_cut_micr_Gtex_Species_uniq.txt', 'w')
for i in Gtex_Species_uniq.keys():
    G_uniq.write(str(i) +'\t' + str(Gtex_Species_uniq[i]))
    G_uniq.write('\n')

G_uniq.close()

T_uniq = open('/scratch/kh31516/TCGA/Stomach/no_cut_micr_TCGA_Species_uniq.txt', 'w') 
for i in TCGA_Species_uniq.keys():
    T_uniq.write(str(i)+ '\t' + str(TCGA_Species_uniq[i]))
    T_uniq.write('\n')

T_uniq.close()


total_share_species = list(TCGA_Species_overlap.keys()).sort()
        

    
    
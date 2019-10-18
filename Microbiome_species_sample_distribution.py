#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# The file we need
# 1. we need to find total sort-fill0 file as our first input( to get the file name for each fill0)
# 2. we need to find the overlap species between TCGA and Gtex derived from Gtex_TCGA.overlap script

# This script will produce three files. 
# 1. Every species enrichmnet for all samples. 2. Samples didn't pass the total species enrichment. 3 Samples that pass each species enrichemnt    

# We can specify the thershold count for total species enrichment, 
# if we only need to find the distribution, we can put 0. Once, we decide the threshold (FPM), we can replace it
# we can also decide the cutoff for each species 
# this file needs to apply both TCGA and Gtex becuase different TCGA have different overlap species with Gtex

import sys

threshold_count = [1024] # the threshold_count here is the total species enrichment, here is the place we need to change

with open ('/scratch/kh31516/TCGA/RECTUM/Total_blood_fill0.txt' ,'r') as f:
    total_file = f.read()
    total_name = total_file.split('\n')[:-1]


each_file={} # here we want to see the total species enrichment in each file (FPM)
for file_name in total_name:
    total_read_file=file_name.split('/')[6]
    with open ('/scratch/kh31516/TCGA/RECTUM/results/'+total_read_file+'/'+total_read_file+'-TotalReads','r') as f1:
        total_reads=int(f1.read())
        species_count = 0
        with open (file_name ,'r')as f:
            TCGA_species_file= f.read().split('\n')[:-1]
            for i in range(len(TCGA_species_file)):
                each_file_name = file_name
                species_count += int(TCGA_species_file[i].split()[1])
                each_file[each_file_name]=float(species_count*1000000/total_reads)

## here we need to find out what are the species that share for both TCGA and Gtex
total_share_species =[]
with open ('/scratch/kh31516/TCGA/RECTUM/no_cut_micr_Gtex_Species_overlap.txt','r') as f:
    share_species=f.read()
    file_share_species = share_species.split('\n')[:-1]

for i in range(1,len(file_share_species)) :
    each_species = file_share_species[i].split('\t')[0]
    total_share_species.append(each_species)

total_share_species = sorted(total_share_species)

for j in threshold_count :
    pass_files = []
    file_output = open('/scratch/kh31516/TCGA/RECTUM/files_didt_pass_threshold_count_'+str(j)+'_summary.txt','w')
    for i in each_file.keys():
        if each_file[i] > float(j):
            pass_files.append(i)
        else:
            didt_pass = i.split('/')[7]
            threshold = str(didt_pass)+'\t'+"don't pass the threshold:\t" + str(j)
            file_output.write(str(threshold)+'\t'+ 'the_species_enrich is:\t' + str(each_file[i]) +'\n')
    summary={}
    file_species_summary = open('/scratch/kh31516/TCGA/RECTUM/TCGA_blood_allSpecies_summary.txt','w')
    Species_With_cutoff =  open('/scratch/kh31516/TCGA/RECTUM/TCGA_blood_Species_with_cutoff.txt','w')
    Species_With_cutoff.write('file_Name\t')
    file_species_summary.write('file_Name\t')
    overlap={}
    
    for key in total_share_species:
            #print(key)
            file_species_summary.write(str(key)+'\t')

    file_species_summary.write('\n')
    species_cut_off = float(0) # Here we can specify the cutoff for each species, if we don't have, we can use 0
    for pass_file in pass_files:
        pass_file_name = pass_file.split("HumanMicroBiome")[0].split('/')[-2]
        with open ('/scratch/kh31516/TCGA/RECTUM/results/'+pass_file_name+'/'+pass_file_name+'-TotalReads','r') as f1:
            new_total_reads=int(f1.read())
        with open (pass_file ,'r')as f:
            score ={}
            cut_off_species={}
            TCGA_species_file= f.read().split('\n')[:-1]
            for i in range(len(TCGA_species_file)):
                name = TCGA_species_file[i].split()[0]
                value = TCGA_species_file[i].split()[1]
                score[name] = int(value)
            for i in total_share_species : 
                overlap[i] = float(int(score[i])* 1000000/ new_total_reads)
           
            for i in total_share_species : 
                if int(overlap[i]) >= species_cut_off:
                    cut_off_species[i] =  float(overlap[i])
                #else :
                    #print(str(i)+" didn't pass cutoff")
            
        
        for key in cut_off_species.keys():
            #print(key)
            Species_With_cutoff.write(str(key)+'\t')

        Species_With_cutoff.write('\n')
        Species_With_cutoff.write(str(pass_file_name)+'\t')

        for key in cut_off_species.keys():
            Species_With_cutoff.write(str(cut_off_species[key])+'\t')
        Species_With_cutoff.write('\n')
        
        file_species_summary.write(str(pass_file_name)+'\t')

        for key in overlap.keys():
            file_species_summary.write(str(overlap[key])+'\t')
        
        file_species_summary.write('\n')

        

        

        
        #for key in overlap.keys():
        #file_species_summary.write(str(key)+'\t')  
file_output.close()
file_species_summary.close()
Species_With_cutoff.close()    
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

with open ('/scratch/kh31516/TCGA/Stomach_original/Stomach/source/total_blood_TCGA_species_fill0.txt.txt' ,'r') as f:
    total_file = f.read()
    total_name = total_file.split('\n')[:-1]

with open ('/scratch/kh31516/TCGA/Stomach_original/Stomach/source/Species_shared_TCGA_Gtex.txt','r') as f:
    share_species=f.read()
    total_share_species = share_species.split('\n')[:-1]

each_file={} # here we want to see the total species enrichment in each file (FPM)
for file_name in total_name:
    total_read_file=file_name.split('/')[7]
    with open ('/scratch/kh31516/TCGA/Stomach_original/Stomach/results/'+total_read_file+'/'+total_read_file+'-TotalReads','r') as f1:
        total_reads=int(f1.read())
        species_count = 0
        with open (file_name ,'r')as f:
            TCGA_species_file= f.read().split('\n')[:-1]
            for i in range(len(TCGA_species_file)):
                each_file_name = file_name
                species_count += int(TCGA_species_file[i].split()[1])
                each_file[each_file_name]=float(species_count*1000000/total_reads)

threshold_count = [0]
for j in threshold_count :
    pass_files = []
    file_output = open('/scratch/kh31516/TCGA/Stomach_original/Stomach/threshold_count_'+str(j)+'file_no_pass_summary.txt','w')
    for i in each_file.keys():
        if each_file[i] > int(j):
            pass_files.append(i)
        else:
            didt_pass = i.split('/')[7]
            threshold = str(didt_pass)+'\t'+"don't pass the threshold:\t" + str(j)
            file_output.write(str(threshold)+'\t'+ 'the_species_enrich is:\t' + str(each_file[i]) +'\n')
    summary={}
    file_species_summary = open('/scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_blood_Species_summary.txt','w')
    Species_With_cutoff =  open ('/scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_blood_Species_with_cutoff.txt','w')            
    for pass_file in pass_files:
        #output=open('Blood_TCGA_threshold_count_'+str(j)+'species_ratio_summary' + '.txt' ,'w')
        #file_species_summary = open('total_file_Pseuo_flu_summary.txt','w')
        pass_file_name = pass_file.split("HumanMicroBiome")[0].split('/')[-2]
        with open ('/scratch/kh31516/TCGA/Stomach_original/Stomach/results/'+pass_file_name+'/'+pass_file_name+'-TotalReads','r') as f1:
            new_total_reads=int(f1.read())
        with open (pass_file ,'r')as f:
            score ={}
            overlap={}
            cut_off_species={}
            species_cut_off = float(3.36/112)
            TCGA_species_file= f.read().split('\n')[:-1]
            for i in range(len(TCGA_species_file)):
                name = TCGA_species_file[i].split()[0]
                value = TCGA_species_file[i].split()[1]
                score[name] = value
            for i in total_share_species : 
                overlap[i] = float(int(score[i])* 1000000/ new_total_reads)
           
            for i in total_share_species : 
                if int(overlap[i]) > species_cut_off:
                    cut_off_species[i] =  float(overlap[i])
                else :
                    print(str(i)+" didn't pass cutoff")
            
            Species_With_cutoff.write('\t')
            file_species_summary.write('\t')

            for key in overlap.keys():
                #print(key)
                file_species_summary.write(str(key)+'\t')
            file_species_summary.write('\n') 
            file_species_summary.write(str(pass_file_name)+'\t')
            for key in overlap.keys():
                file_species_summary.write(str(overlap[key])+'\t')

            for key in cut_off_species.keys():
                #print(key)
                Species_With_cutoff.write(str(key)+'\t')
            Species_With_cutoff.write('\n') 
            Species_With_cutoff.write(str(pass_file_name)+'\t')
            for key in cut_off_species.keys():
                Species_With_cutoff.write(str(cut_off_species[key])+'\t')

            Species_With_cutoff.write('\n')
            #for key in overlap.keys():
            #file_species_summary.write(str(key)+'\t')  
file_output.close()
file_species_summary.close()
Species_With_cutoff.close()    
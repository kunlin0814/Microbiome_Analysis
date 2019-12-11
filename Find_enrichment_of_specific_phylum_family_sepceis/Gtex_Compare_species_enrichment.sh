#!/bin/bash
#PBS -N Candidate_Microbes_enrichment
#PBS -l walltime=24:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=20gb
#PBS -q batch
#PBS -M kh31516@uga.edu
#PBS -m ae


## This script takes candidate Phylum, Family, and Species as source files and the 
## python script will calculate the enrichment of the candidate microbes from all of the samples

cd /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/
ml Python/3.7.0-foss-2018a

while read line ;
do
    printf  "%s\t%s\n" "file_name" "$line"  >> /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/total_candidate_Species_Gtex_${line}.txt
    while read line1 ;
    do
        cd /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/${line1}
        while read line2 ;
        do
            python3.7 /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/micro_species_enrich_find_specific.py \
            /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/${line1}/HumanMicroBiome/${line1}.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0 \
            ${line1}-TotalReads \
            ${line2}
        done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/CRC_candidate_Speceis.txt
        cat /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/${line1}/${line}_Species_value.txt >> /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/total_candidate_Species_Gtex_${line}.txt

    done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/gt_cut_off_gtex.txt
done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/CRC_candidate_Speceis.txt


while read line ;
do
    printf  "%s\t%s\n" "file_name" "$line"  >> /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/total_candidate_Family_Gtex_${line}.txt
    while read line1 ;
    do
        cd /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/${line1}
        while read line2 ;
        do
            python3.7 /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/micro_family_enrich_find_family.py \
            /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/${line1}/HumanMicroBiome/${line1}.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0 \
            ${line1}-TotalReads \
            ${line2}
        done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/CRC_candidate_Family.txt
    cat /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/${line1}/${line}_Family_value.txt >> /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/total_candidate_Family_Gtex_${line}.txt

    done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/gt_cut_off_gtex.txt
done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/CRC_candidate_Family.txt


while read line ;
do
    printf  "%s\t%s\n" "file_name" "$line"  >> /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/total_candidate_Phylum_Gtex_${line}.txt
    while read line1 ;
    do
        cd /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/${line1}
        while read line2 ;
        do
            python3.7 /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/micro_phylum_enrich_find_phylum.py \
            /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/${line1}/HumanMicroBiome/${line1}.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0 \
            ${line1}-TotalReads \
            ${line2}
        done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/CRC_candidate_Phylum.txt
    cat /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/${line1}/${line}_Phylum_value.txt >> /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff/total_candidate_Phylum_Gtex_${line}.txt

    done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/gt_cut_off_gtex.txt
done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/CRC_candidate_Phylum.txt
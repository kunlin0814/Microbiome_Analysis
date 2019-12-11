#PBS -S /bin/bash
#PBS -q batch
#PBS -l nodes=1:ppn=1:AMD
#PBS -N corr_microbiome
#PBS -l walltime=48:00:00
#PBS -l mem=20gb
#PBS -M kh31516@uga.edu 
#PBS -m ae


## this script was used to run in cluster to see the correlation between TCGA blood and TCGA tumor


cd /scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/Species
module load R/3.4.4-foss-2016b-X11-20160819-GACRC
while read line 
do
    #check=$(ls /scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/Species | grep -i "${line}.blood")
    #R CMD BATCH 
    Rscript --vanilla /scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/reg_analysis.R /scratch/kh31516/TCGA/CRC/gt_cutoff/CORR/${line}.blood
done < /scratch/kh31516/TCGA/CRC/source/CRC_candidate_speceis.txt
#R CMD BATCH Corr_Species.R
#R CMD BATCH Corr_Family.R

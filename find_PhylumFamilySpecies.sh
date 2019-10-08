#PBS -S /bin/bash
#PBS -q batch
#PBS -N species
#PBS -l nodes=1:ppn=1
#PBS -l walltime=10:00:00
#PBS -l mem=30gb
#PBS -M kh31516@uga.edu
#PBS -m ae


cd /scratch/kh31516/TCGA/Stomach_original/Stomach/
while read line ;
do
    cd /scratch/kh31516/TCGA/Stomach_original/Stomach/${line}/HumanMicroBiome/
    cat ${line}.sam-readsID-PhylumFamilySpecies-SpeciesSum | cut -d " " -f1 >> /scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_total_species.txt
    cat ${line}.sam-readsID-PhylumFamilySpecies-PhylumSum | cut -d " " -f1 >> /scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_total_phylum.txt
    cat ${line}.sam-readsID-PhylumFamilySpecies-FamilySum | cut -d " " -f1 >> /scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_total_family.txt
done < /scratch/kh31516/TCGA/Stomach_original/Stomach/total_cases.txt

cat /scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_total_species.txt | sort| uniq > /scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_total_species_uniq.txt
cat /scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_total_phylum.txt | sort| uniq > /scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_total_phylum_uniq.txt
cat /scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_total_family.txt | sort| uniq > /scratch/kh31516/TCGA/Stomach_original/Stomach/TCGA_total_family_uniq.txt


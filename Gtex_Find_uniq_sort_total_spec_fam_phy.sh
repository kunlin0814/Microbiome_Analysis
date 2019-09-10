#PBS -S /bin/bash
#PBS -q batch
#PBS -N total_species
#PBS -l nodes=1:ppn=4
#PBS -l walltime=300:00:00
#PBS -l mem=40gb

#while read line;
#do
#cat /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/WGS_random.sample_wtih_run.txt | grep -i $line
#done < /Volumes/TCGA_CRC/TCGA/CRC/finish/Gtex_samples.txt
cd /Volumes/TCGA_CRC/TCGA/CRC

while read line ;
do
    cd /Volumes/TCGA_CRC/TCGA/CRC/$line
    cat HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-SpeciesSum >>/Volumes/TCGA_CRC/TCGA/CRC/total_species.txt
    cat HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-PhylumSum >>/Volumes/TCGA_CRC/TCGA/CRC/total_phylum.txt
    cat HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-FamilySum >>/Volumes/TCGA_CRC/TCGA/CRC/total_family.txt

done < /Volumes/TCGA_CRC/TCGA/Total_CRC_cases.txt

cat /Volumes/TCGA_CRC/TCGA/total_species.txt | cut -d " " -f1 | sort | uniq > Total_Uniq_Species.txt
cat /Volumes/TCGA_CRC/TCGA/total_phylum.txt  | cut -d " " -f1 | sort | uniq > Total_Uniq_Phylum.txt
cat /Volumes/TCGA_CRC/TCGA/total_family.txt  | cut -d " " -f1 | sort | uniq > Total_Uniq_Family.txt


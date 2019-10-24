#PBS -S /bin/bash
#PBS -q batch
#PBS -N total_species
#PBS -l nodes=1:ppn=4
#PBS -l walltime=300:00:00
#PBS -l mem=40gb

#while read line;
#do
#cat /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/WGS_random.sample_wtih_run.txt | grep -i $line
#done < /scratch/kh31516/TCGA/colon/CRC/finish/Gtex_samples.txt
cd /scratch/kh31516/TCGA/colon/results

while read line ;
do
    cd /scratch/kh31516/TCGA/colon/results/${line}
    cat HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-SpeciesSum >>/scratch/kh31516/TCGA/colon/total_species.txt
    cat HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-PhylumSum >>/scratch/kh31516/TCGA/colon/total_phylum.txt
    cat HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-FamilySum >>/scratch/kh31516/TCGA/colon/total_family.txt

done < /scratch/kh31516/TCGA/colon/source/total_colon_file.txt

cat /scratch/kh31516/TCGA/colon/total_species.txt | cut -d " " -f1 | sort | uniq > /scratch/kh31516/TCGA/colon/Total_colon_Uniq_Species.txt
cat /scratch/kh31516/TCGA/colon/total_phylum.txt  | cut -d " " -f1 | sort | uniq > /scratch/kh31516/TCGA/colon/Total_colon_Uniq_Phylum.txt
cat /scratch/kh31516/TCGA/colon/total_family.txt  | cut -d " " -f1 | sort | uniq > /scratch/kh31516/TCGA/colon/Total_colon_Uniq_Family.txt


#PBS -S /bin/bash
#PBS -q batch
#PBS -N total_species
#PBS -l nodes=1:ppn=4
#PBS -l walltime=300:00:00
#PBS -l mem=40gb

#while read line;
#do
#cat /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/WGS_random.sample_wtih_run.txt | grep -i $line
#done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/finish/Gtex_samples.txt
cd /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/finish/

while read line1 line2;
do
    cd /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/finish/$line1
    cat HumanMicroBiome/${line2}.sam-readsID-PhylumFamilySpecies-SpeciesSum >>/scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/total_species.txt
    cat HumanMicroBiome/${line2}.sam-readsID-PhylumFamilySpecies-PhylumSum >>/scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/total_phylum.txt
    cat HumanMicroBiome/${line2}.sam-readsID-PhylumFamilySpecies-FamilySum >>/scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/total_family.txt

done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/Gtex_30sample_run.txt

cat /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/total_species.txt | uniq | sort > Total_Uniq_Species.txt
cat /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/total_phylum.txt | uniq | sort > Total_Uniq_Phylum.txt
cat /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/total_family.txt | uniq | sort > Total_Uniq_Family.txt
#PBS -S /bin/bash
#PBS -q batch
#PBS -N summary
#PBS -l nodes=1:ppn=1:AMD
#PBS -l walltime=48:00:00

while read line; 
do
	cd /scratch/kh31516/TCGA/colon/results/Blood/
	cd /scratch/kh31516/TCGA/colon/results/Blood/$line/HumanMicroBiome
	cat $line.sam-readsID-PhylumFamilySpecies-SpeciesSum|sort > $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort
	cat $line.sam-readsID-PhylumFamilySpecies-PhylumSum|sort > $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort
	cat $line.sam-readsID-PhylumFamilySpecies-FamilySum|sort > $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort
	python /scratch/kh31516/TCGA/colon/Scripts_for_data_anlaysis/prepare-matrix.py /scratch/kh31516/TCGA/colon/source/Total_colon_Uniq_Species.txt $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0
	python /scratch/kh31516/TCGA/colon/Scripts_for_data_anlaysis/prepare-matrix.py /scratch/kh31516/TCGA/colon/source/Total_colon_Uniq_Phylum.txt  $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0
	python /scratch/kh31516/TCGA/colon/Scripts_for_data_anlaysis/prepare-matrix.py /scratch/kh31516/TCGA/colon/source/Total_colon_Uniq_Family.txt $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0
	case=$(echo $line |cut -d'-' -f1-3)
	mkdir -p /scratch/kh31516/TCGA/colon/results/Blood/CORR/$case/
	cp $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0 /scratch/kh31516/TCGA/colon/results/Blood/CORR/$case/$line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0
	cp $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0 /scratch/kh31516/TCGA/colon/results/Blood/CORR/$case/$line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0
	cp $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0 /scratch/kh31516/TCGA/colon/results/Blood/CORR/$case/$line.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0
	
done < /scratch/kh31516/TCGA/colon/source/total_colon_blood_cases.txt


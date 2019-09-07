#PBS -S /bin/bash
#PBS -q batch
#PBS -N summary
#PBS -l nodes=1:ppn=1:AMD
#PBS -l walltime=48:00:00

module load python/2.7.8
module load R/3.3.1

cd /lustre1/jw16567/TCGA/results/done
while read line
	do
		cd /lustre1/jw16567/TCGA/results/done/$line/HumanMicroBiome
		#cat $line.sam-readsID-PhylumFamilySpecies-SpeciesSum|sort > $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort
		#cat $line.sam-readsID-PhylumFamilySpecies-PhylumSum|sort > $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort
		#cat $line.sam-readsID-PhylumFamilySpecies-FamilySum|sort > $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort
		python /lustre1/jw16567/TCGA/source/prepare-matrix.py /lustre1/jw16567/TCGA/results/speciesList $line.sam-readsID-PhylumFamilySpecies_phage-SpeciesSum-sort $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0
		python /lustre1/jw16567/TCGA/source/prepare-matrix.py /lustre1/jw16567/TCGA/results/phylumList $line.sam-readsID-PhylumFamilySpecies_phage-PhylumSum-sort $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0
		python /lustre1/jw16567/TCGA/source/prepare-matrix.py /lustre1/jw16567/TCGA/results/familyList $line.sam-readsID-PhylumFamilySpecies_phage-FamilySum-sort $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0
		type=$(echo $line |cut -d'-' -f1-3)
		cp $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0 /lustre1/jw16567/TCGA/results/Corr/$type/$line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0
		cp $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0 /lustre1/jw16567/TCGA/results/Corr/$type/$line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0
		cp $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0 /lustre1/jw16567/TCGA/results/Corr/$type/$line.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0
	done< file



#PBS -S /bin/bash
#PBS -q batch
#PBS -N summary
#PBS -l nodes=1:ppn=1:AMD
#PBS -l walltime=48:00:00



cd /Volumes/TCGA_CRC/TCGA/Colon
while read line
	do
		cd /Volumes/TCGA_CRC/TCGA/Colon/$line/HumanMicroBiome/
		cat $line.sam-readsID-PhylumFamilySpecies-SpeciesSum|sort > $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort
		cat $line.sam-readsID-PhylumFamilySpecies-PhylumSum|sort > $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort
		cat $line.sam-readsID-PhylumFamilySpecies-FamilySum|sort > $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort
		python /Users/kun-linho/Documents/GitHub/Microbiome_Analysis/Correlation/prepare-matrix.py /Volumes/TCGA_CRC/TCGA/Total_Uniq_Species.txt $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0
		python /Users/kun-linho/Documents/GitHub/Microbiome_Analysis/Correlation/prepare-matrix.py /Volumes/TCGA_CRC/TCGA/Total_Uniq_Phylum.txt  $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0
		python /Users/kun-linho/Documents/GitHub/Microbiome_Analysis/Correlation/prepare-matrix.py /Volumes/TCGA_CRC/TCGA/Total_Uniq_Family.txt $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0
		#type=$(echo $line |cut -d'-' -f1-3)
		#cp $line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0 /Volumes/TCGA_CRC/TCGA/Corr/$type/$line.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0
		#cp $line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0 /Volumes/TCGA_CRC/TCGA/Corr/$type/$line.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0
		#cp $line.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0 /Volumes/TCGA_CRC/TCGA/Corr/$type/$line.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0
	done < /Volumes/TCGA_CRC/TCGA/total_colon_cases.txt


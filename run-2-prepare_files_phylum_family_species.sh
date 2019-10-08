#PBS -S /bin/bash
#PBS -q batch
#PBS -l nodes=1:ppn=1:AMD
#PBS -l walltime=48:00:00
#PBS -l mem=20gb


##################################################################################
## In this script, we need to find the Uniq species, family and phylum list first
## This script is to count how many reads in each species, phylum and familys in each sample.
## It will create ex: Helicobacter_pylori and Helicobacter_pylori-sort.

## 
## CorrFile.py will create the files telling the reads of each species(family) in each TCGA Blood samples(10), and in each adjacent noraml samples comparing with tumor samples to prepare the correlation test
## It will create ex: Helicobacter_pylori.blood, Helicobacter_pylor.adjacent from CorrFile.py
## It will create ex: adjacent blood outfiles contains the infomration of all species . Ex: Phylum/Acidobacteria.adjacent


mkdir -p /scratch/kh31516/TCGA/Stomach_original/Stomach/CORR/Species
mkdir -p /scratch/kh31516/TCGA/Stomach_original/Stomach/CORR/Phylum
mkdir -p /scratch/kh31516/TCGA/Stomach_original/Stomach/CORR/Family

cd /scratch/kh31516/TCGA/Stomach_original/Stomach/CORR/
module load Python/2.7.14-foss-2018a
while read line
	do
		for f in */*sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0; 
			do 
				case=$(echo $f |cut -d'/' -f2| cut -d'-' -f1-7)
				count=$(cat $f|grep -i "$line" |cut -d' ' -f2)
				echo "$case" "$count" >> Species/$line
			done
		cat Species/$line|awk '{if(NF!=1)print $0}'|sort > Species/$line-sort
		python /scratch/kh31516/TCGA/Stomach_original/Stomach/scripts/CorrFile.py Species/$line-sort Species/$line
	done < /scratch/kh31516/TCGA/Stomach_original/Stomach/source/speciesList.txt

ls Species/*.blood > Species/blood
ls Species/*.adjacent > Species/adjacent

while read line
do
	for f in */*sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0; 
		do 
			case=$(echo $f |cut -d'/' -f2|cut -d'-' -f1-7)
			count=$(cat $f|grep $line|cut -d' ' -f2)
			echo $case $count >> Phylum/$line
		done
	cat Phylum/$line|awk '{if(NF!=1)print $0}'|sort > Phylum/$line-sort
	python /scratch/kh31516/TCGA/Stomach/scripts/CorrFile.py Phylum/$line-sort Phylum/$line
done< /scratch/kh31516/TCGA/Stomach_original/Stomach/source/phylumList.txt
ls Phylum/*.blood > Phylum/blood
ls Phylum/*.adjacent > Phylum/adjacent


while read line
do
	for f in */*sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0; 
		do 
			case=$(echo $f |cut -d'/' -f2|cut -d'-' -f1-7)
			count=$(cat $f|grep $line|cut -d' ' -f2)
			echo $case $count >> Family/$line
		done
	cat Family/$line|awk '{if(NF!=1)print $0}'|sort >Family/$line-sort
	python /scratch/kh31516/TCGA/Stomach/scripts/CorrFile.py Family/$line-sort Family/$line
done < /scratch/kh31516/TCGA/Stomach_original/Stomach/source/familyList.txt

ls Family/*.blood > Family/blood
ls Family/*.adjacent > Family/adjacent

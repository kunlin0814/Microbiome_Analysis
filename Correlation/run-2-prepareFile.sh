#PBS -S /bin/bash
#PBS -q batch
#PBS -l nodes=1:ppn=1:AMD
#PBS -l walltime=48:00:00:00
#PBS -l mem=20gb

cd /lustre1/jw16567/TCGA/results/Corr
module load python/2.7.8
while read line
	do
		for f in */*sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0; 
			do 
				case=$(echo $f |cut -d'/' -f2|cut -d'-' -f1-7)
				count=$(cat $f|grep $line|cut -d' ' -f2)
				echo $case $count >> Family/$line
			done
		cat Family/$line|awk '{if(NF!=1)print $0}'|sort >Family/$line-sort
		python /lustre1/jw16567/TCGA/source/CorrFile.py Family/$line-sort Family/$line
	done</lustre1/jw16567/TCGA/results/familyList
#PBS -S /bin/bash
#PBS -q batch
#PBS -l nodes=1:ppn=1:AMD
#PBS -l walltime=48:00:00
#PBS -l mem=20gb

cd /scratch/kh31516/TCGA/colon/results/Blood/
ml Python/3.7.0-foss-2018a

: "
# the python script micro_phylum_enrich.py give you the enrichemnt of specific species
while read line;
do 
    cd /scratch/kh31516/TCGA/colon/results/Blood/$line
    python3.7 /scratch/kh31516/TCGA/colon/Scripts_for_data_anlaysis/micro_phylum_enrich.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0 ${line}-TotalReads
    python3.7 /scratch/kh31516/TCGA/colon/Scripts_for_data_anlaysis/micro_family_enrich.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0 ${line}-TotalReads
    python3.7 /scratch/kh31516/TCGA/colon/Scripts_for_data_anlaysis/micro_species_enrich.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0 ${line}-TotalReads

done < /scratch/kh31516/TCGA/colon/source/total_colon_blood_cases.txt
"
: "
while read line;
do 
    cd /scratch/kh31516/TCGA/colon/results/Blood/$line
    cat fuso_enrich_phylum.txt >> cd /scratch/kh31516/TCGA/colon/fuso_phylum_sum.txt
    cat fuso_enrich_family.txt >> cd /scratch/kh31516/TCGA/colon/fuso_family_sum.txt
    cat fuso_enrich_species.txt >> cd /scratch/kh31516/TCGA/colon/fuso_species_sum.txt
done < /scratch/kh31516/TCGA/colon/source/total_colon_blood_cases.txt
"
## the python script diversity_species.py give you the distribution and diversity of the totoal species, families, and phylum
## the diversity python scripts takes arg[1] as the fill-0 and arg[2] as the total_reads file
## the output for each folder is 'diversity_calculation_species(family, phylum).txt
while read line;
do 
    cd /scratch/kh31516/TCGA/colon/results/Blood/$line
    python3.7 /scratch/kh31516/TCGA/colon/Scripts_for_data_anlaysis/diversity_species.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort ${line}-TotalReads
    python3.7 /scratch/kh31516/TCGA/colon/Scripts_for_data_anlaysis/diversity_family.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-FamilySum-sort ${line}-TotalReads
    python3.7 /scratch/kh31516/TCGA/colon/Scripts_for_data_anlaysis/diversity_phylum.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-PhylumSum-sort ${line}-TotalReads
done < /scratch/kh31516/TCGA/colon/source/TCGA_colon_blood_avail_cases.txt

#TCGA-AA-3968-10A-01D-1167-02_IlluminaHiSeq-DNASeq_whole.bam.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0
# cat the summary of each sample to total samples
while read line;
do 
    cd /scratch/kh31516/TCGA/colon/results/Blood/$line
    cat diversity_calculation_phylum.txt >>  /scratch/kh31516/TCGA/colon/phylum_diversity_sum.txt
    cat diversity_calculation_family.txt >>  /scratch/kh31516/TCGA/colon/family_diversity_sum.txt
    cat diversity_calculation_species.txt >> /scratch/kh31516/TCGA/colon/species_diversity_sum.txt
done < /scratch/kh31516/TCGA/colon/source/TCGA_colon_blood_avail_cases.txt
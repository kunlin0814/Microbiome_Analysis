#PBS -S /bin/bash
#PBS -q batch
#PBS -l nodes=1:ppn=1:AMD
#PBS -l walltime=48:00:00
#PBS -l mem=20gb

cd /scratch/kh31516/TCGA/CRC/gt_cutoff/
module load Python/3.7.0-foss-2018a


## the python script enrichment_diversity_species.py give you the distribution and diversity of the totoal species, families, and phylum
## the diversity python scripts takes arg[1] as the fill-0 and arg[2] as the total_reads file
## the output for each folder is 'diversity_calculation_species(family, phylum).txt
## here we need to find the blood file name

printf  "%s\t%s\t%s\t%s\t%s\t%s\n" "file_name" "total_reads" "total_phylum_counts" "phylum_enrichment" "log2_phylum_enrichment" "phylumShannon_diversity" >> /scratch/kh31516/TCGA/CRC/gt_cutoff/new_blood_phylumEnrichmentDiversity_sum.txt
printf  "%s\t%s\t%s\t%s\t%s\t%s\n" "file_name" "total_reads" "total_family_counts" "family_enrichment" "log2_family_enrichment" "familyShannon_diversity" >> /scratch/kh31516/TCGA/CRC/gt_cutoff/new_blood_familyEnrichmentDiversity_sum.txt
printf  "%s\t%s\t%s\t%s\t%s\t%s\n" "file_name" "total_reads" "total_species_counts" "species_enrichment" "log2_speces_enrichment" "speciesShannon_diversity" >> /scratch/kh31516/TCGA/CRC/gt_cutoff/new_blood_speciesEnrichmentDiversity_sum.txt

while read line;
do 
    cd /scratch/kh31516/TCGA/CRC/gt_cutoff/$line
    python3.7 /scratch/kh31516/TCGA/CRC/scripts/enrichment_diversity_species.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort ${line}-TotalReads
    python3.7 /scratch/kh31516/TCGA/CRC/scripts/enrichment_diversity_phylum.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-FamilySum-sort ${line}-TotalReads
    python3.7 /scratch/kh31516/TCGA/CRC/scripts/enrichment_diversity_family.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-PhylumSum-sort ${line}-TotalReads
    
    # cat the summary of each sample to total samples
    
    cat phylumEnrichmentDiversity_calculation.txt >>  /scratch/kh31516/TCGA/CRC/gt_cutoff/new_blood_phylumEnrichmentDiversity_sum.txt
    cat familyEnrichmentDiversity_calculation.txt >>  /scratch/kh31516/TCGA/CRC/gt_cutoff/new_blood_familyEnrichmentDiversity_sum.txt
    cat speciesEnrichmentDiversity_calculation.txt >> /scratch/kh31516/TCGA/CRC/gt_cutoff/new_blood_speciesEnrichmentDiversity_sum.txt

done < /scratch/kh31516/TCGA/CRC/source/Blood_total_CRC_casesgtcutoff.txt

#TCGA-AA-3968-10A-01D-1167-02_IlluminaHiSeq-DNASeq_whole.bam.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0
# cat the summary of each sample to total samples

: "
# the python script micro_phylum_enrich.py give you the enrichemnt of specific species
while read line;
do 
    cd /scratch/kh31516/TCGA/CRC/gt_cutoff/$line
    python3.7 /scratch/kh31516/TCGA/CRC/gt_cutoff/micro_phylum_enrich.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-PhylumSum-sort-fill0 ${line}-TotalReads
    python3.7 /scratch/kh31516/TCGA/CRC/gt_cutoff/micro_family_enrich.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-FamilySum-sort-fill0 ${line}-TotalReads
    python3.7 /scratch/kh31516/TCGA/CRC/gt_cutoff/micro_species_enrich.py HumanMicroBiome/${line}.sam-readsID-PhylumFamilySpecies-SpeciesSum-sort-fill0 ${line}-TotalReads

done < /scratch/kh31516/TCGA/CRC/gt_cutoff/source/total_colon_blood_cases.txt
"
: "
while read line;
do 
    cd /scratch/kh31516/TCGA/CRC/gt_cutoff/$line
    cat fuso_enrich_phylum.txt >> cd /scratch/kh31516/TCGA/CRC/gt_cutoff/fuso_phylum_sum.txt
    cat fuso_enrich_family.txt >> cd /scratch/kh31516/TCGA/CRC/gt_cutoff/fuso_family_sum.txt
    cat fuso_enrich_species.txt >> cd /scratch/kh31516/TCGA/CRC/gt_cutoff/fuso_species_sum.txt
done < /scratch/kh31516/TCGA/CRC/gt_cutoff/source/total_colon_blood_cases.txt
"

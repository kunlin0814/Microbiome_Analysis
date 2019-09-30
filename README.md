# Microbiome_Analysis
# The pipeline for the Microbiome Analysis

1. Find the total-uniq-species (use the find the species script)
2. Fill-up 0 to all the file, Use run-1-fillup0.sh scripts
3. Use the script /Users/kun-linho/Documents/GitHub/Microbiome_Analysis/Diversity/diversity_species.py and /Users/kun-linho/Documents/GitHub/Microbiome_Analysis/Diversity/microbiome_diversify.sh to get the total_read distributions for each sample of all species (and also the diversity )for each sample and run microbiome_diversify.sh to get total summary and copy to excel.
4. Find the distribution for the total_reads of total_file (use Find_TCGA_Gtex_spcies_Enrichment.R) to see the plot so that we can have the threshold_count for the colon files and to find the statistic significant species compared with Gtex
5. Get the total_fill 0 species file name (only from blood)
6. Run Gtex_TCGA_overlap.py to find the overlap species to prepare do the statistic analysis. We will have overlap species in this script
7. Run /Users/kun-linho/Documents/GitHub/Microbiome_Analysis/Microbiome_species_sample_distribution.py to get the  distribution of all species for all samples for Gtex and TCGA and copy to the excel file. (We need to apply the total enrichment threshold in this script, we also need to apply to Gtex because the overlap species might different)
8. Run the script Find_Significant_Species_TCGA_Gtex.R to get the p value, ratio and median value
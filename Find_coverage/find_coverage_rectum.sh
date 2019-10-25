#PBS -S /bin/bash
#PBS -q batch
#PBS -N GetCoverage
#PBS -l nodes=1:ppn=1
#PBS -l walltime=10:00:00
#PBS -l pmem=20gb
#PBS -M kh31516@uga.edu
#PBS -m ae

cd /scratch/kh31516/TCGA/RECTUM/results
module load gdc-client/1.3.0
module load SAMtools/1.6-foss-2016b

cut_off=10
printf "%s\t%s\t%s\t%sf\n" "fileName" "seq_Len" "totalReads" "seqDepth" >> /scratch/kh31516/TCGA/RECTUM/cut_off_RECTUM-CoverageSummary.txt
while read line;
do 
    cd /scratch/kh31516/TCGA/RECTUM/results/$line
    samtools view ${line}.unmapped_sorted.bam | head -10 | cut -f10  > /scratch/kh31516/TCGA/RECTUM/results/$line/length.txt
    length=$(python3 /scratch/kh31516/TCGA/Stomach_original/Stomach/find_bam_seq_len.py /scratch/kh31516/TCGA/RECTUM/results/$line/length.txt | bc)
    total=$(cat ${line}-TotalReads | bc)
    coverage=$((length*total/3000000000))
    if [ $coverage -ge $cut_off ]; then
        printf  "%s\t%d\t%d\t%.4f\n" "${line}" "$length" "$total" "$coverage" >> /scratch/kh31516/TCGA/RECTUM/cut_off_RECTUM-CoverageSummary.txt
        mv /scratch/kh31516/TCGA/RECTUM/results/$line /scratch/kh31516/TCGA/CRC/gt_cutoff
    fi
done < /scratch/kh31516/TCGA/RECTUM/source/Total_RECTUM_cases.txt
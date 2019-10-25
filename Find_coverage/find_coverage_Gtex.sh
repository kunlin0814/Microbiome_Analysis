#PBS -S /bin/bash
#PBS -q batch
#PBS -N GetCoverage
#PBS -l nodes=1:ppn=1
#PBS -l walltime=10:00:00
#PBS -l pmem=20gb
#PBS -M kh31516@uga.edu
#PBS -m ae

cd /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/
module load gdc-client/1.3.0
module load SAMtools/1.6-foss-2016b

cut_off=10

printf "%s\t%s\t%s\t%sf\n" "fileName" "seq_Len" "totalReads" "seqDepth" >> /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/cut_off_Gtex_blood_coverage_summary.txt
while read line;
do 
    cd /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/$line
    #rm /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/$line/length.txt
    Name=$(echo /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/$line/*[0-9].bam)
    #echo "$Name"
    samtools view $Name | head -10 | cut -f10  > /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/$line/length.txt
    length=$(python3 /scratch/kh31516/TCGA/Stomach_original/Stomach/find_bam_seq_len.py /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/$line/length.txt | bc)
    total=$(cat ${line}-TotalReads | bc)
    coverage=$((length*total/3000000000))
    if [ $coverage -ge $cut_off ]; then
        printf  "%s\t%d\t%d\t%.4f\n" "${line}" "$length" "$total" "$coverage" >> /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/cut_off_Gtex_blood_coverage_summary.txt
        mv /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/$line /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/results/gt_cutoff
        
        
    fi
    
done < /scratch/kh31516/Gtex/Blood/WGS_normal_blood_result/source/Total_gtex_blood_cases.txt
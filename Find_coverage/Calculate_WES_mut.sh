#! bin/bash
cd /scratch/kh31516/Melanoma_merge/results
while read line;
do
cd  /scratch/kh31516/Melanoma_merge/results/${line}
b=$(cat ${line}_rg_added_sorted_dedupped_removed.MuTect.vcf | grep -w PASS | wc -l |bc) #numer
a=$(cat ${line}_rg_added_sorted_dedupped_removed.bam_coverage.wig.txt | grep -w 1| wc -l | bc) # denominator
c=$(echo "$((b-1))*1000000/$((a-1))" | bc -l)
printf  "%s\t%4f\t%d\t%d\n" "${line}" "$c" "$((b-1))" "$((a-1))" >> /scratch/kh31516/Melanoma_merge/results/mut_melanoma_summary.txt
done < /scratch/kh31516/Melanoma_merge/results/melanoma_cases.txt

b/a*1000000


CMT-100 

b=$(cat CMT-100_rg_added_sorted_dedupped_removed.MuTect.vcf | grep -w PASS | wc -l |bc) #numer
a=$(cat CMT-100_rg_added_sorted_dedupped_removed.bam_coverage.wig.txt | grep -w 1| wc -l | bc) # denominator
c=$(echo "$((b-1))*1000000/$((a-1))" | bc -l)
printf  "%s\t%4f\t%d\t%d\n" "CMT-100" "$c" "$((b-1))" "$((a-1))"
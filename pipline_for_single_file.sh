#PBS -S /bin/bash
#PBS -q batch
#PBS -N 0032406a-20bf-4092-832e-d73a3da4c00d-TCGA
#PBS -l nodes=1:ppn=1
#PBS -l walltime=150:00:00
#PBS -l pmem=35gb 
#PBS -M kh31516@uga.edu
#PBS -m ae

sequence_data='/scratch/kh31516/TCGA/colon/data'
results='/scratch/kh31516/TCGA/colon/results'
HumanMicroBiome_source='/scratch/kh31516/TCGA/jin_source/HumanMicroBiome' 

cd $sequence_data

module load gdc-client/1.3.0
module load SAMtools/1.6-foss-2016b
module load BEDTools/2.26.0-foss-2016b
module load BWA/0.7.17-foss-2016b

# check if the file is downloaded
cd $sequence_data
check=$(ls | grep -i "0032406a-20bf-4092-832e-d73a3da4c00d")

if [ -z "$check" ];then
    cd $sequence_data
<<<<<<< HEAD
    gdc-client download 0032406a-20bf-4092-832e-d73a3da4c00d -t $/scratch/kh31516/TCGA/colon/gdc-user-token.2019-08-23T00_36_21.797Z.txt
=======
    gdc-client download 0032406a-20bf-4092-832e-d73a3da4c00d -t /scratch/kh31516/TCGA/colon/gdc-user-token.2019-08-23T00_36_21.797Z.txt
>>>>>>> bbb62fb9f3465b55c111f151c6cbe4758190b49b
    Name=$(echo 0032406a-20bf-4092-832e-d73a3da4c00d/*.bam |cut -d'/' -f2|cut -d'_' -f1-3)
    mkdir $results/$Name/ 
    samtools view -b 0032406a-20bf-4092-832e-d73a3da4c00d/*.bam|wc -l > $results/$Name/$Name-TotalReads
    samtools view -b -f 4 0032406a-20bf-4092-832e-d73a3da4c00d/*.bam > $results/$Name/$Name.unmapped.bam
    samtools view 0032406a-20bf-4092-832e-d73a3da4c00d/*.bam|awk '{print $1}' > $results/$Name/$Name-header
    gzip $results/$Name/$Name-header
else
    cd $sequence_data
    Name=$(echo 0032406a-20bf-4092-832e-d73a3da4c00d/*.bam |cut -d'/' -f2|cut -d'_' -f1-3)
    mkdir $results/$Name/ 
    samtools view -b 0032406a-20bf-4092-832e-d73a3da4c00d/*.bam|wc -l > $results/$Name/$Name-TotalReads
    samtools view -b -f 4 0032406a-20bf-4092-832e-d73a3da4c00d/*.bam > $results/$Name/$Name.unmapped.bam
    samtools view 0032406a-20bf-4092-832e-d73a3da4c00d/*.bam|awk '{print $1}' > $results/$Name/$Name-header
    gzip $results/$Name/$Name-header
fi

#bam2fq
cd $results/$Name
samtools sort $Name.unmapped.bam -o $Name.unmapped_sorted.bam  
bedtools bamtofastq -i $Name.unmapped_sorted.bam -fq $Name_unmapped_R1.fq -fq2 $Name_unmapped_R2.fq
gzip $Name_unmapped_R1.fq
gzip $Name_unmapped_R2.fq
rm $Name.unmapped.bam
mkdir $results/$Name/HumanMicroBiome

bwa aln $HumanMicroBiome_source/all_seqs.fa.gz \
$Name_unmapped_R1.fq.gz > HumanMicroBiome/$Name_unmapped_R1.fq.sai

bwa aln $HumanMicroBiome_source/all_seqs.fa.gz \
$Name_unmapped_R2.fq.gz \
> HumanMicroBiome/$Name_unmapped_R2.fq.sai
            
bwa sampe -n 10000 -N 10000 $HumanMicroBiome_source/all_seqs.fa.gz \
HumanMicroBiome/$Name_unmapped_R1.fq.sai \
HumanMicroBiome/$Name_unmapped_R2.fq.sai \
$Name_unmapped_R1.fq.gz \
$Name_unmapped_R2.fq.gz \
> HumanMicroBiome/$Name.sam
 
cd $results/$Name/HumanMicroBiome
python2.7 $HumanMicroBiome_source/Samfilter4pathogen-HMB.py $Name.sam

samtools view -bS $Name.sam > $Name.bam

rm $Name.sam 

t=$(cat $Name.sam-readsID|wc -l)
        if [ $t -gt 200000 ]
        then
            split -l 200000 $Name.sam-readsID
            for f in x*
                do
                    perl $HumanMicroBiome_source/bac-classify-mapV1.pl $f $HumanMicroBiome_source/GoldBacData.txt-classification-clean-phylum-family-HMB_phage $f-PhylumFamilySpecies
                done
            cat x*-PhylumFamilySpecies>$Name.sam-readsID-PhylumFamilySpecies
            rm x*
        else
            perl $HumanMicroBiome_source/bac-classify-mapV1.pl $Name.sam-readsID $HumanMicroBiome_source/GoldBacData.txt-classification-clean-phylum-family-HMB_phage $Name.sam-readsID-PhylumFamilySpecies
        fi
        
cat $Name.sam-readsID-PhylumFamilySpecies|awk '{print $1, $4}'|sort|uniq >$Name.sam-readsID-PhylumFamilySpecies-Phylum
cat $Name.sam-readsID-PhylumFamilySpecies-Phylum |awk '{print $1}'|uniq -d >$Name.sam-readsID-PhylumFamilySpecies-PhylumDUP
join -v1 $Name.sam-readsID-PhylumFamilySpecies-Phylum $Name.sam-readsID-PhylumFamilySpecies-PhylumDUP > $Name.sam-readsID-PhylumFamilySpecies-PhylumUniq
cat $Name.sam-readsID-PhylumFamilySpecies-PhylumUniq|awk '{print $2}'|sort|uniq -c|sort -nr|awk '{print $2, $1}' >$Name.sam-readsID-PhylumFamilySpecies-PhylumSum

 
cat $Name.sam-readsID-PhylumFamilySpecies|awk '{print $1, $5}'|sort|uniq >$Name.sam-readsID-PhylumFamilySpecies-Family
cat $Name.sam-readsID-PhylumFamilySpecies-Family |awk '{print $1}'|uniq -d >$Name.sam-readsID-PhylumFamilySpecies-FamilyDUP
join -v1 $Name.sam-readsID-PhylumFamilySpecies-Family $Name.sam-readsID-PhylumFamilySpecies-FamilyDUP > $Name.sam-readsID-PhylumFamilySpecies-FamilyUniq
cat $Name.sam-readsID-PhylumFamilySpecies-FamilyUniq|awk '{print $2}'|sort|uniq -c|sort -nr|awk '{print $2, $1}' >$Name.sam-readsID-PhylumFamilySpecies-FamilySum

##Species
cat $Name.sam-readsID-PhylumFamilySpecies|awk '{print $1, $2}'|sort|uniq |grep -v '_sp.' >$Name.sam-readsID-PhylumFamilySpecies-Species
cat $Name.sam-readsID-PhylumFamilySpecies-Species|awk '{print $1}'|uniq -d >$Name.sam-readsID-PhylumFamilySpecies-SpeciesDUP
join -v1 $Name.sam-readsID-PhylumFamilySpecies-Species $Name.sam-readsID-PhylumFamilySpecies-SpeciesDUP > $Name.sam-readsID-PhylumFamilySpecies-SpeciesUniq
cat $Name.sam-readsID-PhylumFamilySpecies-SpeciesUniq|awk '{print $2}'|sort|uniq -c|sort -nr|awk '{print $2, $1}' >$Name.sam-readsID-PhylumFamilySpecies-SpeciesSum

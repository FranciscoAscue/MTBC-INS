#!/bin/bash
####################################################################################################################
#					       CONSENSUS SEQUENCES                                                 #
#						BY FRANCISCO ASCUE						   #
#					email: francisco.ascue131@gmail.com					   #
####################################################################################################################

##CONSTANT
WD="/mnt/disco3/fascue/.docker"
GM="$WD/data/reads"
OD="$WD/results/mapped"
TRM="$WD/results/trimmed"

##EXECUTION

echo "Started at `date`"

for i in $(cat $GM/codigos2.txt);do
	echo "bowtie2 --local -I 50 -X 800 -p 20 -x ${WD}/data/reference/NC_000962.3 -1 $TRM/${i}_R1_trimp.fastq.gz -2 $TRM/${i}_R2_trim.fastq.gz -S ${OD}/${i}.sam"
	bowtie2 --local -I 50 -X 800 -p 20 -x ${WD}/data/reference/NC_000962.3 -1 $TRM/${i}_R1_trimp.fastq.gz -2 $TRM/${i}_R2_trim.fastq.gz -S ${OD}/${i}.sam
	echo "samtools view -u@ 8 $OD/${i}.sam | samtools sort -@ 20 -o ${OD}/${i}.sorted.bam -"
	samtools view -u@ 8 $OD/${i}.sam | samtools sort -@ 20 -o ${OD}/${i}.sorted.bam -
	echo "samtools index ${OD}/${i}.sorted.bam"
	samtools index ${OD}/${i}.sorted.bam
done

echo "Finished at `date`"

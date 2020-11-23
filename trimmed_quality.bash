#!/bin/bash
####################################################################################################################
#						BY FRANCISCO ASCUE						   #
#					email: francisco.ascue131@gmail.com					   #
####################################################################################################################

##CONSTANT
WD="/mnt/disco3/fascue/.docker"
GM="$WD/data/reads"
OD="$WD/results/mapped"
TRM="$WD/results/trimmed"

##EXECUTION

mkdir -p $TRM/quality

echo "Started at `date`"

for i in $(cat $GM/codigos.txt);do
	echo "fastqc -t 20 $TRM/${i}_R1_trimp.fastq.gz $TRM/${i}_R2_trim.fastq.gz -o $TRM/quality"
	fastqc -t 20 $TRM/${i}_R1_trimp.fastq.gz $TRM/${i}_R2_trim.fastq.gz -o $TRM/quality
done

echo "Finished at `date`"

#!/bin/bash
####################################################################################################################
#						BY FRANCISCO ASCUE						   #
#					email: francisco.ascue131@gmail.com					   #
####################################################################################################################

##CONSTANT
WD="/mnt/disco3/fascue/.docker"
GM="$WD/data/reads"
OD="$WD/results/quality"

##EXECUTION

echo "Started at `date`"

for i in $(cat $GM/codigos2.txt);do
	echo "fastqc -t 10 $GM/${i}_R1_001.fastq.gz $GM/${i}_R2_001.fastq.gz -o $OD"
	fastqc -t 10 $GM/${i}_R1_001.fastq.gz $GM/${i}_R2_001.fastq.gz -o $OD
done

echo "Finished at `date`"

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

#mkdir -p $TRM/jellyfish

echo "Started at `date`"

for i in $(cat $GM/codigos2.txt);do
	jellyfish count -m 31 -s 10G -t 30 -o $TRM/jellyfish/${i} -C -L 0 -U 1000 <(zcat $TRM/${i}_R1_trimp.fastq.gz) <(zcat $TRM/${i}_R2_trim.fastq.gz)
	jellyfish histo -o $TRM/jellyfish/${i}_0.histo ${TRM}/jellyfish/${i}_0
done

echo "Finished at `date`"

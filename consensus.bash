#!/bin/bash
####################################################################################################################
#						BY FRANCISCO ASCUE						   #
#					email: francisco.ascue131@gmail.com					   #
####################################################################################################################

##CONSTANT
WD="/mnt/disco3/fascue/.docker"
GM="$WD/data/reads"
OD="$WD/results/mapped"

##EXECUTION

echo "Started at `date`"

for i in $(cat $GM/codigos2.txt);do
	samtools mpileup -uf $WD/data/reference/NC_000962.3.fasta $OD/${i}.sorted.bam | bcftools call -c --ploidy 1 | vcfutils.pl vcf2fq > $OD/${i}.fq
	seqtk seq -aQ64 -q20 -n N $OD/${i}.fq > $OD/${i}.fasta
done

rm $OD/*.fq

echo "Finished at `date`"

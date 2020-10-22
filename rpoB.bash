#!/bin/bash
####################################################################################################################
#					FILTER RNA POLYMERASE SUBUNIT BETA					   #
#						BY FRANCISCO ASCUE						   #
#					email: francisco.ascue131@gmail.com					   #
####################################################################################################################

##CONSTANT

GM="/home/fascue/INS/data/genomes"
RES="/home/fascue/INS/results"

>>${RES}/multi_rpoB.fasta

##EXECUTION

echo "Started at `date`"

for i in $(cat $GM/codigos.txt);do
	lis=( `fgrep -i "CDS" $GM/${i}.gff | fgrep -i "RNA polymerase subunit beta" | cut -f 9 | awk -F ';' '{print $2}'| sed -e 's/Parent=//g'` )
	gffread -w $GM/transcrip.fa -g $GM/${i}.fna $GM/${i}.gff
	samtools faidx $GM/transcrip.fa
	samtools faidx $GM/transcrip.fa ${lis} >>${RES}/multi_rpoB.fasta
	rm $GM/*.fai $GM/transcrip.fa 
done

echo "Finished at `date`"

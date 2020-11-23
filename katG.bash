#!/bin/bash
####################################################################################################################
#						 FILTER KATG GENE					           #
#						BY FRANCISCO ASCUE						   #
#					email: francisco.ascue131@gmail.com					   #
####################################################################################################################

##CONSTANT

GM="/home/fascue/INS/data/genomes"
RES="/home/fascue/INS/results"

>>${RES}/multi_katG.fasta

##EXECUTION

echo "Started at `date`"

for i in $(cat $GM/codigos.txt);do
	lis=( `fgrep -i "CDS" $GM/${i}.gff | fgrep -i "katg" | cut -f 9 | awk -F ';' '{print $2}'| sed -e 's/Parent=//g'` )
	gffread -w $GM/transcrip.fa -g $GM/${i}.fna $GM/${i}.gff
	samtools faidx $GM/transcrip.fa
	samtools faidx $GM/transcrip.fa ${lis} >>${RES}/multi_katG.fasta
	sed -i "s/${lis}/${i}/g" $RES/multi_katG.fasta
	rm $GM/*.fai $GM/transcrip.fa 
done

echo "Finished at `date`"

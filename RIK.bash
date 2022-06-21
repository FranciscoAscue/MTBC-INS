#!/bin/bash

#####################################################################################################################
#					DATA ANALYSIS PROGRAM FOR MYCOBACTERIUM MTBC-MDR		    	    #
#						  BY: FRANCISCO ASCUE						    #
#					email: francisco.ascue131@gmail.com					    #
#####################################################################################################################


usage="$(basename "$0") -- Program for DNA-seq data processing (illumina sequencing) in GNU/Linux. 

program maintended at https://github.com/FranciscoAscue/MTBC-INS

usage: $(basename "$0") -g sequence.gff -f sequence.fasta
where:
    -h 			Show this help text
    -g 	sequence.gff	GFF file
    -f  sequence.fasta	FASTA file
    -t  metadata.txt	METADATA file"

## defaults

FASTA=""
GFF=""
TEXT=""

## getopts

while getopts ':h:g:f:t:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    g) GFF=$OPTARG
	;;
    f) FASTA=$OPTARG
       ;;
    t) TEXT=$OPTARG
	;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       	;;
  esac
done

## EXECUTION 

if [ "$FASTA" == "" ] && [ "$GFF" == "" ] 
then

	if [ "$TEXT" != "" ]; then

		if [ -s "$TEXT" ]; then
			
			touch multi_inhA.fasta
			touch multi_katG.fasta
			touch multi_rpoB.fasta

				for i in $(cat ${TEXT});do

					lisi=( `fgrep -i "CDS" ${i}.gff | fgrep -i "inhA" | cut -f 9 | awk -F ';' '{print $2}'| sed -e 's/Parent=//g'` )
					lisk=( `fgrep -i "CDS" ${i}.gff | fgrep -i "katg" | cut -f 9 | awk -F ';' '{print $2}'| sed -e 's/Parent=//g'` )
					lisr=( `fgrep -i "CDS" ${i}.gff | fgrep -i "RNA polymerase subunit beta" | cut -f 9 | awk -F ';' '{print $2}'| sed -e 's/Parent=//g'` )
					gffread -w transcrip.fa -g ${i}.fasta ${i}.gff
					samtools faidx transcrip.fa
					samtools faidx transcrip.fa ${lisi} >> multi_inhA.fasta
					samtools faidx transcrip.fa ${lisk} >> multi_katG.fasta
					samtools faidx transcrip.fa ${lisr} >> multi_rpoB.fasta
					sed -i "s/${lisi}/${i}/g" multi_inhA.fasta
					sed -i "s/${lisk}/${i}/g" multi_katG.fasta
					sed -i "s/${lisr}/${i}/g" multi_rpoB.fasta
					rm *.fai transcrip.fa
				
				done
		else
			echo "the metadata file is empty!!" >&2
		fi

	else
		echo "No metadata file register!!" >&2
	fi

elif [ "$FASTA" != "" ] && [ "$GFF" == "" ] ; then

	echo "No fasta file register !!" >&2

elif [ "$FASTA" == "" ] && [ "$GFF" != "" ]; then 

	echo "No gff file is register !!" >&2

elif [ "$FASTA" != "" ] && [ "$GFF" != "" ]; then 

	if [ -s $FASTA ]; then
		
		lisi=( `fgrep -i "CDS" $GFF | fgrep -i "inhA" | cut -f 9 | awk -F ';' '{print $2}'| sed -e 's/Parent=//g'` )
		lisk=( `fgrep -i "CDS" $GFF | fgrep -i "katg" | cut -f 9 | awk -F ';' '{print $2}'| sed -e 's/Parent=//g'` )
		lisr=( `fgrep -i "CDS" $GFF | fgrep -i "RNA polymerase subunit beta" | cut -f 9 | awk -F ';' '{print $2}'| sed -e 's/Parent=//g'` )
		gffread -w transcrip.fa -g ${FASTA}.fasta ${GFF}.gff
		samtools faidx transcrip.fa
		samtools faidx transcrip.fa ${lisi} > multi_inhA.fasta
		samtools faidx transcrip.fa ${lisk} > multi_katG.fasta
		samtools faidx transcrip.fa ${lisr} > multi_rpoB.fasta
		sed -i "s/${lisi}/${i}/g" multi_inhA.fasta
		sed -i "s/${lisk}/${i}/g" multi_katG.fasta
		sed -i "s/${lisr}/${i}/g" multi_rpoB.fasta
		
	fi
fi









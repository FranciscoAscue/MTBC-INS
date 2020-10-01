#!/bin/bash
####################################################################################################################
#														   #
#					MAPPING READS TO REFERENCE GENOME					   #
#						BY FRANCISCO ASCUE						   #
#					email: francisco.ascue131@gmail.com					   #
####################################################################################################################

###CONSTANS
#mkdir -p $directory/{data/{reads,reference},results,scripts/logs}
# basic structure of directory for results

WD="/$HOME/$directory"
REF="${WD}/data/reference/"
RES="${WD2}/results"
READS="${WD}/data/reads"
r1="${READS}/forward_paired.fq"
r2="${READS}/reverse_paired.fq"
U1="${READS}/forward_unpaired.fq"
U2="${READS}/reverse_unpaired.fq"
OD="${RES}/map2ref"

echo "mkdir -p ${OD}"
mkdir -p ${OD}

##DOWNLOAD_REFSEQ

## esearch -db nucletide -query "RefID" | efetch -db nucleotide -format fasta > $REF/RefID.fasta
### install before the entrez tools
###EXECUTION

echo "Started at `date`"

### MAPING TO REFERENCE 
### make a index from reference
mkdir -p $REF/index
echo "bowtie2-build --threads 3 ${REF}/RefID.fasta $REF/index/RefID"
bowtie2-build --threads 3 ${REF}/RefID.fasta $REF/index/RefID

### mapping reads to reference
echo "bowtie2 --end-to-end -I 0 -X 1000 -p 4 -x ${REF}/RefID.fasta -1 $r1 -2 $r2 -U $U1,$U2 -S ${OD}/Output.sam"
bowtie2 --end-to-end -I 0 -X 1000 -p 4 -x ${REF}/RefID.fasta -1 $r1 -2 $r2 -U $U1,$U2 -S ${OD}/Output.sam
### convert sam to bam
echo "samtools view -u@ 4 ${OD}/Output.sam | samtools sort -@ 4 -o ${OD}/Output.sorted.bam -"
samtools view -u@ 4 ${OD}/Output.sam | samtools sort -@ 4 -o ${OD}/Output.sorted.bam -
### index bam file
echo "samtools index ${OD}/Output.sorted.bam"
samtools index ${OD}/Output.sorted.bam



echo "Finished at `date"

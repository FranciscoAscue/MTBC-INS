#!/bin/bash
####################################################################################################################
#                                               BY FRANCISCO ASCUE                                                 #
#                                       email: francisco.ascue131@gmail.com                                        #
####################################################################################################################

###CONSTANS

WD="/mnt/disco3/fascue/.docker"
RES="${WD}/results"
READS="${WD}/data/reads"
OD="${RES}/trimmed"

### EXECUTION

echo "Started at `date`"

for i in $(cat $READS/codigos.txt);do
	java -jar /home/biotecanimal/Bioinformatics/Trimmomatic-0.39/trimmomatic-0.39.jar PE -phred33 -threads 5 $READS/${i}_R1_001.fastq.gz $READS/${i}_R2_001.fastq.gz $OD/${i}_R1_trimp.fastq.gz $OD/${i}_R1_trimunpaired.fastq.gz $OD/${i}_R2_trim.fastq.gz $OD/${i}_R2_trimunpaired.fastq.gz ILLUMINACLIP:NexteraPE-PE.fa:2:30:10 LEADING:20 TRAILING:20 SLIDINGWINDOW:4:20 MINLEN:50

done

echo "Finished at `date`"

#!/bin/bash
####################################################################################################################
#                                                                                                                  #
#                                       QUALITYCHEK SCRIPTS (FastQC/jellyfish)                                     #
#                                               BY FRANCISCO ASCUE                                                 #
#                                       email: francisco.ascue131@gmail.com                                        #
####################################################################################################################

name=$1

###CONSTANS

WD="/$HOME/$directory"
RES="${WD}/results"
READS="${WD}/data/reads"
r1="${READS}/forward.fq.gz"
r2="${READS}/reverse.fq.gz"
OD="${RES}/quality"

echo "mkdir -p $OD"
mkdir -p $OD

### EXECUTION

echo "Started at `date`"

echo "fastqc -t 4 forward.fq.gz reverse.fq.gz -o $OD"
fastqc -t 4 forward.fq.gz reverse.fq.gz -o $OD

mkdir -p $OD/jellyfish

echo "jellyfish count -m 31 -s 10G -t 3 -o ${OD}/jellyfish/${name} -C -L 0 -U 1000 <(zcat $r1) <(zcat $r2)"
jellyfish count -m 31 -s 10G -t 3 -o ${OD}/jellyfish/${name} -C -L 0 -U 1000 <(zcat $r1) <(zcat $r2)

jellyfish histo -o ${OD}/jellyfish/${name}.histo ${OD}/jellyfish/${name}_0
echo "jellyfish histo -o ${OD}/jellyfish/${name}.histo ${OD}/jellyfish/${name}_0"

echo "Finished at `date`"

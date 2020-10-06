#!/bin/bash
####################################################################################################################
#                                           ASSEMBLY GENOME WITH SPADES                                            #
#                                               BY FRANCISCO ASCUE                                                 #
#                                       email: francisco.ascue131@gmail.com                                        #
####################################################################################################################

###CONSTANS

WD="/$HOME/$directory"
RES="${WD}/results"
READS="${WD}/data/reads"
r1="${READS}/forward_paired.fq"
r2="${READS}/reverse_paired.fq"
OD="${RES}/assembly"

### EXECUTION

echo "Started at `date`"

mkdir -p ${OD}/$i/spades
echo "spades.py -1 ${r1} -2 ${r2} -m 4 -t 4 -k 41,51,61 -o ${OD}"
spades.py -1 ${r1} -2 ${r2} -m 4 -t 4 -k 41,51,61 -o ${OD}

echo "Finished at `date`"

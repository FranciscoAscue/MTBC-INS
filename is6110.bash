#!/bin/bash

##CONSTANT

GM="/home/usr/pjt/data/genomes/"

##EXECUTION

echo "Started at `date`"

awk '{print $2}' md5checksums.txt | sed -e "s/.fna.gz//g" > codigos.txt

for i in $(cat $GM/codigos.txt);do
	echo "$i `fgrep "pseudogene" $GM/${i}.gff | awk '{ if(($5 - $4)>=1300 && ($5 - $4)<=1500){print}}' | wc -l`"
done

cat IS6110.cvs | cut -f 2 | sort -k2,2n | sed -e "s/_genomic//g" > histoIS66110.csv

cat IS6110.cvs | cut -d " " -f 2 | sort -n | uniq -c > histoFreq.csv

echo "Finished at `date`"

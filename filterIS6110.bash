### filter IS6110

sudo apt install bedtools

## download fasta and gff file 

efetch -db nucleotide -id NC_000962.3 -format fasta > NC_000962.3.fasta
samtools faidx NC_000962.3.fasta

## download from NCBI gff3 file

### filter "mobile_genetic_element"
fastaFromBed -fi NC_000962.3.fasta -bed <(awk '$3=="mobile_genetic_element"' NC_000962.3.gff3) -fo NC_000962.3_mobile.fasta

## search IS6110 start and end positions 

fgrep "IS6110" NC_000962.3.gff3 | fgrep -v "repeat_region" | fgrep -v "sequence_feature" | cut -f 4,5

## search positions and match with names obtaein in NC_000962.3_mobile.fasta

fgrep "IS6110" NC_000962.3.gff3 | fgrep -v "repeat_region" | fgrep -v "sequence_feature" | awk '{print $4-1"-"$5}'

## save in a list 

list=( `fgrep "IS6110" NC_000962.3.gff3 | fgrep -v "repeat_region" | fgrep -v "sequence_feature" | awk '{print $4-1"-"$5}'` )

### create a file to save filter sequences

touch IS6110.fasta 

## index NC_000962.3_mobile.fasta 

samtools faidx NC_000962.3_mobile.fasta 

## make a loop to filter 
#### zsh loop
for i in $list
do
	samtools faidx NC_000962.3_mobile.fasta NC_000962.3:${i} >> IS6110.fasta
done

#### bash loop 

for i in ${list[@]};
do
	samtools faidx NC_000962.3_mobile.fasta NC_000962.3:${i} >> IS6110.fasta
done


### METODO CON SAMTOOLS

#### Buscar los IS6110 en GFF3

fgrep "IS6110" NC_000962.3.gff3 | fgrep -v "repeat_region" | fgrep -v "sequence_feature" | awk '{print $4-1"-"$5}'


#### genomas ensamblados con genoma de referencia

samtools faidx genoma_consenso.fasta
samtools faidx genoma_consenso.fasta "NC00XXXX:14000-30000" > is6110_codigo.fasta


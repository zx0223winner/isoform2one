#! /bin/bash
# ./isoform2one - this script takes the alternative splicing transcripts to the # primary one and return with the primary protein sequence.
# Author: Xi Zhang
# Jan 26th, 2022

if [ $# -lt 3 ]
	then
		echo "Usage: isoform2one.sh <NCBI_tabular> <NCBI_fasta> <output>
Example: ./isoform2one.sh proteins_4_380024.csv GCF_000001735.4_TAIR10.1_protein.faa primary_protein.fa"
	
else 
	sed 's/"//g' $1|sed 's/,/\t/g' > $1.tabular
	python3 tbl2trim.py $1.tabular $1.out
	awk -F'\t' '{print $9}' $1.out > $1.list
	awk '{print $1}' $2 > $2.fa
	python3 index_header_to_seq.py $2.fa $1.list $3
	rm $1.list
	rm $1.out
	rm $1.tabular
	rm $2.fa
	echo "No. of all alternative splicing transcripts"
	grep '>' $2|wc -l
	echo "No. of primary alternative splicing transcripts"
	grep '>' $3|wc -l
fi
exit 0 

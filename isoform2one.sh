#! /bin/bash
# ./isoform2one - this script takes the alternative splicing transcripts to the # primary one and return with the primary protein sequence.
# Author: Xi Zhang
# Jan 26th, 2022

if [ $# -lt 3 ]
	then
		echo "Usage: isoform2one.sh <NCBI_tabular> <NCBI_fasta> <output>
Example: ./isoform2one.sh Arabidopsis_thaliana.txt GCF_000001735.4_TAIR10.1_protein.faa out.fa"
	
else 
	python3 hsdatabase.py $1 $1.out
	awk -F'\t' '{print $9}' $1.out > $1.list
	awk '{print $1}' $2 > $2.fa
	python3 index_header_to_seq.py $2.fa $1.list $3
	grep '>' $2|wc
	grep '>' $3|wc
fi
exit 0 

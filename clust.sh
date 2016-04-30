#!/bin/sh

#../cdhit/cdhit-est-2d -i Bdistachyon_283_assembly_v2.0.fa -i2 lrr.fa
#make ../cdhit/cdhit-est-2d -i Bdistachyon_314_v3.1.transcript.fa -i2 lrr.fa -o lrr_brachy_novel -c 0.95 -n 10 -d 0 -M 16000 - T 8
#./usearch -usearch_global lrr.fa -db Bdistachyon_314_v3.1.transcript.fa -id 0.9 -blast6out lrr.b6  -strand plus -maxaccepts 8 -maxrejects 256


function runUsearch
{

	./usearch -cluster_fast Bdistachyon_314_v3.1.transcript.fa -id 0.9 -centroids nr.fasta -uc clusters.uc

}

function createBlastnDB
{
	makeblastdb -in Bdistachyon_314_v3.1.transcript.fa -dbtype nucl  -parse_seqids -o lrr.db	

}
~
function Blastseq
{

	blastn -db lrr.db -query lrr.fa -outfmt 6 -out blastalllrr.out

}~
~
function createFamilies
{
	 silix  lrr.fa blastalllrr.out -f FAM > seq.fnodes
}~
~
~
~
~
~
~
~
~
~
~
~
~


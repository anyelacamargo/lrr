#!/bin/sh

#../cdhit/cdhit-est-2d -i Bdistachyon_283_assembly_v2.0.fa -i2 lrr.fa
#make ../cdhit/cdhit-est-2d -i Bdistachyon_314_v3.1.transcript.fa -i2 lrr.fa -o lrr_brachy_novel -c 0.95 -n 10 -d 0 -M 16000 - T 8


runUsearch()
{
 	echo 'none'
	#./usearch -cluster_fast Bdistachyon_314_v3.1.transcript.fa -id 0.9 -centroids nr.fasta -uc clusters.uc
	./usearch -usearch_global lrrv1.fa -db Bdistachyon_314_v3.1.transcript.fa -id 0.9 -blast6out lrr.b6  -strand plus -maxaccepts 8 -maxrejects 256

}

createBlastnDB()
{
	makeblastdb -in Bdistachyon_314_v3.1.transcript.fa -dbtype nucl  -parse_seqids -out lrr.db	

}

Blastseq()
{
	echo 'blastseqyy'
	blastn -db lrr.db -query lrrv1.fa -outfmt 6 -out blastalllrr.out -r 2 -m 8

}

createFamilies()
{
	echo 'silix'
	silix  lrrv1.fa blastalllrr.out -f FAM  > seq.fnodes
}

pullGenome()
{
	cd genome_cds
 	#genomes={"ABR2","ABR3","ABR4"}
#"ABR5","ABR6_r","ABR7","ABR8","ABR9_r","Adi-2","Adi-10","Adi-12","Arn1","Bd1-1","Bd2-3","Bd3-1_r",
#"Bd18-1","Bd21-3_r","Bd21Control","Bd21Ref","Bd29-1","Bd30-1","BdTR1i","BdTR2B","BdTR2G","BdTR3C","BdTR5I","BdTR7a","BdTR8i","BdTR9K","BdTR10C","BdTR11A","BdTR11G",
#"BdTR11I","BdTR12c","BdTR13C","BdTR13a","Bis-1","Foz1","Gaz-8","Jer1","Kah-1","Kah-5","Koz-1","Koz-3","Luc1","Mig3","Mon3","Mur1",
#"Per1","RON2","S8iiC","Sig2","Tek-2","Tek-4")
 	for i in ABR2 ABR3 ABR4 ABR5 ABR6_r ABR7 ABR8 ABR9_r Adi-2 Adi-10 Adi-12 Arn1 Bd1-1 Bd2-3 Bd3-1_r Bd18-1 Bd21-3_r Bd21Control Bd21Ref Bd29-1 Bd30-1 BdTR1i BdTR2B BdTR2G BdTR3C BdTR5I BdTR7a BdTR8i Bdr9K BdTR10C BdTR11A BdTR11G BdTR11I BdTR12c BdTR13C BdTR13a Bis-1 Foz1 Gaz-8 Jer1 Kah-1 Kah-5 Koz-1 Koz-3 Luc1 Mig3 Mon3 Mur1 Per1 RON2 S8iiC Sig2 Tek-2 Tek-4
#"${genomes[@]}"
        do
                echo $i
                file_name=`printf 'Bdistachyonv1.%s.1.primaryTrs.cds.fa' ${i}`
		#Bdistachyonv1.$i.1.primaryTrs.fa
                #echo $file_name
                #grep ${i} map.wheat.txt > $file_name
                #echo -e "marker\tchromosome\tbp" | cat - $file_name > table_with_header
                #cp table_with_header $file_name
		echo $file_name
	 	wget --user distachyon --password genome50 wget http://portal.nersc.gov/dna/plant/B_distachyon/distachyon_50/genomes/$i/DATA/$file_name
        done
}

pullGenomeV2()
{
        cd genome_cds
                file_name='Bdistachyonv2.0.Bd21Ref.1.primaryTrs.cds.fa'
                #Bdistachyonv1.$i.1.primaryTrs.fa
                #echo $file_name
                #grep ${i} map.wheat.txt > $file_name
                #echo -e "marker\tchromosome\tbp" | cat - $file_name > table_with_header
                #cp table_with_header $file_name
                echo $file_name
                wget --user distachyon --password genome50 wget http://portal.nersc.gov/dna/plant/B_distachyon/distachyon_50/genomes/Bd21Ref/DATA/$file_name
}

runMugsy()
{
        cd /home/avc/devel/mugsy_x86-64-v1r2.3
        export MUGSY_INSTALL=$HOME/devel/mugsy_x86-64-v1r2.3
	list_file_name=""
        for i in ABR2 ABR3 ABR4 ABR5 ABR6_r ABR7 ABR8 ABR9_r Adi-2 Adi-10 Adi-12 Arn1 Bd1-1 Bd2-3 Bd3-1_r Bd18-1 Bd21-3_r Bd21Control Bd29-1 Bd30-1 BdTR1i BdTR2B BdTR2G BdTR3C BdTR5I BdTR7a BdTR8i BdTR10C BdTR11A BdTR11G BdTR11I BdTR12c BdTR13C BdTR13a Bis-1 Foz1 Gaz-8 Jer1 Kah-1 Kah-5 Koz-1 Koz-3 Luc1 Mig3 Mon3 Mur1 Per1 RON2 S8iiC Sig2 Tek-2 Tek-4
        do
                file_name=`printf 'Bdistachyonv1.%s.1.primaryTrs.cds.fa' ${i}`
		newname=`printf 'Bdistachyonv1%s1primaryTrscds.fa' ${i}`
		cp $file_name $newname
                list_file_name=`printf '%s %s ' ${list_file_name} ${newname} `
        done
        file_name_ref='Bdistachyonv2.0.Bd21Ref.1.primaryTrs.cds.fa'
        newname='Bdistachyonv2Bd21Ref1primaryTrscds.fa'
	cp $file_name_ref $newname
        list_file_name=`printf '%s %s ' ${list_file_name} ${newname} `
        echo $list_file_name
	./mugsy --directory /home/avc/devel/ --prefix brachy  $list_file_name
}



createDBSwiss()
{
	#mv uniprot_sprot.fasta
	#mkdir -p db/blast/
	makeblastdb -in uniprot_sprot.fasta -dbtype prot -out db/blast/uniprot_sprot -hash_index
}

blastSwiss()
{
	#blastp -query lrrprotv1.fa -db db/blast/uniprot_sprot  -outfmt 10 -out blastlrrprot2.out -num_descriptions  5 
	blastp -query lrrprotv1.fa -db db/blast/uniprot_sprot  -outfmt "7  qacc sacc evalue qstart qend sstart send " -out blastlrrprot3.out
	#blastp -query lrrprotv1.fa -db db/blast/uniprot_sprot  -outfmt 1 -out blastlrrprot.out
}
#createBlastnDB
#Blastseq
#createFamilies
#runUsearch
#pullGenome
#createDBSwiss
#blastSwiss
#pullGenomeV2
runMugsy

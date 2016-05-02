#!/bin/sh
#$ -S /bin/bash
#$ -v PATH=/home/oasis/data/webcomp/RAMMCAP-ann/bin:/usr/local/bin:/usr/bin:/bin
#$ -v LD_LIBRARY_PATH=/home/oasis/data/webcomp/RAMMCAP-ann/gnuplot-install/lib
#$ -v PERL5LIB=/home/hying/programs/Perl_Lib
#$ -e /home/oasis/data/webcomp/web-session/1461073981/1461073981.err
#$ -o /home/oasis/data/webcomp/web-session/1461073981/1461073981.out
#$ -pe orte 4
cd /home/oasis/data/webcomp/web-session/1461073981

faa_stat.pl 1461073981.fas.db1
faa_stat.pl 1461073981.fas.db2
/home/oasis/data/NGS-ann-project/apps/cd-hit/cd-hit-est-2d -i 1461073981.fas.db1 -i2 1461073981.fas.db2 -o 1461073981.fas.db2novel -c 0.9 -n 8  -r 0 -G 1 -g 1 -b 20 -s 0.0 -aL 0.0 -aS 0.0 -s2 1.0 -S2 0 -T 4 -M 16000
/home/oasis/data/NGS-ann-project/apps/cd-hit/clstr_sort_by.pl no < 1461073981.fas.db2novel.clstr > 1461073981.fas.db2novel.clstr.sorted
clstr_list.pl 1461073981.fas.db2novel.clstr 1461073981.clstr.dump
clstr_list_sort.pl 1461073981.clstr.dump 1461073981.clstr_no.dump
clstr_list_sort.pl 1461073981.clstr.dump 1461073981.clstr_len.dump len
clstr_list_sort.pl 1461073981.clstr.dump 1461073981.clstr_des.dump des
gnuplot1.pl < 1461073981.fas.db2novel.clstr > 1461073981.fas.db2novel.clstr.1; gnuplot2.pl 1461073981.fas.db2novel.clstr.1 1461073981.fas.db2novel.clstr.1.png
tar -zcf 1461073981.result.tar.gz * --exclude=*.dump --exclude=*.env
echo hello > 1461073981.ok

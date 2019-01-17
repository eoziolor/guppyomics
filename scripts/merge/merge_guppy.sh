#!/bin/bash -l

#SBATCH -J bam_merge
#SBATCH -e bam_merge-%j.o
#SBATCH -o bam_merge-%j.o
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 02-00:00
#SBATCH --mem=60000
#SBATCH -p high

#files
my_bam=/home/eoziolor/program/bamtools/build/src/toolkit/bamtools
my_merge=/home/eoziolor/guppy/data/align/allmerge.bam
my_list=/home/eoziolor/guppy/data/list/bam_list.txt

#cat $my_list

#code
$my_bam merge -list $my_list -out $my_merge

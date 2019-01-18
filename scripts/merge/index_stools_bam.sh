#!/bin/bash -l

#SBATCH -J bam_index_stools
#SBATCH -e bam_index_stools-%j.o
#SBATCH -o bam_index_stools-%j.o
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 01-00:00
#SBATCH --mem=60000
#SBATCH -p high

my_stools=/home/eoziolor/program/samtools-1.9/samtools 
my_bam=/home/eoziolor/guppy/data/align/allmerge_stools.bam

$my_stools index -@16 $my_bam

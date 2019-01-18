#!/bin/bash -l

#SBATCH -J stools_merge
#SBATCH -e stools_merge-%j.o
#SBATCH -o stools_merge-%j.o
#SBATCH -N 1
#SBATCH -n 23
#SBATCH -t 02-00:00
#SBATCH --mem=60000
#SBATCH -p high
#SBATCH --no-requeue

#files
my_sam=/home/eoziolor/program/samtools-1.9/bin/samtools
my_merge=/home/eoziolor/guppy/data/align/allmerge_stools.bam
my_dir=/home/eoziolor/guppy/data/align/

#cat $my_list

#code
$my_sam merge $my_merge $my_dir/CSU*.bam

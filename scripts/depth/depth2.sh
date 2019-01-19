#!/bin/bash -l

#SBATCH -J bamdepth
#SBATCH -e bamdepth-%j.o
#SBATCH -o bamdepth-%j.o
#SBATCH -N 1
#SBATCH -n 23
#SBATCH -t 06-00:00
#SBATCH --mem=60000
#SBATCH -p med
#SBATCH --no-requeue

module load bio3

#files
my_list=/home/eoziolor/guppy/data/list/bam_list.txt
my_stools=/home/eoziolor/program/samtools-1.9/bin/samtools
my_out=/home/eoziolor/guppy/data/depth/coverage_allbases2.txt.gz
my_in=/home/eoziolor/guppy/data/align/allmerge_stools.bam

#code
$my_stools depth -d 10000 $my_in | gzip > $my_out

#!/bin/bash -l

#SBATCH -J bamdepth
#SBATCH -e bamdepth-%j.o
#SBATCH -o bamdepth-%j.o
#SBATCH -N 1
#SBATCH -n 23
#SBATCH -t 06-00:00
#SBATCH --mem=60000
#SBATCH -p high
#SBATCH --no-requeue

module load bio3

#files
my_list=/home/eoziolor/guppy/data/list/bam_list.txt
#my_stools=/home/eoziolor/program/samtools-1.9/bin/samtools
my_out=/home/eoziolor/guppy/data/depth/coverage_allbases.txt.gz

#code
samtools depth \
-d 10000 \
-f $my_list | gzip > $my_out

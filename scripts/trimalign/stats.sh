#!/bin/bash -l

#SBATCH -J flagstat
#SBATCH -e flagstat-%j.o
#SBATCH -o flagstat-%j.o
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 01-00:00
#SBATCH --mem=60000
#SBATCH -p high

#files
my_dir=/home/eoziolor/guppy/data/align
my_sam=/home/eoziolor/program/samtools-1.9/bin/samtools
my_out=/home/eoziolor/guppy/data/align/stats.txt

#code
for file in $my_dir/*.bam; do
	$my_sam flagstat $file >> $my_out
done

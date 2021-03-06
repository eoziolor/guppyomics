#!/bin/bash -l

#SBATCH -J highcov
#SBATCH -e highcov-%j.o
#SBATCH -o highcov-%j.o
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -t 03-00:00
#SBATCH --mem=60000
#SBATCH -p high

module load bio3
source ~/.bashrc

#files
my_cov=/home/eoziolor/guppy/data/depth/coverage_allbases.txt.gz
my_out=/home/eoziolor/guppy/data/depth/hicov.bed

zcat $my_cov | \
awk '{OFS="\t"}{s=$2-1}{print $1,s,$2,$3}' | \
awk '{OFS="\t"}{if($4>1500){print}}' | \
bedtools merge -i - -d 10 -c 4 -o count > $my_out

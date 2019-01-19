#!/bin/bash -l

#SBATCH -J keepsites
#SBATCH -e keepsites-%j.o
#SBATCH -o keepsites-%j.o
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -t 03-00:00
#SBATCH --mem=60000
#SBATCH -p high

module load bio3
source ~/.bashrc

my_cov=/home/eoziolor/guppy/data/depth/coverage_allbases.txt.gz
my_out=/home/eoziolor/guppy/data/angsd/keepsites.bed

zcat $my_cov | \
awk '{OFS="\t"}{s=$2-1}{print $1,s,$2,$3}' | \
awk '{OFS="\t"}{if($4<1500){print}}' | \
bedtools merge -i - -d 10 > $my_out

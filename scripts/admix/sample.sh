#!/bin/bash -l

#SBATCH -J vcftobed
#SBATCH -e vcftobed-%j.o
#SBATCH -o vcftobed-%j.o
#SBATCH -t 06-00:00
#SBATCH -n 8
#SBATCH --mem=16G
#SBATCH -p high
#SBATCH --no-requeue

#programs and files
my_plink=/home/eoziolor/program/plink/plink
my_vcf=/home/eoziolor/guppy/data/varcall/sample.vcf.bgz
my_tabix=/home/eoziolor/program/htslib/tabix
my_out=/home/eoziolor/guppy/data/admixture/sample

$my_plink \
-vcf $my_vcf \
--allow-extra-chr \
--make-bed \
-out $my_out

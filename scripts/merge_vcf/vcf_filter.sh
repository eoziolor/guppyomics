#!/bin/bash -l

#SBATCH -J filter_vcf
#SBATCH -e filter_vcf-%j.o
#SBATCH -o filter_vcf-%j.o
#SBATCH -t 06-00:00
#SBATCH -n 8
#SBATCH --mem=16G
#SBATCH -p high
#SBATCH --no-requeue

my_vtools=/home/eoziolor/program/vcftools/bin/vcftools
my_prevcf=/home/eoziolor/guppy/data/varcall/ppicta_merged.vcf.bgz
my_dir=/home/eoziolor/guppy/data/varcall/
my_out=filtered_ppicta
my_bgz=/home/eoziolor/program/htslib/bgzip

cd $my_dir

$my_vtools \
--gzvcf $my_prevcf \
--recode \
--stdout \
--maf 0.01 \
--min-alleles 2 \
--max-alleles 2 \
--minQ 30 \
--max-missing 0.5 |\
$my_bgz > $my_dir/$my_out.vcf.bgz

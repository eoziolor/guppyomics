#!/bin/bash -l

#SBATCH -J merge_vcf
#SBATCH -e merge_vcf-%j.o
#SBATCH -o merge_vcf-%j.o
#SBATCH -t 06-00:00
#SBATCH -n 8
#SBATCH --mem=16G
#SBATCH -p high
#SBATCH --no-requeue


my_dir=/home/eoziolor/guppy/data/varcall
my_bgz=/home/eoziolor/program/htslib/bgzip

cd $my_dir/scaffold

zcat NC_024331.1_1.vcf.bgz | grep "#" | $my_bgz > $my_dir/ppicta_merged.vcf.bgz

for i in $(ls -1 | sort --version-sort | head -n 1000); do
zcat $i | grep -v "#" | $my_bgz >> $my_dir/ppicta_merged.vcf.bgz
done

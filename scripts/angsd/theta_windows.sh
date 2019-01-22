#!/bin/bash -l

#SBATCH -J window_thetas
#SBATCH --array=3
#SBATCH -e window_thetas%A-%a.o
#SBATCH -o window_thetas%A-%a.o
#SBATCH -t 06-00:00
#SBATCH -n 8
#SBATCH --mem=16G
#SBATCH -p high
#SBATCH --no-requeue

pops=CAP_F\ CAP_H\ CAP_L\ CAP_S\ CAR_F\ CAR_H\ CAR_L\ CAR_S\ CUN_F\ CUN_L\ CUN_S

one=$(echo $pops | cut -f $SLURM_ARRAY_TASK_ID -d ' ')

#programs and files

my_bedtools=/home/eoziolor/program/bedtools2/bin/bedtools
thetas=/home/eoziolor/guppy/data/angsd/$one\_readable_theta.gz
window=/home/eoziolor/guppy/data/window/50kb.10kb.bed
my_genome=/home/eoziolor/guppy/data/genome/preticulata.fna.fai
outdir=/home/eoziolor/guppy/data/angsd
outfile=$one\_neut_50kb.bed

zcat $thetas | \
egrep -v "^#" | \
awk '{OFS="\t"}{w=exp($3)}{pi=exp($4)}{s=$2-1}{print $1,s,$2,w,pi}' | \
$my_bedtools map \
-a $window \
-b stdin \
-g <(cut -f 1-2 $my_genome) \
-c 4,4,5,5 \
-o sum,count,sum,count > $outdir/$outfile

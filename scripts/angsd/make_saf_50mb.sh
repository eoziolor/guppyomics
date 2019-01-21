#!/bin/bash -l

#SBATCH -J saf_50mb
#SBATCH --array=6
#SBATCH -e saf_50mb%A-%a.o
#SBATCH -o saf_50mb%A-%a.o
#SBATCH -t 06-00:00
#SBATCH -n 8
#SBATCH --mem=16G
#SBATCH -p high
#SBATCH --no-requeue

pops=CAP_F\ CAP_H\ CAP_L\ CAP_S\ CAR_F\ CAR_H\ CAR_L\ CAR_S\ CUN_F\ CUN_L\ CUN_S

one=$(echo $pops | cut -f $SLURM_ARRAY_TASK_ID -d ' ')

#files
list=/home/eoziolor/guppy/data/list/pops/$one\.txt
genome=/home/eoziolor/guppy/data/genome/preticulata.fna
keep=/home/eoziolor/guppy/data/angsd/keep50Mb.file
outfile=/home/eoziolor/guppy/data/angsd/$one\_small
my_angsd=/home/eoziolor/program/angsd/angsd

$my_angsd \
-bam $list \
-doSaf 1 \
-fold 1 \
-anc $genome \
-GL 2 \
-minMapQ 30 \
-minQ 20 \
-minind 10 \
-sites $keep \
-out $outfile \
-nThreads 8

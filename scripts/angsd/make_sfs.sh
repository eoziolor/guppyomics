#!/bin/bash -l

#SBATCH -J sfs
#SBATCH --array=6
#SBATCH -e sfs%A-%a.o
#SBATCH -o sfs%A-%a.o
#SBATCH -t 06-00:00
#SBATCH -n 8
#SBATCH --mem=16G
#SBATCH -p high
#SBATCH --no-requeue

pops=CAP_F\ CAP_H\ CAP_L\ CAP_S\ CAR_F\ CAR_H\ CAR_L\ CAR_S\ CUN_F\ CUN_L\ CUN_S

one=$(echo $pops | cut -f $SLURM_ARRAY_TASK_ID -d ' ')


#program and file
my_sfs=/home/eoziolor/program/angsd/misc/realSFS
in_saf=/home/eoziolor/guppy/data/angsd/$one\_small.saf.idx
outdir=/home/eoziolor/guppy/data/angsd
out_sfs=$one\.sfs

#code

$my_sfs $in_saf -maxIter 100 -P 8 -nSites 50000000 > $outdir/$out_sfs

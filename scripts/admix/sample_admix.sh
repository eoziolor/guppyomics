#!/bin/bash -l

#SBATCH -J kdetermine
#SBATCH --array=1-11
#SBATCH -e kdetermine_%A-%a.o
#SBATCH -o kdetermine_%A-%a.o
#SBATCH -t 06-00:00
#SBATCH -n 16
#SBATCH --mem=32G
#SBATCH -p high
#SBATCH --no-requeue

#programs
admix=/home/eoziolor/program/admixture/admixture
sample=/home/eoziolor/guppy/data/admixture/sample.bed
out=/home/eoziolor/guppy/data/admixture

$admix --cv -j16 $sample $SLURM_ARRAY_TASK_ID | tee $out/log${SLURM_ARRAY_TASK_ID}.out

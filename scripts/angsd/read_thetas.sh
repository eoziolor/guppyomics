#!/bin/bash -l

#SBATCH -J convert_thetas
#SBATCH --array=3
#SBATCH -e convert_thetas%A-%a.o
#SBATCH -o convert_thetas%A-%a.o
#SBATCH -t 06-00:00
#SBATCH -n 8
#SBATCH --mem=16G
#SBATCH -p high
#SBATCH --no-requeue

pops=CAP_F\ CAP_H\ CAP_L\ CAP_S\ CAR_F\ CAR_H\ CAR_L\ CAR_S\ CUN_F\ CUN_L\ CUN_S

one=$(echo $pops | cut -f $SLURM_ARRAY_TASK_ID -d ' ')


#program/file
my_stat=/home/eoziolor/program/angsd/misc/thetaStat
file=/home/eoziolor/guppy/data/angsd/$one\_theta.thetas.idx
out=/home/eoziolor/guppy/data/angsd/$one\_readable_theta.gz

$my_stat print $file | gzip > $out

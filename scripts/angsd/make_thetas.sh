#!/bin/bash -l

#SBATCH -J thetas
#SBATCH --array=3,6,9
#SBATCH -e thetas%A-%a.o
#SBATCH -o thetas%A-%a.o
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
keep=/home/eoziolor/guppy/data/angsd/keepsites.file
outfile=/home/eoziolor/guppy/data/angsd/$one\_theta
my_angsd=/home/eoziolor/program/angsd/angsd
my_sfs=/home/eoziolor/guppy/data/angsd/$one\.sfs

#Code
$my_angsd \
-bam $list \
-out $outfile \
-doThetas 1 \
-fold 1 \
-doSaf 1 \
-pest  $my_sfs \
-anc $genome \
-sites $keep \
-minMapQ 30 \
-minQ 20 \
-minind 10 \
-GL 2

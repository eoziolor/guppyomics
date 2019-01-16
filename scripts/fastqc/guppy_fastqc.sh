#!/bin/bash

#SBATCH -J gp_fastqc
#SBATCH --array=1-384
#SBATCH -e gp_fastqc%A-%a.o
#SBATCH -o gp_fastqc%A-%a.o
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -t 1-00:00
#SBATCH --mem=16000
#SBATCH --no-requeue
#SBASTCH -p med

module load bio3
fastqc --version

#folder
my_dir=/home/eoziolor/guppy/data/raw/renamed
my_out=/home/eoziolor/guppy/data/fastqc/
cd $my_dir

if (($SLURM_ARRAY_TASK_ID < 10))
then
	num=00$(echo $SLURM_ARRAY_TASK_ID)
elif (($SLURM_ARRAY_TASK_ID < 100))
then
	num=0$(echo $SLURM_ARRAY_TASK_ID)
else
	num=$(echo $SLURM_ARRAY_TASK_ID)
fi

echo $num

#code
cd $my_dir
fastqc -t 8 AWCSU*_$num\_*\.fq.gz \
-o $my_out

#!/bin/bash

#SBATCH -J post_fastqc
#SBATCH --array=52-54
#SBATCH -e post_fastqc%A-%a.o
#SBATCH -o post_fastqc%A-%a.o
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -t 1-00:00
#SBATCH --mem=16000
#SBATCH --no-requeue
#SBASTCH -p med

module load bio3
fastqc --version

#folder
my_dir=/home/eoziolor/guppy/data/trim
my_out=/home/eoziolor/guppy/data/fastqc/post
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
fastqc -t 8 AWCSU*\.$num\.fq.gz \
-o $my_out

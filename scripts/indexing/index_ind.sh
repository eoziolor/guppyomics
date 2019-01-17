#!/bin/bash -l

#SBATCH -J bam_index
#SBATCH --array=1-383
#SBATCH -e bam_index-%A-%a.o
#SBATCH -o bam_index-%A-%a.o
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 01-00:00
#SBATCH --mem=60000
#SBATCH -p high

my_stools=/home/eoziolor/program/samtools-1.9/samtools 
my_list=/home/eoziolor/guppy/data/list/bam_list.txt

if (($SLURM_ARRAY_TASK_ID < 10))
then
	num=00$(echo $SLURM_ARRAY_TASK_ID)
elif (($SLURM_ARRAY_TASK_ID < 100))
then
	num=0$(echo $SLURM_ARRAY_TASK_ID)
else
	num=$(echo $SLURM_ARRAY_TASK_ID)
fi

my_sample=$(cat $my_list | grep $num)

echo $num
echo $my_sample

$my_stools index -@ 16 $my_sample

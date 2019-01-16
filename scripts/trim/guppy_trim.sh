#!/bin/bash -l

#SBATCH -J trim
#SBATCH --array=110-111
#SBATCH -e trim%A-%a.o
#SBATCH -o trim%A-%a.o
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -t 01-00:00
#SBATCH --mem=16000

module load bio3

#Assigning number to be able to get into each folder separately

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

#Directory and file assignment for each file and program
my_dir=/home/eoziolor/guppy/data/raw/renamed
fq1=$my_dir/AWCSU*$num*1.fq.gz
fq2=$my_dir/AWCSU*$num*2.fq.gz
my_bwa=/home/eoziolor/program/bwa-0.7.17/bwa
my_sbl=/home/eoziolor/program/samblaster/samblaster
my_sam=/home/eoziolor/program/samtools-1.9/samtools
my_out=/home/eoziolor/guppy/data/trim/
my_gen=/home/eoziolor/guppy/data/genome/preticulata.fna


#Code
paste <(zcat $fq1 | paste - - - -) \
      <(zcat $fq2 | paste - - - -) |\
tr '\t' '\n' |\
cutadapt -j 8 --interleaved -a CTGTCTCTTATA -A CTGTCTCTTATA -u 10 -U 10 -q 30 --trim-n --minimum-length 36 - | gzip > $my_out/AWCSU.$num.fq.gz

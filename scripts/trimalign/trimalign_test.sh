#!/bin/bash -l

#SBATCH -J guppy_trimalign
#SBATCH --array=137
#SBATCH -e guppy_trimalign%A-%a.o
#SBATCH -o guppy_trimalign%A-%a.o
#SBATCH -N 1
#SBATCH -n 23
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

#Assigning new sample numbers with same amount of digits
if (($SLURM_ARRAY_TASK_ID < 10))
then
        sample=00$(echo $SLURM_ARRAY_TASK_ID)
elif (($SLURM_ARRAY_TASK_ID < 100))
then
        sample=0$(echo $SLURM_ARRAY_TASK_ID)
else 
        sample=$(echo $SLURM_ARRAY_TASK_ID)
fi


#Directory and file assignment for each file and program
my_dir=/home/eoziolor/guppy/data/raw/renamed
fq1=$my_dir/AWCSU*\_$num\_1.fq.gz
fq2=$my_dir/AWCSU*\_$num\_2.fq.gz
my_bwa=/home/eoziolor/program/bwa-0.7.17/bwa
my_sbl=/home/eoziolor/program/samblaster/samblaster
my_sam=/home/eoziolor/program/samtools-1.9/samtools
my_out=/home/eoziolor/guppy/data/
my_gen=/home/eoziolor/guppy/data/genome/preticulata.fna
my_list=/home/eoziolor/guppy/data/list/zeros_pops.txt

#others
pop=$(cat $my_list | grep $sample | cut -f 2)
rg=$(echo \@RG\\tID:$sample\\tPL:Illumina\\tPU:x\\tLB:combined\\tSM:$sample.$pop)
outroot=CSU\_$sample\_$pop

#Code
paste <(zcat $fq1 | paste - - - -) \
      <(zcat $fq2 | paste - - - -) |\
tr '\t' '\n' |\
cutadapt -j 23 --interleaved -a CTGTCTCTTATA -A CTGTCTCTTATA -u 10 -U 10 -q 30 --trim-n --minimum-length 36 - |\
$my_bwa mem $my_gen -p -R $rg -t 23 - |\
$my_sam view -S -h -u - | \
$my_sam sort -T $my_out/$outroot > $my_out/$outroot\.bam

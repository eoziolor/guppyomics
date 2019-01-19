#!/bin/bash -l

#SBATCH -J bigbayes
#SBATCH --array=1-69
#SBATCH -e bigbayes%A-%a.o
#SBATCH -o bigbayes%A-%a.o
#SBATCH -t 06-00:00
#SBATCH -n 8
#SBATCH --mem=16G
#SBATCH -p med
#SBATCH --no-requeue

cd /home/eoziolor/phpopg/data/varcall/scaffold/

#files
genome=/home/eoziolor/guppy/data/genome/preticulata.fna
my_fai=/home/eoziolor/guppy/data/genome/preticulata.fna.fai
mergebam=/home/eoziolor/guppy/data/align/allmerge.bam
popsfile=/home/eoziolor/guppy/data/list/zeros_pops.tsv
hicov=/home/eoziolor/guppy/data/depth/hicov.bed
reg_file=/home/eoziolor/phgenome/data/genome/preticulata.fna.genome

#programs
my_freebayes=/home/eoziolor/program/freebayes/bin/freebayes
my_samtools=/home/eoziolor/program/samtools-1.9/samtools
my_bgz=/home/eoziolor/program/htslib/bgzip
my_bedtools=/home/eoziolor/program/bedtools2/bin/bedtools

#selecting scaffold to investigate from the genome file

crap=$(echo $SLURM_ARRAY_TASK_ID)
line=$(echo $(((crap+19)/20)))
scaf=$(sed "$line q;d" $reg_file | cut -f1)
end=$(sed "$line q;d" $reg_file | cut -f2)

#chunking a region to investigate

short=$((end/20))
iter=$((crap-(line-1))*20)))
chunk=$((short*iter))
portion=$((1+chunk-short))-$chunk
region=$scaf:$portion

echo "This is array number" $crap 
echo "I am picking line" $line "from genome file"
echo "It is iteration" $iter "for scaffold" $scaf
echo "The chunk size I am picking is" $short "bases long and this is ending at" $chunk
echo "The region this defines is" $portion "from scaffold with length" $end
echo "\n\n"
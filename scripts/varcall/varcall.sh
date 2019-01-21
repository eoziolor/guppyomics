#!/bin/bash -l

#SBATCH -J bigbayes
#SBATCH --array=1482,1462,1365,1348,1322,1305,1285,1171
#SBATCH -e bigbayes%A-%a.o
#SBATCH -o bigbayes%A-%a.o
#SBATCH -t 06-00:00
#SBATCH -n 8
#SBATCH --mem=16G
#SBATCH -p med
#SBATCH --no-requeue


cd /home/eoziolor/guppy/data/varcall/scaffold/

#files
genome=/home/eoziolor/guppy/data/genome/preticulata.fna
my_fai=/home/eoziolor/guppy/data/genome/preticulata.fna.fai
mergebam=/home/eoziolor/guppy/data/align/allmerge_stools.bam
popsfile=/home/eoziolor/guppy/data/list/zeros_pops.txt
hicov=/home/eoziolor/guppy/data/depth/hicov.bed
reg_file=/home/eoziolor/guppy/data/genome/preticulata.fna.genome

#programs
my_freebayes=/home/eoziolor/program/freebayes/bin/freebayes
my_samtools=/home/eoziolor/program/samtools-1.9/samtools
my_bgz=/home/eoziolor/program/htslib/bgzip
my_bedtools=/home/eoziolor/program/bedtools2/bin/bedtools

#selecting scaffold to investigate from the genome file

crap=$(echo $SLURM_ARRAY_TASK_ID)
line=$(echo $(((crap+99)/100)))
scaf=$(sed "$line q;d" $reg_file | cut -f1)
end=$(sed "$line q;d" $reg_file | cut -f2)

#chunking a region to investigate

short=$((end/100))
iter=$((crap-((line-1)*100)))
chunk=$((short*iter))
if [ "$iter" -lt "100" ]; then
	portion=$((1+chunk-short))-$chunk
else
	portion=$((1+chunk-short))-$end
fi
region=$scaf:$portion

echo "This is array number" $crap 
echo "I am picking line" $line "from genome file"
echo "It is iteration" $iter "for scaffold" $scaf
echo "The chunk size I am picking is" $short "bases long and this is ending at" $chunk
echo "The region this defines is" $portion "from scaffold with length" $end
echo "\n\n"


#directories and files

outdir=/home/eoziolor/guppy/data/varcall/scaffold
outfile=$scaf\_$iter\.vcf.bgz

$my_samtools view -q 30 -f 2 -h -b  $mergebam $region | \
$my_bedtools intersect -v -a stdin -b $hicov | \
$my_freebayes -f $genome --populations $popsfile --stdin | \
$my_bgz > $outdir/$outfile

echo "The file created is" $outfile
echo "I place it in directory" $outdir

#!/bin/bash -l

#SBATCH -J wcfst
#SBATCH --array=1-55
#SBATCH -e wcfst%A-%a.o
#SBATCH -o wcfst%A-%a.o
#SBATCH -t 06-00:00
#SBATCH -n 8
#SBATCH --mem=16G
#SBATCH -p med
#SBATCH --no-requeue

outdir=/home/eoziolor/guppy/data/wcfst
popfile=/home/eoziolor/guppy/data/list/zeros_pop.txt
my_wcfst=/home/eoziolor/program/vcflib/bin/wcFst
my_pfst=/home/eoziolor/program/vcflib/bin/pFst
my_vcf=/home/eoziolor/guppy/data/varcall/sample.vcf.bgz
my_bgzip=/home/eoziolor/program/htslib/bgzip

pops=CAP_F\ CAP_H\ CAP_L\ CAP_S\ CAR_F\ CAR_H\ CAR_L\ CAR_S\ CUN_F\ CUN_L\ CUN_S

pair=$(for i in {1..10}
do
	ii=$(expr $i + 1)
	for j in $(seq $ii 11)
	do echo $pops | cut -f $i,$j -d ' '
  done
done | \
sed -n "$(echo $SLURM_ARRAY_TASK_ID)p")

echo $SLURM_ARRAY_TASK_ID

pop1=$(echo $pair | cut -f 1 -d ' ')
pop2=$(echo $pair | cut -f 2 -d ' ')

target=$(grep -n $pop1 $popfile | cut -f 1 -d ":" | awk '{s=$1-1}{print s}' | tr '\n' ',' | \
sed 's/,$//')

background=$(grep -n $pop2 $popfile | cut -f 1 -d ":" | awk '{s=$1-1}{print s}' | tr '\n' ',' | \
sed 's/,$//')

outfile1=$pop1.$pop2.wcfst.bgz
outfile2=$pop1.$pop2.pfst.bgz

out1=$outdir/$outfile1
out2=$outdir/$outfile2

echo $out1
echo $out2

echo $target
echo $background
echo $outfile1
echo $outfile2

$my_wcfst \
--target $target \
--background $background \
--file $my_vcf \
--type GL | \
$my_bgzip>$out1

$my_pfst \
--target $target \
--background $background \
--file $my_vcf \
--type GL | \
$my_bgzip>$out2


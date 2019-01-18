#!/bin/bash -l

#SBATCH -J windows
#SBATCH -e windows-%j.o
#SBATCH -o windows-%j.o
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -t 06-00:00
#SBATCH --mem=16000
#SBATCH -p high
#SBATCH --no-requeue

my_btools=/home/eoziolor/program/bedtools2/bin/bedtools
my_ref=/home/eoziolor/guppy/data/genome/preticulata.fna.genome
my_out=/home/eoziolor/guppy/data/window/50kb.10kb.bed

$my_btools makewindows \
-g $my_ref \
-w 50000 \
-s 10000 > $my_out

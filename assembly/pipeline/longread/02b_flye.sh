#!/usr/bin/bash -l
#SBATCH -p intel -N 1 -n 64 --time=3-00:15:00 --mem 128gb --out logs/flye_scaf.%a.log -a 1-12

module load Flye

CPUS=$SLURM_CPUS_ON_NODE
if [ -z $CPUS ]; then
 CPUS=1
fi

flye --genome-size 45m -t $CPUS -o asm/flye.2 -i 5 --nano-hq input/nanopore/JES_115_nanopore.COMB3.fastq.gz --scaffold

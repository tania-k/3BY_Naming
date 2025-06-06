#!/usr/bin/bash -l
#SBATCH -p intel -n 1 -n 4 --mem 64gb --out logs/medaka2_cons.%a.log  --time 12:00:00

module load medaka/1.6
module load workspace/scratch

MODEL=r941_min_high_g360
OUTDIR=asm.v2/medaka

CPU=$SLURM_CPUS_ON_NODE
if [ -z $CPU ]; then
	CPU=1
fi

N=${SLURM_ARRAY_TASK_ID}
if [ -z $N ]; then
    N=$1
    if [ -z $N ]; then
	echo "no value for SLURM ARRAY - specify with -a or cmdline"
    fi
fi

IFS=,
SAMPLES=flowcell.nanopore_samples.csv

sed -n ${N}p $SAMPLES | while read STRAIN NANOPORE FASTQ
do
    for type in canu flye
    do
	DRAFT=$OUTDIR/$STRAIN/$type.fasta
	HDF=$OUTDIR/$STRAIN/$type.hdf
	POLISHED=$OUTDIR/$STRAIN/$type.polished.fasta
	BAM=$OUTDIR/$STRAIN/$type.calls_to_draft.bam
	if [ ! -s $HDF ]; then
	    time medaka consensus $BAM $HDF --model $MODEL --threads $CPU
	fi
	if [ ! -s $POLISHED ]; then
	    time medaka stitch --threads $CPU $HDF $DRAFT $POLISHED	   
	fi
    done
done

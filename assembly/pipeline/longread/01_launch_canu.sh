#!/usr/bin/bash -l
#SBATCH -p intel -N 1 -n 64 --time=3-00:15:00  --mem 128gb --out logs/canu.%a.log
module load canu

mkdir -p logs

IFS=,
SAMPLES=nanopore_samples.csv
OUTDIR=asm/canu
INDIR=input/nanopore
mkdir -p $OUTDIR
while read STRAIN NANOPORE
do
    canu -p $STRAIN -d $OUTDIR/$STRAIN genomeSize=45m useGrid=true -nanopore $INDIR/$NANOPORE
done < $SAMPLES


#!/usr/bin/bash -l
#SBATCH -p intel -N 1 -n 64 --time=3-00:15:00 --mem 128gb --out logs/NECAT.%a.log -a 1-12

module load NECAT

IFS=,
SAMPLES=nanopore_samples.csv
OUTDIR=asm/NECAT
INDIR=input/nanopore
TEMPLATECONFIG=lib/NECAT_config.txt

mkdir -p $OUTDIR

CPUS=$SLURM_CPUS_ON_NODE
if [ -z $CPUS ]; then
 CPUS=1
fi

N=${SLURM_ARRAY_TASK_ID}
if [ -z $N ]; then
    N=$1
    if [ -z $N ]; then
	echo "no value for SLURM ARRAY - specify with -a or cmdline"
    fi
fi

sed -n ${N}p $SAMPLES | while read STRAIN NANOPORE
do
    mkdir -p $OUTDIR/$STRAIN
    realpath $INDIR/$NANOPORE > $OUTDIR/$STRAIN/reads.txt
    perl -p -e "s/REPLACEME/$STRAIN/" $TEMPLATECONFIG > $OUTDIR/$STRAIN/config.txt
    pushd $OUTDIR/$STRAIN
    necat.pl correct config.txt
    necat.pl assemble config.txt
    necat.pl bridge config.txt
    popd
done

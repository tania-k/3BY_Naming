#!/usr/bin/bash -l
#SBATCH -p batch --time 3-0:00:00 --ntasks 16 --nodes 1 --mem 24G --out logs/compare.log


module load funannotate

export AUGUSTUS_CONFIG_PATH=$(realpath lib/config/)

export FUNANNOTATE_DB=/bigdata/stajichlab/shared/lib/funannotate_db

INDIR=annotate
OUTDIR=compare


funannotate compare -i $INDIR/Coniosporium_tulheliwenetii_JES115 $INDIR/Neophaeococcomyces_mojaviensis_JES112 $INDIR/Taxawa_tesnikishii_JES119 -o $OUTDIR -d $FUNANNOTATE_DB --run_dnds estimate

#!/usr/bin/bash
#SBATCH -p short -N 1 -n 16 --mem 96gb  --out LRScaf.run.%A.log

module load minimap2
module load samtools
module load java/13
CPU=2
if [ ! -z $SLURM_CPUS_ON_NODE ]; then
	CPU=$SLURM_CPUS_ON_NODE
fi
GENOME=genome/JES_119.Illumina_only.fasta
READS=Nanopore/filtered_reads.1kb.fq.gz
READMAP=align-longreads.paf
OUTDIR=LRScaf_out

if [ ! -f $READMAP ]; then
	minimap2 --cs=long -x map-ont -t $CPU $GENOME $READS > $READMAP
fi

java -Xms96g -Xmx96g -jar LRScaf.jar -x ./scafconfig.xml

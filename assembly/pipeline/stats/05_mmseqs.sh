#!/bin/bash -l
#SBATCH -p short -N 1 -n 64 --mem 128gb --out logs/mmseqs_classify.%a.log -C xeon

module load mmseqs2
module load KronaTools
module load workspace/scratch

OUTSEARCH=reports/taxonomy
mkdir -p $OUTSEARCH
DB=/srv/projects/db/ncbi/mmseqs/swissprot
DB2=/srv/projects/db/ncbi/mmseqs/uniref50

if [ -f config.txt ]; then
  source config.txt
fi

CPU=2
if [ $SLURM_CPUS_ON_NODE ]; then
  CPU=$SLURM_CPUS_ON_NODE
fi
for CONTIG in $(ls genomes/*.fasta)
do
	STRAIN=$(basename $CONTIG .fasta)
    mkdir -p $OUTSEARCH/$STRAIN
    if [ ! -f  $OUTSEARCH/$STRAIN/mmseq_uniref50_report ]; then
	mmseqs easy-taxonomy $CONTIG $DB2 $OUTSEARCH/$STRAIN/mmseq_uniref50 $SCRATCH --threads $CPU --lca-ranks kingdom,phylum,family  --tax
-lineage 1
    fi
    if [ ! -f $OUTSEARCH/$STRAIN/mmseq_sprot_report ]; then
	mmseqs easy-taxonomy $CONTIG $DB $OUTSEARCH/$STRAIN/mmseq_sprot $SCRATCH --threads $CPU --lca-ranks kingdom,phylum,family --tax-line
age 1
    fi
    ktImportTaxonomy -o $OUTSEARCH/$STRAIN/mmseq_uniref50.krona.html $OUTSEARCH/$STRAIN/mmseq_uniref50_report
    ktImportTaxonomy -o $OUTSEARCH/$STRAIN/mmseq_sprot.krona.html $OUTSEARCH/$STRAIN/mmseq_sprot_report
done

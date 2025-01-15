#!/usr/bin/bash
module unload miniconda2
module load miniconda3
 # make sure biopython env is available for your python
INDIR=aln/combined/
EXT=aln.clipkit
 if [ ! -f expected_prefixes.lst ]; then
	 cat $INDIR/*.$EXT | grep ">" | awk '{print $1}'  | sort | uniq > 115_119.expected_prefixes.lst
 fi
./PHYling_unified/util/combine_multiseq_aln.py  --moltype DNA -p 115_119.multi.partitions.txt --expected 115_119.expected_prefixes.lst  --ext $EXT -d $INDIR -o 115_119.rDNA_multi.mfa

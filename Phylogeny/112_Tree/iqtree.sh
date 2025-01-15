#!/usr/bin/bash -l

#SBATCH --nodes 1 --ntasks 2 -p batch --mem 8gb --out logs/IQtree.%A.log

module load IQ-TREE/2.2.0
module load vcftools
module unload perl
#module unload miniconda2
module load miniconda3

iqtree2 -nt 2 -s aln/rDNA/JES_112.5_8S.aln.clipkit -b 1000

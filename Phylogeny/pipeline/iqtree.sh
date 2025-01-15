#!/usr/bin/bash -l

#SBATCH --nodes 1 --ntasks 16 -p short -C xeon --mem 120gb --out logs/IQtree.%A.log

module load IQ-TREE/2.2.0
module load vcftools
module unload perl
#module unload miniconda2
module load miniconda3

iqtree2 -nt 2 -s aln/combined/SSU.aln.clipkit -b 1000

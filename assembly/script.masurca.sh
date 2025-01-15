#!/bin/bash -l
#SBATCH --nodes 1 --ntasks 32 --mem 192gb -p intel --out logs/masurca.log -J masurca

module load masurca
masurca -t 32 -i ../input/illumina/JES_115_R1.fq.gz,../input/illumina/JES_115_R2.fq.gz -r ../input/nanopore/rescued_115.fq.gz

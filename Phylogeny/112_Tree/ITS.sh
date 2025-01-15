#!/usr/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=15
#SBATCH --mem-per-cpu=3G
#SBATCH --time=5:00:00
#SBATCH -p intel

conda activate itsx

ITSx -i ITS_Chaet_2.fa -o JES_112 --save_regions all --preserve True


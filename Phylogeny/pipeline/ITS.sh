#!/usr/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=15
#SBATCH --mem-per-cpu=3G
#SBATCH --time=5:00:00
#SBATCH -p intel

conda activate itsx

ITSx -i 115_119.fa -o 115_119 --save_regions all --preserve True

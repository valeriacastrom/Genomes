#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="gtdbtk_gen_assembly"
#SBATCH --mail-type=all
#SBATCH --mail-user=andrewwatson2025@u.northwestern.edu

module load gtdbtk

mkdir ${gtdbtkDir}

for directory in ${spadesDir}/*/;
do
    d_sub=$(basename $directory)
    mkdir ${gtdbtkDir}/${d_sub}
    prodigal -i ${directory}/scaffolds.fasta -o out.gene.coords.gbk -a out.protein.translations.faa
    mv out.gene* ${prodigalDir}/${d_sub} #Moves to prodigal directory
    mv out.protein* ${prodigalDir}/${d_sub}
done



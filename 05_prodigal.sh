#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=04:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="prodigal_gen_assembly"


#Setup
module purge all
module load anaconda3
module load prodigal 
source config.sh

#Prodigal
mkdir ${prodigalDir}
for directory in ${spadesDir}/*/;
do
    d_sub=$(basename $directory)
    mkdir ${prodigalDir}/${d_sub}
    prodigal -i ${directory}/scaffolds.fasta -o out.gene.coords.gbk -a out.protein.translations.faa
    mv out.gene* ${prodigalDir}/${d_sub} #Moves to prodigal directory
    mv out.protein* ${prodigalDir}/${d_sub}
done

# Deactivate conda
source deactivate

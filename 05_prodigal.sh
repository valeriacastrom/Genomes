#!/bin/bash

#SBATCH -A b1042
#SBATCH -p genomics
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=04:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="spades_gen_assembly"


#Setup
module purge all
module load anaconda3
module load prodigal 
source config.sh

#Prodigal
mkdir ${prodigalDir}
for directory in ${spadesDir}/*/;
do
    mkdir ${prodigalDir}/${directory}
    prodigal -i ${directory}/scaffolds.fasta -o out.gene.coords.gbk -a out.protein.translations.faa
    mv out.gene* ${prodigalDir}/${directory} #Moves to prodigal directory
    mv out.protein* ${prodigalDir}/${directory}
    
done

# Deactivate conda
source deactivate

#!/bin/bash

#SBATCH --account aDDLATER allocation requested
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="annotation_gen_assembly"

#Setup
module purge all
module load anaconda3
source config.sh

#Prodigal
cd ${spadesDir}



prodigal -i contigs.fasta -o out.gene.coords.gbk -a out.protein.translations.faa


#Moves to prodigal directory
mv out.gene* ${prodigalDir}/
mv out.protein* ${prodigalDir}/
mv egg_nog* ${prodigalDir}

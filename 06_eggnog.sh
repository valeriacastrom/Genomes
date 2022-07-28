#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="eggnog_gen_assembly"

# Setup
module purge all
module load eggnog-mapper
module load anaconda3
source config.sh
source activate annotation


# Make Eggnog Directory
mkdir ${eggnogDir}

# Run Eggnog
for directory in ${prodigalDir}/*/;
do
    d_sub=$(basename $directory) # Save basename
    mkdir ${eggnogDir}/${d_sub} # Make new directory
    # run emapper.py with all of the .faa files from prodigal
    emapper.py -i ${directory}/out.protein.translations.faa -o egg_nog -m diamond --cpu 20
    mv egg_nog* ${eggnogDir}/${d_sub} # Moves to eggnog directory
done

# Deactivate conda
source deactivate


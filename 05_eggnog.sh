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

#Egg-nog
find_in_conda_env(){
    conda env list | grep "${@}" >/dev/null 2>/dev/null
}

if find_in_conda_env "diamond" ; then
    source activate diamond
else 
    conda create -n diamond -c bioconda -c conda-forge python=3.9 #Create environment with diamond
    source activate diamond
    conda install -c bioconda diamond #Install diamond
fi

emapper.py -i out.protein.translations.faa -o egg_nog -m diamond --cpu 20

#Moves to prodigal directory
mv egg_nog* ${prodigalDir}
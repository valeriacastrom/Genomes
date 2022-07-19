#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="eggnog_gen_assembly"

#Setup
module purge all
module load eggnog-mapper
module load anaconda3
source config.sh
source activate annotation


#Egg-nog
#find_in_conda_env(){
#    conda env list | grep "${@}" >/dev/null 2>/dev/null
#
#check if diamond is installed in the 
#if find_in_conda_env "diamond" ; then
#    source activate diamond
#else 
#    conda create -n diamond -c bioconda -c conda-forge python=3.9 #Create environment with diamond
#    source activate diamond
#    conda install -c bioconda diamond #Install diamond
#fi



#Eggnog
mkdir ${eggnogDir}
for directory in ${prodigalDir}/*/;
do
    
    d_sub=$(basename $directory)
    mkdir ${eggnogDir}/${d_sub}
    #run emapper.py with all of the .faa files from prodigal
    emapper.py -i ${directory}/out.protein.translations.faa -o egg_nog -m diamond --cpu 20
    mv egg_nog* ${eggnogDir}/${d_sub} #Moves to eggnog directory
    
    
done

#Deactivate the conda environment containing diamond
source deactivate


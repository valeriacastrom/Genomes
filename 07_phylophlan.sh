#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=04:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="phylophlan_gen_assembly"
#SBATCH --mail-type=all
#SBATCH --mail-user=andrewwatson2025@u.northwestern.edu

module purge all
module load anaconda3
source activate phylophlan 
source config.sh

mkdir ${phylophlanDir}

for directory in ${prodigalDir}/*/;
do
    d_sub=$(basename $directory)
    cp ${directory}/out.protein.translations.faa ${phylophlanDir}/${d_sub}
    mv egg_nog* ${eggnogDir}/${d_sub} #Moves to eggnog directory
done



phylophlan -i ${phylophlanDir} -d phylophlan --diversity low -f supertree_aa.cfg


source deactivate

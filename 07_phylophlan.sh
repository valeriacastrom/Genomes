#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
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
    cp ${directory}/out.protein.translations.faa ${phylophlanDir}
    mv ${phylophlanDir}/out.protein.translations.faa ${phylophlanDir}/${d_sub}.faa

done


phylophlan -i ${phylophlanDir} -d phylophlan --diversity low -f Resources/supermatrix_aa.cfg -o ${phylophlanDir} 
mv phylophlan_databases ${phylophlanDir}
mv phylophlan_phylophlan ${phylophlanDir}

source deactivate

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

# Setup
module purge all
module load anaconda3
source activate phylophlan 
source config.sh

# Make Phylophlan directory
mkdir ${phylophlanDir}

# Setup directory
for directory in ${prodigalDir}/*/;
do
    d_sub=$(basename $directory) # Save basename
    cp ${directory}/out.protein.translations.faa ${phylophlanDir} # copy faa
    mv ${phylophlanDir}/out.protein.translations.faa ${phylophlanDir}/${d_sub}.faa
done

# Run Phylophlan
phylophlan -i ${phylophlanDir} -d phylophlan --diversity low -f Resources/supermatrix_aa.cfg -o ${phylophlanDir} --nproc 20

# Move files
mv phylophlan_databases ${phylophlanDir}
mv phylophlan_phylophlan ${phylophlanDir}

# Deactivate conda
source deactivate

#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="spades_gen_assembly"

#Setup
module purge all
module load anaconda3
source config.sh
source activate quast

#Make quast directory
mkdir ${quastDir}

#Run Quast
for directory in ${spadesDir}/*/;
do
    mkdir ${quastDir}/${directory}
    quast.py --threads 12 ${directory}/scaffolds.fasta -o ${quastDir}/${directory}
done

# Deactivate conda
source deactivate
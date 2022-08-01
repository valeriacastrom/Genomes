#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=10:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="gtdbtk_gen_assembly"
#SBATCH --mail-type=all
#SBATCH --mail-user=andrewwatson2025@u.northwestern.edu

# Setup
module purge all
module load gtdbtk
source config.sh
source activate gtdbtk
module load anaconda3
module load prodigal 

# Make gtdbtk directories
mkdir ${gtdbtkDir}
mkdir ${$gtdbtkDir}/scaffolds

# Setup directories
for directory in ${spadesDir}/*/;
do
    d_sub=$(basename $directory) # Save basename
    cp ${directory}/scaffolds.fasta ${gtdbtkDir}/scaffolds # copy fasta
    mv ${gtdbtkDir}/scaffolds/scaffolds* ${gtdbtkDir}/scaffolds/${d_sub}.fasta

done

# Run gtdbtk
gtdbtk classify_wf --genome_dir  ${gtdbtkDir}/scaffolds  --out_dir ${gtdbtkDir} --extension fasta --cpus 20

# Deactivate conda
source deactivate
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
module load prodigal 

# Make gtdbtk directories
mkdir ${gtdbtkDir2}
mkdir ${$gtdbtkDir2}/scaffolds

# Setup directories
for directory in ${spadesDir}/*/;
do
    d_sub=$(basename $directory) # Save basename
    cp ${directory}/scaffolds.fasta ${gtdbtkDir2}/scaffolds # copy fasta
    mv ${gtdbtkDir2}/scaffolds/scaffolds* ${gtdbtkDir2}/scaffolds/${d_sub}.fasta

done

# Run gtdbtk
gtdbtk identify  --genome_dir  ${gtdbtkDir2}/scaffolds  --out_dir ${gtdbtkDir2} --extension fasta --cpus 20

# Deactivate conda
source deactivate
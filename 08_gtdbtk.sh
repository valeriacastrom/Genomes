#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="gtdbtk_gen_assembly"
#SBATCH --mail-type=all
#SBATCH --mail-user=andrewwatson2025@u.northwestern.edu

module load gtdbtk
source config.sh

mkdir ${gtdbtkDir}
mkdir ${gtdbtkDir}/scaffolds


for directory in ${spadesDir}/*/;
do
    d_sub=$(basename $directory)
    cp ${directory}/scaffolds.fasta ${gtdbtkDir}/scaffolds
    mv ${gtdbtkDir}/scaffolds/scaffolds* ${gtdbtkDir}/scaffolds/${d_sub}.fasta

done


gtdbtk identify  --genome_dir  ${gtdbtkDir}/scaffolds  --out_dir ${gtdbtkDir} --extension fasta --cpus 3

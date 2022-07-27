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

mkdir ${gtdbtkDir}


for directory in ${spadesDir}/*/;
do
    cp ${directory}/out.protein.translations.faa ${gtdbtkDir}
    
done

gtdbtk  --genome_dir Bins --out_dir gtdbtk_results --extension fasta --cpus 3

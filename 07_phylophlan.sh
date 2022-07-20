#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=04:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="prodigal_gen_assembly"
#SBATCH --mail-type=all
#SBATCH --mail-user=andrewwatson2025@u.northwestern.edu




phylophlan -i <input_folder> \
    -d <database> \
    --diversity <low-medium-high> \
    -f <configuration_file>
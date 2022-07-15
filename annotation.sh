#!/bin/bash

#SBATCH --account aDDLATER allocation requested
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="annotation_gen_assembly"

# Setup
module purge all
module load anaconda3
source activate paired_read
source config.sh
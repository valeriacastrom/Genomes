#!/bin/bash

#SBATCH --account aDDLATER allocation requested
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="fastqc_gen_assembly"

# Workspace identifier
timestamp=$(date +%d%m%Y_%H%M)
identifer="genome"
workspace="../workspaces/${identifier}_${timestamp}"

# Load modules
module purge all
module load anaconda3
module load fastqc
module load multiqc

# FASTQC analysis
fastqc -t 12 "${workspace}/fastq/*fastq.gz"

# To move FastQC output into new directory
mv *fastqc.html "../workspace"
mv *fastqc.zip "${workspace}/fastqc"

# MultiQC analysis
cd ${fastqcDir}
multiqc "${workspace}/fastqc"
cd ${workspaceDir}
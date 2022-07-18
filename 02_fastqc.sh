#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="fastqc_gen_assembly"

# Setup
module purge all
module load anaconda3
module load fastqc
module load multiqc
source activate paired_read
source config.sh

# FASTQC analysis
fastqc -t 12 ${fastpDir}/*fastq.gz

# Move FastQC output into fastqcDir
mkdir ${fastqcDir}
mv ${fastpDir}/*fastqc.* ${fastqcDir}

# MultiQC analysis
multiqc ${fastqcDir}

# Move MultiQC output into fastqcDir
mv multiqc* ${fastqcDir}

# Deactivate conda
source deactivate
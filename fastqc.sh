#!/bin/bash

#SBATCH --account aDDLATER allocation requested
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
fastqc -t 12 $fastpDir/*fastq.gz #NOT WORKING MAYBE

# To move FastQC output into new directory
mkdir ${fastqcDir}
mv *fastqc.html ${fastqcDir}
mv *fastqc.zip ${fastqcDir}

# MultiQC analysis
multiqc ${fastqcDir} #NOT WORKING MAYBE
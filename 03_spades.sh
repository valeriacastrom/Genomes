#!/bin/bash

#SBATCH --account aDDLATER allocation requested
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="spades_gen_assembly"

# Setup
module purge all
module load anaconda3
module load spades
source activate paired_read
source config.sh

#Make the spades directory
mkdir ${spadesDir}

# SPADES analysis
for i in $(ls ${fastpDir}/*_fastp_out.R1.fastq.gz) # Iterate through R1
do
	i_basename=$(basename $i) # Save basename
	i_sub="${i_basename%%_*}" # Identifier (characters before underscore)
	for j in $(ls ${fastpDir}/*_fastp_out.R2.fastq.gz) # Iterate through R2
	do
		j_basename=$(basename $j) # Save basename
	    j_sub="${j_basename%%_*}" # Identifier (characters before underscore)
		if [[ $i_sub == $j_sub ]] # Match reads via accession
		then
			spades.py -1 ${i} -2 ${j} -o ${spadesDir} -t 40 -m 100
		fi

	done

done

# Deactivate conda
source deactivate
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

# for one file
spades.py -1 out1.fastq.gz -2 out2.fastq.gz -o ${spadesDir} -t 20 -m 100

#FIX: IDENTIFIER
# for all files
# for i in $(ls *fastp_out.R1.fq.gz) # Iterate through R1
# do
# 	i_sub=$(echo $i | cut -c1-10) # SRR accession number
# 	for j in $(ls *fastp_out.R2.fq.gz) # Iterate R2
# 	do
# 		j_sub=$(echo $j | cut -c1-10)
# 		if [[ $i_sub == $j_sub ]] # Match reads via accession
# 		then
# 			spades.py -1 ${i} -2 ${j} -o ${spadesDir} -t 40 -m 100

# 		fi

# 	done

# done
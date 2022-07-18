#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="fastp_gen_assembly"

# Setup
module purge all
module load anaconda3
source activate paired_read
source config.sh

# Iterate through all files
for i in $(ls ../raw_data/dummy_files/*_R1_001.fastq.gz) # Iterate through R1
do
    i_basename=$(basename $i) # Save basename
	i_sub="${i_basename%%_*}" # Identifier (characters before underscore)
	for j in $(ls ../raw_data/dummy_files/*_R2_001.fastq.gz) # Iterate through R2
	do
		j_basename=$(basename $j) # Save basename
	    j_sub="${j_basename%%_*}" # Identifier (characters before underscore)
		if [[ $i_sub == $j_sub ]] # Match reads via accession
		then
			fastp -i ${i} -I ${j} --out1 ${i_sub}_fastp_out.R1.fastq.gz --out2 ${j_sub}_fastp_out.R2.fastq.gz --detect_adapter_for_pe --thread 16 --length_required 50
		fi
	done
done

# Deactivate conda
conda deactivate

# Make directory and move output files
mkdir ${fastpDir}
mv *fastp_out.R1.fastq.gz ${fastpDir}/
mv *fastp_out.R2.fastq.gz ${fastpDir}/
mv fastp.html fastp.json ${fastpDir}/
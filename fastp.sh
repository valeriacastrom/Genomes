#!/bin/bash

#SBATCH --account aDDLATER allocation requested
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="fastp_gen_assembly"

# Workspace identifier
timestamp=$(date +%d%m%Y_%H%M)
identifer="genome"
workspace="../workspaces/${identifier}_${timestamp}"

# Load modules
module purge all
module load anaconda3

# Activate environment
source activate paired_read


# One file
fastp -i ../raw_data/NCH0002R-M_S10_L001_R1_001.fastq.gz -I ../raw_data/NCH0002R-M_S10_L001_R2_001.fastq.gz -o out1.fastq.gz -O out2.fastq.gz

# All files
# for i in $(ls *_1.fastq.gz) # Iterate through R1
# do
# 	i_sub=$(echo $i | cut -c1-14) # Identifier (first 14 characters)
# 	for j in $(ls *_2.fastq.gz) # Iterate R2
# 	do
# 		j_sub=$(echo $j | cut -c1-14)
# 		if [[ $i_sub == $j_sub ]] # Match reads via accession
# 		then
# 			fastp -i ${i} -I ${j} --out1 ${i_sub}_fastp_out.R1.fastq.gz --out2 ${j_sub}_fastp_out.R2.fastq.gz --detect_adapter_for_pe --thread 16 --length_required 50

# 		fi
# 	done
# done

# Deactivate conda
conda deactivate

# Move outputs
mv out* ${workspace}/fastp
mv fastp.html fastp.json ${workspace}/fastp
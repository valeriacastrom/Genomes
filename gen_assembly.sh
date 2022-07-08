#!/bin/bash

#SBATCH --account vcc4348
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=12
#SBATCH --time=24:00:00
#SBATCH --mem-per-cpu=10gb
#SBATCH --job-name="gen_assembly"

# This script downloads Mehreen's genomes (parental and infantile orgin), trims the paired reads, performs quality control,
# and profiles each read based on a MetaPhlAn database. It also generates tables and visual diagrams.

#Load modules
module purge all
module load anaconda3
module load fastqc
module load multiqc
module load spades

module load sratoolkit
module load bowtie2



###########################
###### PART 1: Path #######
###########################

timestamp=$(date +%d%m%Y_%H%M)
numberSRR="hello"
workspaceDir="/projects/b1042/HartmannLab/genomes-for-mehreen/AVG/workspaces/${numberSRR}_${timestamp}" #AVG stands for andrew, valeria and grayson

if [ -d $workspaceDir ]
then
	echo "Directory ${workspaceDir} already exists"
else
	mkdir ${workspaceDir}
	echo "Directory ${workspaceDir} has been made"
fi

cd ${workspaceDir}

rawReadDir="${workspaceDir}/raw_reads"
fastpDir="${workspaceDir}/fastp_trim"
fastqcDir="${workspaceDir}/fastqc"
spadesDir="${workspaceDir}/spades"
mkdir ${rawReadDir} ${fastpDir} ${fastqcDir} ${spadesDir}




###########################
#### PART 2: Download #####
###########################

#will do for all later 
cd /projects/b1042/HartmannLab/genomes-for-mehreen/AVG/raw_data
cp NCH0002R-M_S10_L001_R1_001.fastq.gz ${rawReadDir}
cp NCH0002R-M_S10_L001_R2_001.fastq.gz ${rawReadDir}
cd ${rawReadDir}



#####################
### PART 3: FASTP ###
#####################

source /software/anaconda2/etc/profile.d/conda.sh
conda activate paired_read
fastp -i NCH0002R-M_S10_L001_R1_001.fastq.gz -I NCH0002R-M_S10_L001_R2_001.fastq.gz -o out1.fastq.gz -O out2.fastq.gz
conda deactivate

mv out* ${fastpDir}/
mv fastp.html fastp.json ${fastpDir}/



######################
### PART 3: FASTQC ###
######################

cd ${fastpDir}/

# FASTQC analysis
fastqc -t 12 *fq.gz

# To move FastQC output into new directory
mv *fastqc.html ${fastqcDir}
mv *fastqc.zip ${fastqcDir}

# MultiQC analysis
cd ${fastqcDir}
multiqc .
cd ${workspaceDir}



######################
### PART 3: SPADES ###
######################

cd ${fastqcDir}


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
module load sratoolkit
module load anaconda3
module load fastqc
module load multiqc
# module load bowtie2

#PART 1: PATH
timestamp=$(date +%d%m%Y_%H%M)
numberSRR="..."
workspaceDir="/projects/b1042/HartmannLab/genomes-for-mehreen/AVG/${numberSRR}_${timestamp}" #AVG stands for andrew, valeria and grayson

if [ -d $workspaceDir ]
then
	echo "Directory ${workspaceDir} already exists"
else
	mkdir ${workspaceDir}
	echo "Directory ${workspaceDir} has been made"
fi

rawReadDir="${workspaceDir}/raw_reads"
fastpDir="${workspaceDir}/fastp_trim"
fastqcDir="${workspaceDir}/fastqc"
spadesDir="${workspaceDir}/spades"

mkdir ${rawReadDir} ${fastpDir} ${fastqcDir} ${spadesDir}

#PART 2: DOWNLOAD
# cd ${rawReads}

# # fasterq-dump --split-files SRR8944124
# # fasterq-dump --split-files SRR8944125
# # fasterq-dump --split-files SRR8944126
# # fasterq-dump --split-files SRR8944127
# # fasterq-dump --split-files SRR8944128
# # fasterq-dump --split-files SRR8944129

# cd ${workspaceDir}

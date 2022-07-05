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
workspaceDir="/home/vcc4348/genomes/${numberSRR}_${timestamp}"

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
metaphlanDir="${workspaceDir}/metaphlan"

mkdir ${rawReadDir} ${fastpDir} ${fastqcDir} ${metaphlanDir}

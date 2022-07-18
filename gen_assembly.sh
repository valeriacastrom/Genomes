#!/bin/bash

#SBATCH --account aDDLATER allocation requested
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=40:00:00
#SBATCH --mem=100gb
#SBATCH --job-name="gen_assembly"

# This script downloads Mehreen's genomes (parental and infantile orgin), trims the paired reads, performs quality control,
# and profiles each read based on a MetaPhlAn database. It also generates tables and visual diagrams.

#Load modules
module purge all

module load anaconda3
module load fastqc
module load multiqc
module load spades
module load prodigal
module load prokka 
module load eggnogmapper


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
prodigalDir="${workspaceDir}/prodigal"
prokkaDir="${workspaceDir}/prokka"
mkdir ${rawReadDir} ${fastpDir} ${fastqcDir} ${spadesDir} ${prokkaDir} ${prodigalDir}




###########################
#### PART 2: Download #####
###########################


cd /projects/b1042/HartmannLab/genomes-for-mehreen/AVG/raw_data

# one files
cp NCH0002R-M_S10_L001_R1_001.fastq.gz ${rawReadDir}
cp NCH0002R-M_S10_L001_R2_001.fastq.gz ${rawReadDir}

# all file
# cp *.fastq.gz ${rawReadDir}

cd ${rawReadDir}



#####################
### PART 3: FASTP ###
#####################

source /software/anaconda2/etc/profile.d/conda.sh
conda activate paired_read

# one file
fastp -i NCH0002R-M_S10_L001_R1_001.fastq.gz -I NCH0002R-M_S10_L001_R2_001.fastq.gz -o out1.fastq.gz -O out2.fastq.gz
# FIX: MATCH IDENTIFIERS
# all files
# for i in $(ls *_1.fastq.gz) # Iterate through R1
# do
# 	i_sub=$(echo $i | cut -c1-10) # SRR accession number
# 	for j in $(ls *_2.fastq.gz) # Iterate R2
# 	do
# 		j_sub=$(echo $j | cut -c1-10)
# 		if [[ $i_sub == $j_sub ]] # Match reads via accession
# 		then
# 			fastp -i ${i} -I ${j} --out1 ${i_sub}_fastp_out.R1.fastq.gz --out2 ${j_sub}_fastp_out.R2.fastq.gz --detect_adapter_for_pe --thread 16 --length_required 50

# 		fi

# 	done

# done

conda deactivate

mv out* ${fastpDir}/
mv fastp.html fastp.json ${fastpDir}/



######################
### PART 4: FASTQC ###
######################

cd ${fastpDir}/

# FASTQC analysis
fastqc -t 12 *fastq.gz

# To move FastQC output into new directory
mv *fastqc.html ${fastqcDir}
mv *fastqc.zip ${fastqcDir}

# MultiQC analysis
cd ${fastqcDir}
multiqc .
cd ${workspaceDir}



######################
### PART 5: SPADES ###
######################

cd ${fastpDir}

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




######################
### PART 6: ANNOTATION 
######################



module load prodigal
cd ${spadesDir}
prodigal -i contigs.fasta -o out.gene.coords.gbk -a out.protein.translations.faa

#prokka --outdir prokkaDir --prefix mygenome contigs.fasta
#mv out* ${prokkaDir}/


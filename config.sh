#!/bin/bash
# This file sets up variables for the workspaces of each tool, sourced by each file for the identifier 

# Workspace identification

#MODIFY THIS LINE
identifier="run2" # CHANGE TO UNIQUE IDENTIFIER EACH TIME

workspaceDir="../workspaces/${identifier}"

# Create the workspace directory
if [ ! -d "${workspaceDir}" ]
then
	mkdir "${workspaceDir}"
fi

# Setup variables
rawReadDir="${workspaceDir}/raw_reads"
fastpDir="${workspaceDir}/fastp_trim"
fastqcDir="${workspaceDir}/fastqc"
spadesDir="${workspaceDir}/spades"
prodigalDir="${workspaceDir}/prodigal"
eggnogDir="${workspaceDir}/eggnog"
quastDir="${workspaceDir}/quast"
phylophlanDir="${workspaceDir}/phylophlan"

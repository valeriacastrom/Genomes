#!/bin/bash

# This file sets up variables for the workspaces of each tool, 
# sourced by each file for the identifier 



#MODIFY THESE LINES
rawReadsDir="../raw_data" # CHANGE TO PATH OF FOLDER CONTAINING RAW DATA
workspaceDir="../workspaces/run2" # CHANGE TO WHERE THE OUTPUT FILES SHOULD GO



# Create the workspace directory
if [ ! -d "${workspaceDir}" ]
then
	mkdir "${workspaceDir}"
fi

# Setup variables
fastpDir="${workspaceDir}/fastp_trim"
fastqcDir="${workspaceDir}/fastqc"
spadesDir="${workspaceDir}/spades"
prodigalDir="${workspaceDir}/prodigal"
eggnogDir="${workspaceDir}/eggnog"
quastDir="${workspaceDir}/quast"
phylophlanDir="${workspaceDir}/phylophlan"

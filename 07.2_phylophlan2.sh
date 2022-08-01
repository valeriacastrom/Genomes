#!/bin/bash

#SBATCH --account p31752
#SBATCH --partition normal
#SBATCH --nodes=1
#SABTCH --ntasks-per-node=20
#SBATCH --time=00:10:00
#SBATCH --mem=10gb
#SBATCH --job-name="phylophlan_run2"
#SBATCH --mail-type=all
#SBATCH --mail-user=andrewwatson2025@u.northwestern.edu

module purge all
module load anaconda3
source activate phylophlan 
source config.sh


##STEP 1 -- Place all of the 

mkdir -p ${phylophlanDir2}
for directory in ${prodigalDir}/*/;
do
    d_sub=$(basename $directory)
    cp ${directory}/out.protein.translations.faa ${phylophlanDir2}
    mv ${phylophlanDir2}/out.protein.translations.faa ${phylophlanDir2}/${d_sub}.faa
done


##STEP 2    

#./download_files.sh sequence_url_opendata_19436.txt input_bins



phylophlan_get_reference.py -g f__Enterobacteriaceae -o input_bins -e .faa 
# Genomes

This repository contains the steps for assembling and annotating genomes. It takes a list of file of raw paired reads, and runs fastp, fastqc, spades,
quast, prodigal, eggnog mapper, and pylophlan on them, in that order. It stores outputs in the workspace directory specified in config.sh.

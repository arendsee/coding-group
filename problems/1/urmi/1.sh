#!/bin/bash
#download file using curl
curl -o my.gff.gz https://ftp.ncbi.nih.gov/genomes/Alligator_sinensis/GFF/ref_ASM45574v1_scaffolds.gff3.gz
gunzip my.gff.gz

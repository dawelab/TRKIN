#!/bin/bash
#SBATCH --job-name=Mummer_N10vHiFiAb10
#SBATCH --output=Mummer_N10vHiFiAb10.out
#SBATCH --partition=batch
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mjb51923@uga.edu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --mem=100gb
#SBATCH --time=72:00:00

#Load Modules
module load MUMmer/4.0.0rc1-GCCcore-11.3.0
module load SAMtools/1.10-GCC-8.3.0

#Define Variables
DIR="/scratch/mjb51923/TRKIN_CRISPR/out_paper/K10L2_Mummer"

#-t is threads, -l is minimum length generate maximal unique matches, -maxmatch has it compute all maximal matches not just unique ones, -b computes both forward and reverse complements, I believe that
cd $DIR
nucmer --maxmatch -p N10_v_Ab10_nucmer -t 30 -l 300 $DIR/B73.PLATINUM.pseudomolecules-v1.N10SharedRegion.fasta $DIR/Ab10_HiFi_v2_corrected_Ab10Hap.Ab10.fasta

#This outputs the cords
show-coords -c -l -r -T N10_v_Ab10_nucmer.delta > N10_v_Ab10_nucmer.coords
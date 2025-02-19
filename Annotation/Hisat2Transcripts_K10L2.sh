#!/bin/bash
#SBATCH --job-name=Hisat2Transcripts_K10L2
#SBATCH --output Hisat2Transcripts_K10L2.%A-%a.out
#SBATCH --partition=batch
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mjb51923@uga.edu
#SBATCH --ntasks=24
#SBATCH --mem=100gb
#SBATCH --time=24:00:00
#SBATCH --array=1-5

#Load Modules needed 
module load HISAT2/3n-20201216-gompi-2022a
module load SAMtools/1.17-GCC-12.2.0

#Set the file name 
THREADS=24
READDIR=/scratch/mjb51923/raw_reads/RNA/K10L2
OUT=/scratch/mjb51923/TRKIN_CRISPR/out_paper

#Make the output directory and enter it
#mkdir $OUT/K10L2_Hisat2
cd $OUT/Hisat2_Transcripts_K10L2

#List of all RNA seq identifiers (one per pair) from EBI E-MTAB-8641 made in List.txt

#This pulls info from the array job
IT=$SLURM_ARRAY_TASK_ID
NAME=$(awk NR==${IT}'{print $1}' $OUT/K10L2_Hisat2/List.txt)

#Define the transcript reference 
REF=$OUT/AGAT/CI66_K10L2.cds.fasta

#Build a hisat2 reference
#I ran this command separatly first to avoid having the reference re built every time
#hisat2-build $REF CI66_K10L2.cds
hisat2 -x CI66_K10L2.cds -p $THREADS -1 $READDIR/${NAME}_R1.fq.gz -2 $READDIR/${NAME}_R2.fq.gz -S $OUT/Hisat2_Transcripts_K10L2/${NAME}.sam
samtools view -bS $OUT/Hisat2_Transcripts_K10L2/${NAME}.sam > $OUT/Hisat2_Transcripts_K10L2/${NAME}.bam
samtools sort $OUT/Hisat2_Transcripts_K10L2/${NAME}.bam -o $OUT/Hisat2_Transcripts_K10L2/${NAME}.s.bam



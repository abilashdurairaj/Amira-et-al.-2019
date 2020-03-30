#!/bin/bash -e
#$ -l arch=linux-x64
#$ -b n
#$ -q all.q
#$ -i /dev/null
#$ -e /path/to/my_directory/log_output/
#$ -o /path/to/my_directory/log_output/
#$ -cwd
#$ -l vf=3G


conda activate picrust2
mkdir -p /path/to/humanized_PICRUSt2/picrust2_res/
cd /path/to/humanized_PICRUSt2/picrust2_res/

picrust2_pipeline.py -s OTUs-Seqs.fasta -i OTUs_Table-norm-picrust.txt  -o /path/to/humanized_PICRUSt2/picrust2_res/picrust2_out_pipeline_edited  -p 1



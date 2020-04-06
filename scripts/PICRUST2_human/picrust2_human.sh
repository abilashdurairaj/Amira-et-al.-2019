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
path_to_home=$1
mkdir -p ${path_to_home}Metwaly-et-al.-2020/Data/PICRUSt2_human/picrust2_res/
cd ${path_to_home}Metwaly-et-al.-2020/Data/PICRUSt2_human/

picrust2_pipeline.py -s OTUs-Seqs.fasta -i OTUs-Table_edited.tab.txt  -o ${path_to_home}Metwaly-et-al.-2020/Data/PICRUSt2_human/picrust2_res/picrust2_out_pipeline_edited  -p 1
cp ${path_to_home}Metwaly-et-al.-2020/Data/PICRUSt2_human/picrust2_res/picrust2_out_pipeline_edited/KO_metagenome_out/pred_metagenome_unstrat.tsv.gz ./


rm -rf ${path_to_home}Metwaly-et-al.-2020/Data/PICRUSt2_human/picrust2_res/picrust2_out_pipeline_edited/KO_metagenome_out/pred_metagenome_unstrat.tsv.gz
tar -xzf pred_metagenome_unstrat.tsv.gz
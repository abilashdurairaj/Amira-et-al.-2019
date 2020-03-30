conda activate picrust2
mkdir -p /project/genomics/Abilash/Amira/humanized_PICRUSt2/picrust2_res/
# mkdir -p /project/genomics/Abilash/Amira/humanized/
cd /project/genomics/Abilash/Amira/humanized_PICRUSt2/

picrust2_pipeline.py -s OTUs-Seqs.fasta -i OTUs_Table-norm-picrust.txt  -o /project/genomics/Abilash/Amira/humanized_PICRUSt2/picrust2_res/picrust2_out_pipeline_edited  -p 1
mkdir -p /project/genomics/Abilash/Amira/humanized/picrust2_res/intermediate/;
mkdir -p /project/genomics/Abilash/Amira/humanized/picrust2_res/intermediate/place_seqs/ ; 
place_seqs.py -s OTUs-Seqs.fasta -o /project/genomics/Abilash/Amira/humanized/picrust2_res/out.tre -p 1 --intermediate /project/genomics/Abilash/Amira/humanized/picrust2_res/intermediate/place_seqs/
hsp.py -i 16S -t /project/genomics/Abilash/Amira/humanized/picrust2_res/out.tre -o /project/genomics/Abilash/Amira/humanized/picrust2_res/marker_predicted_and_nsti.tsv.gz -p 1 -n
hsp.py -i EC -t /project/genomics/Abilash/Amira/humanized/picrust2_res/out.tre -o /project/genomics/Abilash/Amira/humanized/picrust2_res/EC_predicted.tsv.gz -p 1
metagenome_pipeline.py -i OTUs-Table_edited.tab.txt -m /project/genomics/Abilash/Amira/humanized/picrust2_res/marker_predicted_and_nsti.tsv.gz -f /project/genomics/Abilash/Amira/humanized/picrust2_res/EC_predicted.tsv.gz         -o /project/genomics/Abilash/Amira/humanized/picrust2_res/EC_metagenome_out --strat_out
metagenome_pipeline.py -i OTUs-Table_edited.tab.txt -m /project/genomics/Abilash/Amira/humanized/picrust2_res/marker_predicted_and_nsti.tsv.gz -f /project/genomics/Abilash/Amira/humanized/picrust2_res/EC_predicted.tsv.gz         -o /project/genomics/Abilash/Amira/humanized/picrust2_res/EC_metagenome_out --strat_out --wide_table


add_descriptions.py -i /project/genomics/Abilash/Amira/humanized/picrust2_res/EC_metagenome_out/pred_metagenome_unstrat.tsv.gz -m EC \
                    -o /project/genomics/Abilash/Amira/humanized/picrust2_res/EC_metagenome_out/pred_metagenome_unstrat_descrip.tsv.gz

# add_descriptions.py -i /project/genomics/Abilash/Amira/humanized/picrust2_res/pathways_out/path_abun_unstrat.tsv.gz -m METACYC \
                    -o /project/genomics/Abilash/Amira/humanized/picrust2_res/pathways_out/path_abun_unstrat_descrip.tsv.gz
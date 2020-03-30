


conda activate picrust2
mkdir -p /project/genomics/Abilash/Amira/humanized_PICRUSt2/picrust2_res/
cd /project/genomics/Abilash/Amira/humanized_PICRUSt2/

picrust2_pipeline.py -s OTUs-Seqs.fasta -i OTUs_Table-norm-picrust.txt  -o /project/genomics/Abilash/Amira/humanized_PICRUSt2/picrust2_res/picrust2_out_pipeline_edited  -p 1



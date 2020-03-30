


conda activate picrust2
mkdir -p /path/to/humanized_PICRUSt2/picrust2_res/
cd /path/to/humanized_PICRUSt2/picrust2_res/

picrust2_pipeline.py -s OTUs-Seqs.fasta -i OTUs_Table-norm-picrust.txt  -o /path/to/humanized_PICRUSt2/picrust2_res/picrust2_out_pipeline_edited  -p 1



<h1> Integrated microbiota and metabolite profiles identified functional signatures in Crohn’s disease with a link to sulfur metabolism </h1>

<b>     The aim of the study is to identify the potential taxonomic and functional biomarkers that can be associated to Crohn's disease patients. The fecal transfer from one healthy individual, one relapsed patient and one remitted patient were done to murine mouse models (n=3) and metagenomic study was performed from such samples.<p>
        The pipeline presented here is implemented on the metagenomic samples obtained from the murine models (sample size=3 for each disease status). We split the analysis into three parts: <p>
        1. Quality Control <p>
        2. Taxonomic/Functional Profile Analysis <p>
        3. Taxonomic/Functional Signatures <p>
<h5>Before performing analysis, install the tools reuired as mentioned in /master/scripts/description.md        
<h2> 1. Quality Control </h2>
<img src="https://github.com/abilashdurairaj/Metwaly-et-al.-2020/blob/master/pictures/QC_pipeline_fin.PNG" width: "40%" height: "30%">

<h4> The technical contaminants from the raw metagenomic samples were removed using Trimmomatic version 0.36. For this, first the adapter sequences were removed and retained only those reads with a minimum quality determined by the strictness parameter 0.4 (MAXINFO:30:0.4) and a minimum length of 90 bp. 
     The rRNA reads and host-associated reads were considered the biological contaminants in this current study. </h4>
 
   ```shellscript
### hh    : path where the fastq.gz files are located
### hm_dr : path where to store output files 
# hh=/path/to/fastq_files/
# hm_dr=/path/to/store/data/

   qsub /path/to/scripts/QC_wrap.sh ${hh} ${hm_dr}
  ```
<h2> 2. Taxonomic/Functional Profile Analysis </h2>
<img src="https://github.com/abilashdurairaj/Metwaly-et-al.-2020/blob/master/pictures/outline_analysis.PNG" width: "40%" height: "30%">
<h5>For taxonomic and functional profile analysis, we pooled the samples belonging to the same condition and performed assembly using megaHIT and annotated the contigs using CAT. The ORFs for each contig was done using prodigal :

```shellscript
   qsub /path/to/scripts/assembly_by_pooling_from_each_condition.sh ${hm_dr} # for assembly
   qsub /path/to/scripts/contig_taxonomy_annotation.sh ${hm_dr} # for contig annotation
   qsub /path/to/scripts/ORF_prediction_for_contig_annotation.sh ${hm_dr} # for ORF prediction
   
  ```
  
<h5> The proteins sequences predicted using prodigal for each condition, were uploaded to GHOSTKOALA portal (mentioned in /master/scripts/description.md). The results were downloaded and used the KEGG Orthology prediction for each ORF.
<h5> For taxonomic profile, we mapped the individual samples from each condition against the contigs assembled for the same condition. Similarly, for we mapped the individual samples from each condition against the ORFs predicted for the same condition.
```shellscript
   qsub /path/to/scripts/ORF_and_contig_count.sh ${hm_dr} # for assembly
 ```
<h2> 3. Taxonomic/Functional Signatures </h2>

<h5>We removed those functions (KEGG Modules) that are not completely present in any prokaryote using https://www.kegg.jp/kegg-bin/check_module_taxonomy.cgi. 
<h5> For taxonomic signatures, we obtained the relative abundance of the taxa and for functional signatures, we obtained the relative abundance of the KEGG Modules and used them to obtain the taxonomic and functional signatures using LefSe analysis pipeline available in https://huttenhower.sph.harvard.edu/galaxy/. 

<h5> Note: The R files produce input for LefSe analysis which are stored in /Data/Functional Profile/ for functional analysis and /Data/Taxonomic Profile/ for taxonomic analysis. Hence, running these R-files could replace the previous copies of it.

```shellscript
   #### path_to_home: location where the github folder is located.
   Rscript /path/to/scripts/CAT_tax_annotation.R ${hm_dr}megaHIT_contigs/ # for taxonomic annotation formatting
   Rscript /path/to/scripts/CAT_tax_count.R ${hm_dr}megaHIT_contig_count/ ${hm_dr}megaHIT_contigs/  # for taxonomic count and data preparation for LefSe analysis
   Rscript /path/to/scripts/metq_based_rel_abn.R ${hm_dr}orf_count/ ${hm_dr}orf_count/  $path_to_home # for functional count and data preparation for LefSe analysis, for supplementary figure-5 and for ternary plots.
```
<h5> The file in the /Data/Functional Profile/humanised_KEGG_modules_profile.csv and /Data/Taxonomic Profile/tax_count_overall_rel_donor_disease_euk_removed.txt (Removed human samples and added Condition of the samples , as a row manually) can be used as input to the LefSe analysis.

<h2>  PICRUST2 results -humanised mouse model samples </h2>
<h5>    We used PICRUST2 to predict functional profile from the amplicon sequencing from humanised mouse model samples.   </h2>
<h5>   The scripts we used are in /scripts/PICRUST2_humanised/
```shellscript
   #### path_to_home: location where the github folder is located.
   qsub /path/to/scripts/PICRUST2_humanised/amira_picrust2_humanized.sh ${path_to_home} # predicted KO profile
   Rscript /path/to/scripts/PICRUST2_humanised/amira_picrust2_humanized_mice.R ${path_to_home} # for creating input for LefSe analysis and plotting the output for LefSe analysis.
```
<h5> Note: Running this R- file replaces the previous copy of the input for Lefse analysis        

<h2>  PICRUST2 results -human samples </h2>
<h5>    We used PICRUST2 to predict functional profile from the amplicon sequencing from human samples.   </h2>
<h5>   The scripts we used are in /scripts/PICRUST2_human/
```shellscript
   #### path_to_home: location where the github folder is located.
   qsub /path/to/scripts/PICRUST2_human/amira_picrust2_human.sh ${path_to_home} # predicted KO profile
   Rscript /path/to/scripts/PICRUST2_human/amira_picrust2_human.R ${path_to_home} # for creating input for LefSe analysis and plotting the output for LefSe analysis.
```
<h5> Note: Running this R- file replaces the previous copy of the input for Lefse analysis        




</b>
        

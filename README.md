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
 
 
 **The scripts can be run as follows:**
 
   qsub /path/to/scripts/QC_wrap.sh
 
<h2> 2. Taxonomic/Functional Profile Analysis </h2>
<img src="https://github.com/abilashdurairaj/Metwaly-et-al.-2020/blob/master/pictures/outline_analysis.PNG" width: "40%" height: "30%">
<h5>For taxonomic and functional profile analysis, we pooled the samples belonging to the same condition and performed assembly using megaHIT and annotated the contigs using CAT :
        
<h2> 3. Taxonomic/Functional Signatures </h2>

<h5>We removed those functions (KEGG Modules) that are not completely present in any prokaryote using https://www.kegg.jp/kegg-bin/check_module_taxonomy.cgi. We obtained the relative abundance of the KEGG Modules and used them to obtain the taxonomic and functional signatures using LefSe analysis pipeline available in https://huttenhower.sph.harvard.edu/galaxy/

<h2>  PICRUST2 results -humanised mouse model samples </h2>
<h5>    We used PICRUST2 to predict functional profile from the amplicon sequencing from humanised mouse model samples.   </h2>


</b>
        

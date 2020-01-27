#!/bin/bash -e
#$ -l arch=linux-x64
#$ -b n
#$ -q all.q
#$ -i /dev/null
#$ -e /path/to/my_directory/log_output/
#$ -o /path/to/my_directory/log_output/
#$ -cwd
#$ -l vf=3G

export JAVA_HOME=/path/to/Tools/jre1.8.0_191/bin/

export PATH=/path/to/Tools/FragGeneScan1.31/:/path/to/Tools/hmmer-3.2.1/src/:/path/to/Tools/idba-master/:/path/to/Tools/idba-master/bin/:/path/to/Tools/MaxBin-2.2.6/:/path/to/Tools/Spades/SPAdes-3.13.0-Linux/bin/:/path/to/DB/ncbi-blast-2.7.1+/bin/:/path/to/Tools/antismash-3.0.5.1/:/path/to/Tools/antismash-3.0.5.1/antismash/:/path/to/Tools/bowtie2-2.2.9/:/project/genomics/Abilash/Tools/kneaddata/:/path/to/Tools/trimmomatic-master/*:/project/genomics/Abilash/Tools/tophat-2.1.1.Linux_x86_64/:/project/genomics/Abilash/Tools/bowtie2-2.2.9:/project/genomics/Abilash/Tools/hisat2-2.1.0/:/path/to/Tools/LRZ_samtools-1.9/:/path/to/Tools/fastx_bin/bin/:/path/to/Tools/dos2unix-7.3.3/:/path/to/Tools/sortmerna-2.1b/:/path/to/Tools/kaiju-master/:/path/to/Tools/kaiju-master/bin/:/path/to/Tools/kaiju-master/src/kaijudb/:/path/to/Tools/diamondv0.9.14/:$PATH:/path/to/Tools/prodigal-2.6.3-1/bin/:/home/comi/abilash.durai/gcc-8.2.0/bin/:/path/to/Tools/subread-1.6.2/bin/:/path/to/Tools/bbmap/:/path/to/Tools/jre1.8.0_191/bin/:/path/to/Tools/seqtk-master/:/home/comi/abilash.durai/Python-3.7.0b5/:/path/to/Tools/kneaddata/:/path/to/Tools/trimmomatic-master/*:/path/to/Tools/tophat-2.1.1.Linux_x86_64/:/path/to/Tools/bowtie2-2.2.9:/path/to/Tools/hisat2-2.1.0/:/path/to/Tools/kraken2-2.0.7-new/:/path/to/Tools/bbmap/:$PATH


######################################################################################################################################################################################################################
##### Mouse samples
######################################################################################################################################################################################################################
##### for M samples

mkdir -p /path/to/samples/M_files/
cd /path/to/samples/M_files/

CAT contigs -n 60 -c /path/to/samples/M_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/M_files/out.CAT.ORF2LCA.txt -o /path/to/samples/M_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/M_files/out.CAT.ORF2LCA.txt -o /path/to/samples/M_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/M_files/out.CAT.contig2classification.txt -o /path/to/samples/M_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

##### for N samples
mkdir -p /path/to/samples/N_files/
cd /path/to/samples/N_files/

CAT contigs -n 60 -c /path/to/samples/N_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/N_files/out.CAT.ORF2LCA.txt -o /path/to/samples/N_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/N_files/out.CAT.ORF2LCA.txt -o /path/to/samples/N_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/N_files/out.CAT.contig2classification.txt -o /path/to/samples/N_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

##### for O samples
mkdir -p /path/to/samples/O_files/
cd /path/to/samples/O_files/

CAT contigs -n 60 -c /path/to/samples/O_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/O_files/out.CAT.ORF2LCA.txt -o /path/to/samples/O_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/O_files/out.CAT.ORF2LCA.txt -o /path/to/samples/O_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/O_files/out.CAT.contig2classification.txt -o /path/to/samples/O_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

##### for V samples
mkdir -p /path/to/samples/V_files/
cd /path/to/samples/V_files/

CAT contigs -n 60 -c /path/to/samples/V_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/V_files/out.CAT.ORF2LCA.txt -o /path/to/samples/V_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/V_files/out.CAT.ORF2LCA.txt -o /path/to/samples/V_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/V_files/out.CAT.contig2classification.txt -o /path/to/samples/V_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

##### for X samples
mkdir -p /path/to/samples/X_files/
cd /path/to/samples/X_files/

CAT contigs -n 60 -c /path/to/samples/X_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/X_files/out.CAT.ORF2LCA.txt -o /path/to/samples/X_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/X_files/out.CAT.ORF2LCA.txt -o /path/to/samples/X_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/X_files/out.CAT.contig2classification.txt -o /path/to/samples/X_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

##### for Z samples
mkdir -p /path/to/samples/Z_files/
cd /path/to/samples/Z_files/

CAT contigs -n 60 -c /path/to/samples/Z_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/Z_files/out.CAT.ORF2LCA.txt -o /path/to/samples/Z_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/Z_files/out.CAT.ORF2LCA.txt -o /path/to/samples/Z_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/Z_files/out.CAT.contig2classification.txt -o /path/to/samples/Z_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/


######################################################################################################################################################################################################################
##### Human samples
######################################################################################################################################################################################################################
##### for 16T106 samples
mkdir -p /path/to/samples/16T106_files/
cd /path/to/samples/16T106_files/

CAT contigs -n 60 -c /path/to/samples/16T106_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/16T106_files/out.CAT.ORF2LCA.txt -o /path/to/samples/16T106_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/16T106_files/out.CAT.ORF2LCA.txt -o /path/to/samples/16T106_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/16T106_files/out.CAT.contig2classification.txt -o /path/to/samples/16T106_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

##### for 16TM29 samples
mkdir -p /path/to/samples/16TM29_files/
cd /path/to/samples/16TM29_files/

CAT contigs -n 60 -c /path/to/samples/16TM29_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/16TM29_files/out.CAT.ORF2LCA.txt -o /path/to/samples/16TM29_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/16TM29_files/out.CAT.ORF2LCA.txt -o /path/to/samples/16TM29_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/16TM29_files/out.CAT.contig2classification.txt -o /path/to/samples/16TM29_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

##### for 27T0 samples
mkdir -p /path/to/samples/27T0_files/
cd /path/to/samples/27T0_files/

CAT contigs -n 60 -c /path/to/samples/27T0_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/27T0_files/out.CAT.ORF2LCA.txt -o /path/to/samples/27T0_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/27T0_files/out.CAT.ORF2LCA.txt -o /path/to/samples/27T0_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/27T0_files/out.CAT.contig2classification.txt -o /path/to/samples/27T0_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

##### for 27T39 samples
mkdir -p /path/to/samples/27T39_files/
cd /path/to/samples/27T39_files/

CAT contigs -n 60 -c /path/to/samples/27T39_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/27T39_files/out.CAT.ORF2LCA.txt -o /path/to/samples/27T39_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/27T39_files/out.CAT.ORF2LCA.txt -o /path/to/samples/27T39_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/27T39_files/out.CAT.contig2classification.txt -o /path/to/samples/27T39_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

##### for 28T0 samples
mkdir -p /path/to/samples/28T0_files/
cd /path/to/samples/28T0_files/

CAT contigs -n 60 -c /path/to/samples/28T0_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/28T0_files/out.CAT.ORF2LCA.txt -o /path/to/samples/28T0_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/28T0_files/out.CAT.ORF2LCA.txt -o /path/to/samples/28T0_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/28T0_files/out.CAT.contig2classification.txt -o /path/to/samples/28T0_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

##### for 28T52 samples

mkdir -p /path/to/samples/28T52_files/
cd /path/to/samples/28T52_files/

CAT contigs -n 60 -c /path/to/samples/28T52_files/megaHIT_res_fin/final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ 
CAT add_names -i /path/to/samples/28T52_files/out.CAT.ORF2LCA.txt -o /path/to/samples/28T52_files/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i /path/to/samples/28T52_files/out.CAT.ORF2LCA.txt -o /path/to/samples/28T52_files/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i /path/to/samples/28T52_files/out.CAT.contig2classification.txt -o /path/to/samples/28T52_files/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/



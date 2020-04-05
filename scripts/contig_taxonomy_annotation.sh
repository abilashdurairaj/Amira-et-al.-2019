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
#### CAT database preparation:
# CAT prepare --existing -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

hm_dr=$1
######################################################################################################################################################################################################################
##### Mouse samples
######################################################################################################################################################################################################################

############ N_CAT/:
mkdir -p ${hm_dr}megaHIT_contigs/N_CAT/
cd ${hm_dr}megaHIT_contigs/N_CAT/
CAT contigs -c ${hm_dr}megaHIT_contigs/N_final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/N_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/N_CAT/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/N_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/N_CAT/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i ${hm_dr}megaHIT_contigs/N_CAT/out.CAT.contig2classification.txt -o ${hm_dr}megaHIT_contigs/N_CAT/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/


############ M_CAT/:
mkdir -p ${hm_dr}megaHIT_contigs/M_CAT/
cd ${hm_dr}megaHIT_contigs/M_CAT/

CAT contigs -c ${hm_dr}megaHIT_contigs/M_final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/M_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/M_CAT/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/M_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/M_CAT/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i ${hm_dr}megaHIT_contigs/M_CAT/out.CAT.contig2classification.txt -o ${hm_dr}megaHIT_contigs/M_CAT/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

############ O_CAT/:
mkdir -p ${hm_dr}megaHIT_contigs/O_CAT/
cd ${hm_dr}megaHIT_contigs/O_CAT/

CAT contigs -c ${hm_dr}megaHIT_contigs/O_final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/O_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/O_CAT/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/O_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/O_CAT/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i ${hm_dr}megaHIT_contigs/O_CAT/out.CAT.contig2classification.txt -o ${hm_dr}megaHIT_contigs/O_CAT/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/


############ V_CAT/:
mkdir -p ${hm_dr}megaHIT_contigs/V_CAT/
cd ${hm_dr}megaHIT_contigs/V_CAT/
CAT contigs -c ${hm_dr}megaHIT_contigs/V_final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/V_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/V_CAT/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/V_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/V_CAT/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i ${hm_dr}megaHIT_contigs/V_CAT/out.CAT.contig2classification.txt -o ${hm_dr}megaHIT_contigs/V_CAT/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/


############ X_CAT/:
mkdir -p ${hm_dr}megaHIT_contigs/X_CAT/
cd ${hm_dr}megaHIT_contigs/X_CAT/

CAT contigs -c ${hm_dr}megaHIT_contigs/X_final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/X_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/X_CAT/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/X_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/X_CAT/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i ${hm_dr}megaHIT_contigs/X_CAT/out.CAT.contig2classification.txt -o ${hm_dr}megaHIT_contigs/X_CAT/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/

############ Z_CAT/:
mkdir -p ${hm_dr}megaHIT_contigs/Z_CAT/
cd ${hm_dr}megaHIT_contigs/Z_CAT/

CAT contigs -c ${hm_dr}megaHIT_contigs/Z_final.contigs.fa -d /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_CAT_database/ -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/Z_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/Z_CAT/contig_CAT_output -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/
CAT add_names -i ${hm_dr}megaHIT_contigs/Z_CAT/out.CAT.ORF2LCA.txt -o ${hm_dr}megaHIT_contigs/Z_CAT/contig_CAT_output_official -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/ --only_official
CAT add_names -i ${hm_dr}megaHIT_contigs/Z_CAT/out.CAT.contig2classification.txt -o ${hm_dr}megaHIT_contigs/Z_CAT/out.CAT.contig2classification_names.txt -t /path/to/Tools/CAT-master/CAT_prepare_20181212/2018-12-12_taxonomy/


cat ${hm_dr}megaHIT_contigs/N_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/N_CAT_out.CAT.contig2classification_names_tax.txt 
cat ${hm_dr}megaHIT_contigs/O_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/O_CAT_out.CAT.contig2classification_names_tax.txt 
cat ${hm_dr}megaHIT_contigs/M_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/M_CAT_out.CAT.contig2classification_names_tax.txt 
cat ${hm_dr}megaHIT_contigs/V_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/V_CAT_out.CAT.contig2classification_names_tax.txt 
cat ${hm_dr}megaHIT_contigs/X_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/X_CAT_out.CAT.contig2classification_names_tax.txt 
cat ${hm_dr}megaHIT_contigs/Z_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/Z_CAT_out.CAT.contig2classification_names_tax.txt 

cat ${hm_dr}megaHIT_contigs/16T106_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/16T106_CAT_out.CAT.contig2classification_names_tax.txt 
cat ${hm_dr}megaHIT_contigs/16TM29_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/16TM29_CAT_out.CAT.contig2classification_names_tax.txt 
cat ${hm_dr}megaHIT_contigs/27T0_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/27T0_CAT_out.CAT.contig2classification_names_tax.txt 
cat ${hm_dr}megaHIT_contigs/27T39_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/27T39_CAT_out.CAT.contig2classification_names_tax.txt 
cat ${hm_dr}megaHIT_contigs/28T0_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/28T0_CAT_out.CAT.contig2classification_names_tax.txt 
cat ${hm_dr}megaHIT_contigs/28T52_CAT_out.CAT.contig2classification.txt | cut --complement -f2-6 >  ${hm_dr}megaHIT_contigs/28T52_CAT_out.CAT.contig2classification_names_tax.txt 



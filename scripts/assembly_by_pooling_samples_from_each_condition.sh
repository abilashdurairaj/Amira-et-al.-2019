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
export PATH=/path/to/Tools/megahit-1.1.3/:/path/to/Tools/prodigal-2.6.3-1/bin/:/path/to/Tools/Spades/SPAdes-3.13.0-Linux/bin/:/path/to/gcc-8.2.0/bin/:/path/to/Tools/subread-1.6.2/bin/:/path/to/Tools/bbmap/:/path/to/Tools/jre1.8.0_191/bin/:/path/to/Tools/seqtk-master/:/path/to/Python-3.7.0b5/:/path/to/Tools/kneaddata/:/path/to/Tools/trimmomatic-master/*:/path/to/Tools/tophat-2.1.1.Linux_x86_64/:/path/to/Tools/bowtie2-2.2.9:/path/to/Tools/hisat2-2.1.0/:/path/to/Tools/bbmap/:$PATH

hm_dr=$1

mkdir -p mkdir -p ${hm_dr}megaHIT_contigs/
mkdir -p ${hm_dr}M_files/
mkdir -p ${hm_dr}N_files/
mkdir -p ${hm_dr}O_files/
mkdir -p ${hm_dr}V_files/
mkdir -p ${hm_dr}X_files/
mkdir -p ${hm_dr}Z_files/
mkdir -p ${hm_dr}16T106_files/
mkdir -p ${hm_dr}16TM29_files/
mkdir -p ${hm_dr}28T0_files/
mkdir -p ${hm_dr}28T52_files/
mkdir -p ${hm_dr}27T0_files/
mkdir -p ${hm_dr}27T39_files/

######################################################################################################################################################################################################################
##### Mouse samples: Pool reads from biological replicates belonging to same condition and assemble them into contigs using megaHIT
######################################################################################################################################################################################################################
###### For M
megahit -1 ${hm_dr}M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 ${hm_dr}M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o ${hm_dr}M_files/megaHIT_res_fin 

cp ${hm_dr}M_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/M_final.contigs.fa

###### For N
megahit -1 ${hm_dr}N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 ${hm_dr}N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o ${hm_dr}N_files/megaHIT_res_fin 

cp ${hm_dr}N_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/N_final.contigs.fa

###### For O
megahit -1 ${hm_dr}O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 ${hm_dr}O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o ${hm_dr}O_files/megaHIT_res_fin 

cp ${hm_dr}O_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/O_final.contigs.fa

###### For V
megahit -1 ${hm_dr}V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 ${hm_dr}V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o ${hm_dr}V_files/megaHIT_res_fin 

cp ${hm_dr}V_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/V_final.contigs.fa

###### For X
megahit -1 ${hm_dr}X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 ${hm_dr}X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o ${hm_dr}X_files/megaHIT_res_fin 

cp ${hm_dr}X_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/X_final.contigs.fa

###### For Z
megahit -1 ${hm_dr}Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 ${hm_dr}Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o ${hm_dr}Z_files/megaHIT_res_fin 

cp ${hm_dr}Z_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/Z_final.contigs.fa

######################################################################################################################################################################################################################
##### Human samples: Pool reads from technical replicates belonging to same condition and assemble them into contigs using megaHIT
######################################################################################################################################################################################################################
###### For 16T106
megahit -1 ${hm_dr}16T106_S20/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}16T106_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}16T106_S20/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}16T106_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o ${hm_dr}16T106_files/megaHIT_res_fin 

cp ${hm_dr}16T106_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/16T106_final.contigs.fa

###### For 16TM29
megahit -1 ${hm_dr}16TM29_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}16TM29_S21/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}16TM29_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}16TM29_S21/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o ${hm_dr}16TM29_files/megaHIT_res_fin 

cp ${hm_dr}16TM29_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/16TM29_final.contigs.fa


###### For 27T0
megahit -1 ${hm_dr}27T0_S19/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}27T0_S19/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o ${hm_dr}27T0_files/megaHIT_res_fin 

cp ${hm_dr}27T0_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/27T0_final.contigs.fa


###### For 27T39
megahit -1 ${hm_dr}27T39_S23/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}27T39_S23/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o ${hm_dr}27T39_files/megaHIT_res_fin 

cp ${hm_dr}27T39_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/27T39_final.contigs.fa

###### For 28T0
megahit -1 ${hm_dr}28T0_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}28T0_S22/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}28T0_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}28T0_S22/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o ${hm_dr}28T0_files/megaHIT_res_fin 


cp ${hm_dr}28T0_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/28T0_final.contigs.fa

###### For 28T52
megahit -1 ${hm_dr}28T52_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,${hm_dr}28T52_S24/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 ${hm_dr}28T52_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,${hm_dr}28T52_S24/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o ${hm_dr}28T52_files/megaHIT_res_fin 


cp ${hm_dr}28T52_files/megaHIT_res_fin/final.contigs.fa ${hm_dr}megaHIT_contigs/28T52_final.contigs.fa

######################################################################################################################################################################################################################

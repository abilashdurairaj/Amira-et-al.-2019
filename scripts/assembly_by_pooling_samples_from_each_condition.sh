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
export PATH=/path/to/Tools/megahit-1.1.3/:/path/to/Tools/prodigal-2.6.3-1/bin/:/path/to/Tools/Spades/SPAdes-3.13.0-Linux/bin/:/home/comi/abilash.durai/gcc-8.2.0/bin/:/path/to/Tools/subread-1.6.2/bin/:/path/to/Tools/bbmap/:/path/to/Tools/jre1.8.0_191/bin/:/path/to/Tools/seqtk-master/:/home/comi/abilash.durai/Python-3.7.0b5/:/path/to/Tools/kneaddata/:/path/to/Tools/trimmomatic-master/*:/path/to/Tools/tophat-2.1.1.Linux_x86_64/:/path/to/Tools/bowtie2-2.2.9:/path/to/Tools/hisat2-2.1.0/:/path/to/Tools/kraken2-2.0.7-new/:/naslx/projects/pr74xe/di52yal/Tools/bbmap/:$PATH

######################################################################################################################################################################################################################
##### Mouse samples
######################################################################################################################################################################################################################
###### For M
megahit -1 /path/to/samples/M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /path/to/samples/M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /path/to/samples/M_files/megaHIT_res_fin 

###### For N
megahit -1 /path/to/samples/N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /path/to/samples/N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /path/to/samples/N_files/megaHIT_res_fin 

###### For O
megahit -1 /path/to/samples/O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /path/to/samples/O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /path/to/samples/O_files/megaHIT_res_fin 


###### For V
megahit -1 /path/to/samples/V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /path/to/samples/V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /path/to/samples/V_files/megaHIT_res_fin 


###### For X
megahit -1 /path/to/samples/X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /path/to/samples/X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /path/to/samples/X_files/megaHIT_res_fin 


###### For Z
megahit -1 /path/to/samples/Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /path/to/samples/Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /path/to/samples/Z_files/megaHIT_res_fin 

######################################################################################################################################################################################################################
##### Human samples
######################################################################################################################################################################################################################
###### For 16T106
megahit -1 /path/to/samples/16T106_S20/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/16T106_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/samples/16T106_S20/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/16T106_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /path/to/samples/16T106_files/megaHIT_res_fin 


###### For 16TM29
megahit -1 /path/to/samples/16TM29_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/16TM29_S21/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/samples/16TM29_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/16TM29_S21/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /path/to/samples/16TM29_files/megaHIT_res_fin 



###### For 27T0
megahit -1 /path/to/samples/27T0_S19/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/samples/27T0_S19/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /path/to/samples/27T0_files/megaHIT_res_fin 


###### For 27T39
megahit -1 /path/to/samples/27T39_S23/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/samples/27T39_S23/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /path/to/samples/27T39_files/megaHIT_res_fin 


###### For 28T0
megahit -1 /path/to/samples/28T0_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/28T0_S22/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/samples/28T0_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/28T0_S22/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /path/to/samples/28T0_files/megaHIT_res_fin 


###### For 28T52
megahit -1 /path/to/samples/28T52_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/path/to/samples/28T52_S24/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /path/to/samples/28T52_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/path/to/samples/28T52_S24/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /path/to/samples/28T52_files/megaHIT_res_fin 

######################################################################################################################################################################################################################

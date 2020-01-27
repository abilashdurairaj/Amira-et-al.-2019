#!/bin/bash -e
#$ -l arch=linux-x64
#$ -b n
#$ -q all.q
#$ -i /dev/null
#$ -e /project/genomics/Abilash/log_output/
#$ -o /project/genomics/Abilash/log_output/
#$ -cwd
#$ -l vf=3G


export JAVA_HOME=/project/genomics/Abilash/Tools/jre1.8.0_191/bin/
export PATH=/project/genomics/Abilash/Tools/megahit-1.1.3/:/project/genomics/Abilash/Tools/prodigal-2.6.3-1/bin/:/project/genomics/Abilash/Tools/Spades/SPAdes-3.13.0-Linux/bin/:/home/comi/abilash.durai/gcc-8.2.0/bin/:/project/genomics/Abilash/Tools/subread-1.6.2/bin/:/project/genomics/Abilash/Tools/bbmap/:/project/genomics/Abilash/Tools/jre1.8.0_191/bin/:/project/genomics/Abilash/Tools/seqtk-master/:/home/comi/abilash.durai/Python-3.7.0b5/:/project/genomics/Abilash/Tools/kneaddata/:/project/genomics/Abilash/Tools/trimmomatic-master/*:/project/genomics/Abilash/Tools/tophat-2.1.1.Linux_x86_64/:/project/genomics/Abilash/Tools/bowtie2-2.2.9:/project/genomics/Abilash/Tools/hisat2-2.1.0/:/project/genomics/Abilash/Tools/kraken2-2.0.7-new/:/naslx/projects/pr74xe/di52yal/Tools/bbmap/:$PATH

######################################################################################################################################################################################################################
##### Mouse samples
######################################################################################################################################################################################################################
###### For M
megahit -1 /project/genomics/Abilash/Amira/M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /project/genomics/Abilash/Amira/M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /project/genomics/Abilash/Amira/M_files/megaHIT_res_fin 

###### For N
megahit -1 /project/genomics/Abilash/Amira/N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /project/genomics/Abilash/Amira/N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /project/genomics/Abilash/Amira/N_files/megaHIT_res_fin 

###### For O
megahit -1 /project/genomics/Abilash/Amira/O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /project/genomics/Abilash/Amira/O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /project/genomics/Abilash/Amira/O_files/megaHIT_res_fin 


###### For V
megahit -1 /project/genomics/Abilash/Amira/V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /project/genomics/Abilash/Amira/V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /project/genomics/Abilash/Amira/V_files/megaHIT_res_fin 


###### For X
megahit -1 /project/genomics/Abilash/Amira/X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /project/genomics/Abilash/Amira/X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /project/genomics/Abilash/Amira/X_files/megaHIT_res_fin 


###### For Z
megahit -1 /project/genomics/Abilash/Amira/Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /project/genomics/Abilash/Amira/Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 \
 -t 60 -o /project/genomics/Abilash/Amira/Z_files/megaHIT_res_fin 

######################################################################################################################################################################################################################
##### Human samples
######################################################################################################################################################################################################################
###### For 16T106
megahit -1 /project/genomics/Abilash/Amira/16T106_S20/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/16T106_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /project/genomics/Abilash/Amira/16T106_S20/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/16T106_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /project/genomics/Abilash/Amira/16T106_files/megaHIT_res_fin 


###### For 16TM29
megahit -1 /project/genomics/Abilash/Amira/16TM29_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/16TM29_S21/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /project/genomics/Abilash/Amira/16TM29_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/16TM29_S21/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /project/genomics/Abilash/Amira/16TM29_files/megaHIT_res_fin 



###### For 27T0
megahit -1 /project/genomics/Abilash/Amira/27T0_S19/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /project/genomics/Abilash/Amira/27T0_S19/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /project/genomics/Abilash/Amira/27T0_files/megaHIT_res_fin 


###### For 27T39
megahit -1 /project/genomics/Abilash/Amira/27T39_S23/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /project/genomics/Abilash/Amira/27T39_S23/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /project/genomics/Abilash/Amira/27T39_files/megaHIT_res_fin 


###### For 28T0
megahit -1 /project/genomics/Abilash/Amira/28T0_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/28T0_S22/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /project/genomics/Abilash/Amira/28T0_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/28T0_S22/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /project/genomics/Abilash/Amira/28T0_files/megaHIT_res_fin 


###### For 28T52
megahit -1 /project/genomics/Abilash/Amira/28T52_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1,/project/genomics/Abilash/Amira/28T52_S24/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 \
 -2 /project/genomics/Abilash/Amira/28T52_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2,/project/genomics/Abilash/Amira/28T52_S24/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -t 60 -o /project/genomics/Abilash/Amira/28T52_files/megaHIT_res_fin 

######################################################################################################################################################################################################################

#!/bin/bash -e
#$ -l arch=linux-x64
#$ -b n
#$ -q all.q
#$ -i /dev/null
#$ -e /path/to/log/error/
#$ -o /path/to/log/output/
#$ -cwd
#$ -l vf=3G
#$ -t 1-4

##### export latest GCC version to the LD_LIBRARY_PATH variable and jave run environment to JAVA_HOME variable
export JAVA_HOME=/path/to/java/jre1.8.0_191/bin/
export LD_LIBRARY_PATH=/path/to/gcc_latest/gcc-xx.xx.xx/libstdc++-v3/:${LD_LIBRARY_PATH}


### hh    : path where the fastq.gz files are located
### hm_dr : path where to store output files 
# hh=/path/to/fastq_files/
# hm_dr=/path/to/store/data/

hh=$1
hm_dr=$2

### STRING2: variable storing the sampleIDs
mapfile -t STRING2 < <(ls ${hh}*.fastq.gz ' | sed 's|.*/||g' | sed 's/_.*//g') 

bash /path/to/scripts/QC_File_job.sh ${STRING2[$SGE_TASK_ID-1]} ${hm_dr} ${hh}

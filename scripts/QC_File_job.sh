#!/bin/bash -e
#$ -l arch=linux-x64
#$ -b n
#$ -q all.q
#$ -i /dev/null
#$ -e /path/to/log/error/
#$ -o /path/to/log/output/
#$ -cwd
#$ -l vf=3G


##### export latest GCC version to the LD_LIBRARY_PATH variable and jave run environment to JAVA_HOME variable
export JAVA_HOME=/path/to/java/jre1.8.0_191/bin/
export LD_LIBRARY_PATH=/path/to/gcc_latest/gcc-xx.xx.xx/libstdc++-v3/:${LD_LIBRARY_PATH}
export PATH=/path/to/Tools/gcc-8.2.0/:/path/to/Tools/jre1.8.0_191/bin/:/path/to/Tools/Python-3.7.0b5/:/path/to/Tools/trimmomatic-master/*:/path/to/Tools/sortmerna-2.1b/:/path/to/Tools/sortmerna-2.1b/scripts/:/path/to/Tools/tophat-2.1.1.Linux_x86_64/:/path/to/Tools/bowtie2-2.2.9:/path/to/Tools/hisat2-2.1.0/:$PATH


####### I/P
unq_id=$1
hm_dr=$2
hh=$3
prefix=$unq_id

######## Prefix for all the new folders/files to be made 
loc=${hm_dr}${prefix}

######## I/P fastq file to be unzipped.
R1=${loc}_R1_001.fastq
R2=${loc}_R2_001.fastq

######## Make necessary folders
mkdir -p $loc
mkdir -p $loc/PE
mkdir -p $loc/PE/mouse_nonrRNA_90;
mkdir -p $loc/PE/human_nonrRNA_90;


if [ ! -f  "$R1" ]; then 
    zcat "${hh}${unq_id}_R1_001.fastq.gz" > $R1 ; 
else 
    echo "skipping $R1"
fi


if [ ! -f  "$R2" ]; then 
    zcat "${hh}${unq_id}_R2_001.fastq.gz" > $R2 ; 
else 
    echo "skipping $R2"
fi




#########################################################################################################################
## Quality Control: Trimmomatic
#########################################################################################################################
java -jar /path/to/Tools/trimmomatic-master/bin/trimmomatic.jar PE -threads 60 -phred33 -trimlog $loc/triallog  $R1 $R2  $loc/R1_paired_90_${unq_id}.fq $loc/R1_unpaired_90_${unq_id}.fq $loc/R2_paired_90_${unq_id}.fq $loc/R2_unpaired_90_${unq_id}.fq ILLUMINACLIP:/path/to/Tools/trimmomatic-master/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 MAXINFO:30:0.4  MINLEN:90 


#########################################################################################################################
## Remove rRNAs: sortmeRNA
#########################################################################################################################
## merge paired-end reads:
bash merge-paired-reads.sh $loc/R1_paired_90_${unq_id}.fq $loc/R2_paired_90_${unq_id}.fq $loc/merged_90_${unq_id}.fq

echo "## Create reference for SILVA_132 databases just once. If done once, then this command can be ignored!"

indexdb_rna --ref /path/to/DB/SILVA_132/SILVA_132_SSURef_tax_silva_trunc.fasta,/path/to/DB/SILVA_132/SILVA_132_SSURef_tax_silva_trunc_db:\
 /path/to/DB/SILVA_132/SILVA_132_LSURef_tax_silva_trunc.fasta,/path/to/DB/SILVA_132/SILVA_132_LSURef_tax_silva_trunc_db 


sortmerna --ref /path/to/DB/SILVA_132/SILVA_132_SSURef_tax_silva_trunc.fasta,/path/to/DB/SILVA_132/SILVA_132_SSURef_tax_silva_trunc_db:/path/to/DB/SILVA_132/SILVA_132_LSURef_tax_silva_trunc.fasta,/path/to/DB/SILVA_132/SILVA_132_LSURef_tax_silva_trunc_db:/path/to/DB/SILVA_132/UNITE_public_01.12.2017.fasta,/path/to/DB/SILVA_132/UNITE_public_01.12.2017-db --reads $loc/merged_90_${unq_id}.fq   --paired_out --best 1 --fastx --sam --SQ --log --aligned $loc/merged_rRNA_90_${unq_id} --other $loc/merged_nonrRNA_90_${unq_id} -a 40 -v
	
## unmerge paired end reads:	 
bash unmerge-paired-reads.sh $loc/merged_nonrRNA_90_${unq_id}.fq $loc/merged_R1_90_${unq_id}.fq $loc/merged_R2_90_${unq_id}.fq

#########################################################################################################################
## Remove host reads: HISAT2
#########################################################################################################################

## Download Human and Mouse genomes and PhiX contaminants from Illumina site
mkdir -p /path/to/Tools/hisat2-2.1.0/Mus_musculus_genome/
cd /path/to/Tools/hisat2-2.1.0/Mus_musculus_genome/
wget http://igenomes.illumina.com.s3-website-us-east-1.amazonaws.com/Mus_musculus/NCBI/GRCm38/Mus_musculus_NCBI_GRCm38.tar.gz

mkdir -p /path/to/Tools/hisat2-2.1.0/Human_genome/
cd /path/to/Tools/hisat2-2.1.0/Human_genome/
wget http://igenomes.illumina.com.s3-website-us-east-1.amazonaws.com/Homo_sapiens/NCBI/GRCh38/Homo_sapiens_NCBI_GRCh38.tar.gz

mkdir -p /path/to/DB/
cd /path/to/DB/
wget http://igenomes.illumina.com.s3-website-us-east-1.amazonaws.com/PhiX/Illumina/RTA/PhiX_Illumina_RTA.tar.gz
## Building index for HiSAT2
cd /path/to/Tools/hisat2-2.1.0/Mus_musculus_genome/
hisat2-build /path/to/DB/Mus_musculus_genome/Mus_musculus/NCBI/GRCm38/Sequence/WholeGenomeFasta/genome.fa Mus_musculus

cd /path/to/Tools/hisat2-2.1.0/Human_genome/
hisat2-build /path/to/DB/Human_genome/Homo_sapiens/NCBI/GRCh38/Sequence/WholeGenomeFasta/genome.fa Homo_sapiens

## Align against Human genome and remove:
cd /path/to/Tools/hisat2-2.1.0/Human_genome/
hisat2  -p 40 -q -1 $loc/merged_R1_90_${unq_id}.fq -2 $loc/merged_R2_90_${unq_id}.fq --un-conc $loc/PE/human_nonrRNA_90/ -x Homo_sapiens -S $loc/PE/human_nonrRNA_90/reads_aligned.sam


## Align against Mouse genome and remove:
cd /path/to/Tools/hisat2-2.1.0/Mus_musculus_genome/
hisat2  -p 40 -1 $loc/PE/human_nonrRNA_90/un-conc-mate.1 -2 $loc/PE/human_nonrRNA_90/un-conc-mate.2 --un-conc $loc/PE/mouse_nonrRNA_90/ -x Mus_musculus -S $loc/PE/mouse_nonrRNA_90/reads_aligned.sam

#########################################################################################################################
## Remove phiX contaminants: bowtie2
#########################################################################################################################

mkdir -p $loc/PE/mouse_nonrRNA_90/phiX_removal_al/
mkdir -p $loc/PE/mouse_nonrRNA_90/phiX_removal_un/

bowtie2  -x /path/to/DB/PhiX/Illumina/RTA/Sequence/Bowtie2Index/genome -q -1  $loc/PE/mouse_nonrRNA_90/un-conc-mate.1 -2  $loc/PE/mouse_nonrRNA_90/un-conc-mate.2 --un-conc $loc/PE/mouse_nonrRNA_90/phiX_removal_un/ --al-conc $loc/PE/mouse_nonrRNA_90/phiX_removal_al/ -S  $loc/PE/mouse_nonrRNA_90/phiX_removal_al/PhiX_aligned.sam



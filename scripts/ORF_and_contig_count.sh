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
##### for M samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/M_files/;


############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/M_files/megaHIT_res_fin/M_genes_contigs path=/path/to/samples/contigs_list/M_files/
bbmap.sh ref=/path/to/samples/M_files/megaHIT_res_fin/M_genes_contig_seq.fasta path=/path/to/samples/contigs_list/M_files/



bbmap.sh in1=/path/to/samples/M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/M_files/ outm=/path/to/samples/contigs_list/M1_S1_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/M1_S1_mapped.sam > /path/to/samples/contigs_list/M1_S1_mapped.bam
samtools sort  /path/to/samples/contigs_list/M1_S1_mapped.bam -o /path/to/samples/contigs_list/M1_S1_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/M1_S1_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/M1_S1_mapped_count_bbmap
cat /path/to/samples/contigs_list/M1_S1_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/M1_S1_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/M1_S1_mapped.sam
rm -f /path/to/samples/contigs_list/M1_S1_mapped.bam
rm -f /path/to/samples/contigs_list/M1_S1_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/M_files/ outm=/path/to/samples/contigs_list/M2_S2_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/M2_S2_mapped.sam > /path/to/samples/contigs_list/M2_S2_mapped.bam
samtools sort  /path/to/samples/contigs_list/M2_S2_mapped.bam -o /path/to/samples/contigs_list/M2_S2_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/M2_S2_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/M2_S2_mapped_count_bbmap
cat /path/to/samples/contigs_list/M2_S2_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/M2_S2_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/M2_S2_mapped.sam
rm -f /path/to/samples/contigs_list/M2_S2_mapped.bam
rm -f /path/to/samples/contigs_list/M2_S2_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/M_files/ outm=/path/to/samples/contigs_list/M3_S3_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/M3_S3_mapped.sam > /path/to/samples/contigs_list/M3_S3_mapped.bam
samtools sort  /path/to/samples/contigs_list/M3_S3_mapped.bam -o /path/to/samples/contigs_list/M3_S3_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/M3_S3_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/M3_S3_mapped_count_bbmap
cat /path/to/samples/contigs_list/M3_S3_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/M3_S3_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/M3_S3_mapped.sam
rm -f /path/to/samples/contigs_list/M3_S3_mapped.bam
rm -f /path/to/samples/contigs_list/M3_S3_mapped_count_bbmap
rm -rf /path/to/samples/contigs_list/M_files/ref/


##### for N samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/N_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/N_files/megaHIT_res_fin/N_genes_contigs path=/path/to/samples/contigs_list/N_files/
bbmap.sh ref=/path/to/samples/N_files/megaHIT_res_fin/N_genes_contig_seq.fasta path=/path/to/samples/contigs_list/N_files/



bbmap.sh in1=/path/to/samples/N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/N_files/ outm=/path/to/samples/contigs_list/N4_S4_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/N4_S4_mapped.sam > /path/to/samples/contigs_list/N4_S4_mapped.bam
samtools sort  /path/to/samples/contigs_list/N4_S4_mapped.bam -o /path/to/samples/contigs_list/N4_S4_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/N4_S4_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/N4_S4_mapped_count_bbmap
cat /path/to/samples/contigs_list/N4_S4_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/N4_S4_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/N4_S4_mapped.sam
rm -f /path/to/samples/contigs_list/N4_S4_mapped.bam
rm -f /path/to/samples/contigs_list/N4_S4_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/N_files/ outm=/path/to/samples/contigs_list/N5_S5_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/N5_S5_mapped.sam > /path/to/samples/contigs_list/N5_S5_mapped.bam
samtools sort  /path/to/samples/contigs_list/N5_S5_mapped.bam -o /path/to/samples/contigs_list/N5_S5_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/N5_S5_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/N5_S5_mapped_count_bbmap
cat /path/to/samples/contigs_list/N5_S5_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/N5_S5_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/N5_S5_mapped.sam
rm -f /path/to/samples/contigs_list/N5_S5_mapped.bam
rm -f /path/to/samples/contigs_list/N5_S5_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/N_files/ outm=/path/to/samples/contigs_list/N6_S6_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/N6_S6_mapped.sam > /path/to/samples/contigs_list/N6_S6_mapped.bam
samtools sort  /path/to/samples/contigs_list/N6_S6_mapped.bam -o /path/to/samples/contigs_list/N6_S6_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/N6_S6_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/N6_S6_mapped_count_bbmap
cat /path/to/samples/contigs_list/N6_S6_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/N6_S6_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/N6_S6_mapped.sam
rm -f /path/to/samples/contigs_list/N6_S6_mapped.bam
rm -f /path/to/samples/contigs_list/N6_S6_mapped_count_bbmap
rm -rf /path/to/samples/contigs_list/N_files/ref/

##### for O samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/O_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/O_files/megaHIT_res_fin/O_genes_contigs path=/path/to/samples/contigs_list/O_files/
bbmap.sh ref=/path/to/samples/O_files/megaHIT_res_fin/O_genes_contig_seq.fasta path=/path/to/samples/contigs_list/O_files/



bbmap.sh in1=/path/to/samples/O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/O_files/ outm=/path/to/samples/contigs_list/O1_S7_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/O1_S7_mapped.sam > /path/to/samples/contigs_list/O1_S7_mapped.bam
samtools sort  /path/to/samples/contigs_list/O1_S7_mapped.bam -o /path/to/samples/contigs_list/O1_S7_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/O1_S7_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/O1_S7_mapped_count_bbmap
cat /path/to/samples/contigs_list/O1_S7_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/O1_S7_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/O1_S7_mapped.sam
rm -f /path/to/samples/contigs_list/O1_S7_mapped.bam
rm -f /path/to/samples/contigs_list/O1_S7_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/O_files/ outm=/path/to/samples/contigs_list/O2_S8_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/O2_S8_mapped.sam > /path/to/samples/contigs_list/O2_S8_mapped.bam
samtools sort  /path/to/samples/contigs_list/O2_S8_mapped.bam -o /path/to/samples/contigs_list/O2_S8_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/O2_S8_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/O2_S8_mapped_count_bbmap
cat /path/to/samples/contigs_list/O2_S8_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/O2_S8_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/O2_S8_mapped.sam
rm -f /path/to/samples/contigs_list/O2_S8_mapped.bam
rm -f /path/to/samples/contigs_list/O2_S8_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/O_files/ outm=/path/to/samples/contigs_list/O3_S9_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/O3_S9_mapped.sam > /path/to/samples/contigs_list/O3_S9_mapped.bam
samtools sort  /path/to/samples/contigs_list/O3_S9_mapped.bam -o /path/to/samples/contigs_list/O3_S9_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/O3_S9_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/O3_S9_mapped_count_bbmap
cat /path/to/samples/contigs_list/O3_S9_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/O3_S9_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/O3_S9_mapped.sam
rm -f /path/to/samples/contigs_list/O3_S9_mapped.bam
rm -f /path/to/samples/contigs_list/O3_S9_mapped_count_bbmap
rm -rf /path/to/samples/contigs_list/O_files/ref/


##### for V samples
mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/V_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/V_files/megaHIT_res_fin/V_genes_contigs path=/path/to/samples/contigs_list/V_files/
bbmap.sh ref=/path/to/samples/V_files/megaHIT_res_fin/V_genes_contig_seq.fasta path=/path/to/samples/contigs_list/V_files/



bbmap.sh in1=/path/to/samples/V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/V_files/ outm=/path/to/samples/contigs_list/V1_S10_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/V1_S10_mapped.sam > /path/to/samples/contigs_list/V1_S10_mapped.bam
samtools sort  /path/to/samples/contigs_list/V1_S10_mapped.bam -o /path/to/samples/contigs_list/V1_S10_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/V1_S10_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/V1_S10_mapped_count_bbmap
cat /path/to/samples/contigs_list/V1_S10_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/V1_S10_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/V1_S10_mapped.sam
rm -f /path/to/samples/contigs_list/V1_S10_mapped.bam
rm -f /path/to/samples/contigs_list/V1_S10_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/V_files/ outm=/path/to/samples/contigs_list/V4_S12_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/V4_S12_mapped.sam > /path/to/samples/contigs_list/V4_S12_mapped.bam
samtools sort  /path/to/samples/contigs_list/V4_S12_mapped.bam -o /path/to/samples/contigs_list/V4_S12_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/V4_S12_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/V4_S12_mapped_count_bbmap
cat /path/to/samples/contigs_list/V4_S12_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/V4_S12_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/V4_S12_mapped.sam
rm -f /path/to/samples/contigs_list/V4_S12_mapped.bam
rm -f /path/to/samples/contigs_list/V4_S12_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/V_files/ outm=/path/to/samples/contigs_list/V6_S11_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/V6_S11_mapped.sam > /path/to/samples/contigs_list/V6_S11_mapped.bam
samtools sort  /path/to/samples/contigs_list/V6_S11_mapped.bam -o /path/to/samples/contigs_list/V6_S11_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/V6_S11_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/V6_S11_mapped_count_bbmap
cat /path/to/samples/contigs_list/V6_S11_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/V6_S11_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/V6_S11_mapped.sam
rm -f /path/to/samples/contigs_list/V6_S11_mapped.bam
rm -f /path/to/samples/contigs_list/V6_S11_mapped_count_bbmap
rm -rf /path/to/samples/contigs_list/V_files/ref/


##### for X samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/X_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/X_files/megaHIT_res_fin/X_genes_contigs path=/path/to/samples/contigs_list/X_files/
bbmap.sh ref=/path/to/samples/X_files/megaHIT_res_fin/X_genes_contig_seq.fasta path=/path/to/samples/contigs_list/X_files/



bbmap.sh in1=/path/to/samples/X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/X_files/ outm=/path/to/samples/contigs_list/X1_S13_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/X1_S13_mapped.sam > /path/to/samples/contigs_list/X1_S13_mapped.bam
samtools sort  /path/to/samples/contigs_list/X1_S13_mapped.bam -o /path/to/samples/contigs_list/X1_S13_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/X1_S13_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/X1_S13_mapped_count_bbmap
cat /path/to/samples/contigs_list/X1_S13_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/X1_S13_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/X1_S13_mapped.sam
rm -f /path/to/samples/contigs_list/X1_S13_mapped.bam
rm -f /path/to/samples/contigs_list/X1_S13_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/X_files/ outm=/path/to/samples/contigs_list/X2_S14_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/X2_S14_mapped.sam > /path/to/samples/contigs_list/X2_S14_mapped.bam
samtools sort  /path/to/samples/contigs_list/X2_S14_mapped.bam -o /path/to/samples/contigs_list/X2_S14_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/X2_S14_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/X2_S14_mapped_count_bbmap
cat /path/to/samples/contigs_list/X2_S14_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/X2_S14_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/X2_S14_mapped.sam
rm -f /path/to/samples/contigs_list/X2_S14_mapped.bam
rm -f /path/to/samples/contigs_list/X2_S14_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/X_files/ outm=/path/to/samples/contigs_list/X4_S15_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/X4_S15_mapped.sam > /path/to/samples/contigs_list/X4_S15_mapped.bam
samtools sort  /path/to/samples/contigs_list/X4_S15_mapped.bam -o /path/to/samples/contigs_list/X4_S15_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/X4_S15_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/X4_S15_mapped_count_bbmap
cat /path/to/samples/contigs_list/X4_S15_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/X4_S15_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/X4_S15_mapped.sam
rm -f /path/to/samples/contigs_list/X4_S15_mapped.bam
rm -f /path/to/samples/contigs_list/X4_S15_mapped_count_bbmap
rm -rf /path/to/samples/contigs_list/X_files/ref/



##### for Z samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/Z_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/Z_files/megaHIT_res_fin/Z_genes_contigs path=/path/to/samples/contigs_list/Z_files/
bbmap.sh ref=/path/to/samples/Z_files/megaHIT_res_fin/Z_genes_contig_seq.fasta path=/path/to/samples/contigs_list/Z_files/



bbmap.sh in1=/path/to/samples/Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/Z_files/ outm=/path/to/samples/contigs_list/Z2_S16_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/Z2_S16_mapped.sam > /path/to/samples/contigs_list/Z2_S16_mapped.bam
samtools sort  /path/to/samples/contigs_list/Z2_S16_mapped.bam -o /path/to/samples/contigs_list/Z2_S16_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/Z2_S16_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/Z2_S16_mapped_count_bbmap
cat /path/to/samples/contigs_list/Z2_S16_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/Z2_S16_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/Z2_S16_mapped.sam
rm -f /path/to/samples/contigs_list/Z2_S16_mapped.bam
rm -f /path/to/samples/contigs_list/Z2_S16_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/Z_files/ outm=/path/to/samples/contigs_list/Z3_S17_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/Z3_S17_mapped.sam > /path/to/samples/contigs_list/Z3_S17_mapped.bam
samtools sort  /path/to/samples/contigs_list/Z3_S17_mapped.bam -o /path/to/samples/contigs_list/Z3_S17_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/Z3_S17_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/Z3_S17_mapped_count_bbmap
cat /path/to/samples/contigs_list/Z3_S17_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/Z3_S17_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/Z3_S17_mapped.sam
rm -f /path/to/samples/contigs_list/Z3_S17_mapped.bam
rm -f /path/to/samples/contigs_list/Z3_S17_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/Z_files/ outm=/path/to/samples/contigs_list/Z4_S18_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/Z4_S18_mapped.sam > /path/to/samples/contigs_list/Z4_S18_mapped.bam
samtools sort  /path/to/samples/contigs_list/Z4_S18_mapped.bam -o /path/to/samples/contigs_list/Z4_S18_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/Z4_S18_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/Z4_S18_mapped_count_bbmap
cat /path/to/samples/contigs_list/Z4_S18_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/Z4_S18_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/Z4_S18_mapped.sam
rm -f /path/to/samples/contigs_list/Z4_S18_mapped.bam
rm -f /path/to/samples/contigs_list/Z4_S18_mapped_count_bbmap
rm -rf /path/to/samples/contigs_list/Z_files/ref/



##### for 16T106 samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/16T106_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/16T106_files/megaHIT_res_fin/16T106_genes_contigs path=/path/to/samples/contigs_list/16T106_files/
bbmap.sh ref=/path/to/samples/16T106_files/megaHIT_res_fin/16T106_genes_contig_seq.fasta path=/path/to/samples/contigs_list/16T106_files/



bbmap.sh in1=/path/to/samples/16T106_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/16T106_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/16T106_files/ outm=/path/to/samples/contigs_list/16T106_S1_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/16T106_S1_mapped.sam > /path/to/samples/contigs_list/16T106_S1_mapped.bam
samtools sort  /path/to/samples/contigs_list/16T106_S1_mapped.bam -o /path/to/samples/contigs_list/16T106_S1_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/16T106_S1_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/16T106_S1_mapped_count_bbmap
cat /path/to/samples/contigs_list/16T106_S1_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/16T106_S1_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/16T106_S1_mapped.sam
rm -f /path/to/samples/contigs_list/16T106_S1_mapped.bam
rm -f /path/to/samples/contigs_list/16T106_S1_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/16T106_S20/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/16T106_S20/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/16T106_files/ outm=/path/to/samples/contigs_list/16T106_S20_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/16T106_S20_mapped.sam > /path/to/samples/contigs_list/16T106_S20_mapped.bam
samtools sort  /path/to/samples/contigs_list/16T106_S20_mapped.bam -o /path/to/samples/contigs_list/16T106_S20_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/16T106_S20_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/16T106_S20_mapped_count_bbmap
cat /path/to/samples/contigs_list/16T106_S20_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/16T106_S20_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/16T106_S20_mapped.sam
rm -f /path/to/samples/contigs_list/16T106_S20_mapped.bam
rm -f /path/to/samples/contigs_list/16T106_S20_mapped_count_bbmap



##### for 16TM29 samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/16TM29_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/16TM29_files/megaHIT_res_fin/16TM29_genes_contigs path=/path/to/samples/contigs_list/16TM29_files/
bbmap.sh ref=/path/to/samples/16TM29_files/megaHIT_res_fin/16TM29_genes_contig_seq.fasta path=/path/to/samples/contigs_list/16TM29_files/



bbmap.sh in1=/path/to/samples/16TM29_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/16TM29_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/16TM29_files/ outm=/path/to/samples/contigs_list/16TM29_S2_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/16TM29_S2_mapped.sam > /path/to/samples/contigs_list/16TM29_S2_mapped.bam
samtools sort  /path/to/samples/contigs_list/16TM29_S2_mapped.bam -o /path/to/samples/contigs_list/16TM29_S2_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/16TM29_S2_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/16TM29_S2_mapped_count_bbmap
cat /path/to/samples/contigs_list/16TM29_S2_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/16TM29_S2_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/16TM29_S2_mapped.sam
rm -f /path/to/samples/contigs_list/16TM29_S2_mapped.bam
rm -f /path/to/samples/contigs_list/16TM29_S2_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/16TM29_S21/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/16TM29_S21/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/16TM29_files/ outm=/path/to/samples/contigs_list/16TM29_S21_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/16TM29_S21_mapped.sam > /path/to/samples/contigs_list/16TM29_S21_mapped.bam
samtools sort  /path/to/samples/contigs_list/16TM29_S21_mapped.bam -o /path/to/samples/contigs_list/16TM29_S21_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/16TM29_S21_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/16TM29_S21_mapped_count_bbmap
cat /path/to/samples/contigs_list/16TM29_S21_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/16TM29_S21_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/16TM29_S21_mapped.sam
rm -f /path/to/samples/contigs_list/16TM29_S21_mapped.bam
rm -f /path/to/samples/contigs_list/16TM29_S21_mapped_count_bbmap



##### for 27T0 samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/27T0_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/27T0_files/megaHIT_res_fin/27T0_genes_contigs path=/path/to/samples/contigs_list/27T0_files/
bbmap.sh ref=/path/to/samples/27T0_files/megaHIT_res_fin/27T0_genes_contig_seq.fasta path=/path/to/samples/contigs_list/27T0_files/



bbmap.sh in1=/path/to/samples/27T0_S19/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/27T0_S19/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/27T0_files/ outm=/path/to/samples/contigs_list/27T0_S19_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/27T0_S19_mapped.sam > /path/to/samples/contigs_list/27T0_S19_mapped.bam
samtools sort  /path/to/samples/contigs_list/27T0_S19_mapped.bam -o /path/to/samples/contigs_list/27T0_S19_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/27T0_S19_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/27T0_S19_mapped_count_bbmap
cat /path/to/samples/contigs_list/27T0_S19_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/27T0_S19_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/27T0_S19_mapped.sam
rm -f /path/to/samples/contigs_list/27T0_S19_mapped.bam
rm -f /path/to/samples/contigs_list/27T0_S19_mapped_count_bbmap



##### for 27T39 samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/27T39_files/;
bbmap.sh ref=/path/to/samples/27T39_files/megaHIT_res_fin/27T39_genes_contigs path=/path/to/samples/contigs_list/27T39_files/
bbmap.sh ref=/path/to/samples/27T39_files/megaHIT_res_fin/27T39_genes_contig_seq.fasta path=/path/to/samples/contigs_list/27T39_files/


bbmap.sh in1=/path/to/samples/27T39_S23/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/27T39_S23/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/27T39_files/ outm=/path/to/samples/contigs_list/27T39_S23_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/27T39_S23_mapped.sam > /path/to/samples/contigs_list/27T39_S23_mapped.bam
samtools sort  /path/to/samples/contigs_list/27T39_S23_mapped.bam -o /path/to/samples/contigs_list/27T39_S23_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/27T39_S23_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/27T39_S23_mapped_count_bbmap
cat /path/to/samples/contigs_list/27T39_S23_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/27T39_S23_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/27T39_S23_mapped.sam
rm -f /path/to/samples/contigs_list/27T39_S23_mapped.bam
rm -f /path/to/samples/contigs_list/27T39_S23_mapped_count_bbmap




##### for 28T0 samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/28T0_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/28T0_files/megaHIT_res_fin/28T0_genes_contigs path=/path/to/samples/contigs_list/28T0_files/
bbmap.sh ref=/path/to/samples/28T0_files/megaHIT_res_fin/28T0_genes_contig_seq.fasta path=/path/to/samples/contigs_list/28T0_files/


bbmap.sh in1=/path/to/samples/28T0_S22/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/28T0_S22/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/28T0_files/ outm=/path/to/samples/contigs_list/28T0_S22_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/28T0_S22_mapped.sam > /path/to/samples/contigs_list/28T0_S22_mapped.bam
samtools sort  /path/to/samples/contigs_list/28T0_S22_mapped.bam -o /path/to/samples/contigs_list/28T0_S22_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/28T0_S22_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/28T0_S22_mapped_count_bbmap
cat /path/to/samples/contigs_list/28T0_S22_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/28T0_S22_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/28T0_S22_mapped.sam
rm -f /path/to/samples/contigs_list/28T0_S22_mapped.bam
rm -f /path/to/samples/contigs_list/28T0_S22_mapped_count_bbmap


bbmap.sh in1=/path/to/samples/28T0_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/28T0_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/28T0_files/ outm=/path/to/samples/contigs_list/28T0_S3_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/28T0_S3_mapped.sam > /path/to/samples/contigs_list/28T0_S3_mapped.bam
samtools sort  /path/to/samples/contigs_list/28T0_S3_mapped.bam -o /path/to/samples/contigs_list/28T0_S3_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/28T0_S3_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/28T0_S3_mapped_count_bbmap
cat /path/to/samples/contigs_list/28T0_S3_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/28T0_S3_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/28T0_S3_mapped.sam
rm -f /path/to/samples/contigs_list/28T0_S3_mapped.bam
rm -f /path/to/samples/contigs_list/28T0_S3_mapped_count_bbmap


##### for 28T52 samples

mkdir -p /path/to/samples/contigs_list/;
mkdir -p /path/to/samples/contigs_list/28T52_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=/path/to/samples/28T52_files/megaHIT_res_fin/28T52_genes_contigs path=/path/to/samples/contigs_list/28T52_files/
bbmap.sh ref=/path/to/samples/28T52_files/megaHIT_res_fin/28T52_genes_contig_seq.fasta path=/path/to/samples/contigs_list/28T52_files/


bbmap.sh in1=/path/to/samples/28T52_S24/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/28T52_S24/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/28T52_files/ outm=/path/to/samples/contigs_list/28T52_S24_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/28T52_S24_mapped.sam > /path/to/samples/contigs_list/28T52_S24_mapped.bam
samtools sort  /path/to/samples/contigs_list/28T52_S24_mapped.bam -o /path/to/samples/contigs_list/28T52_S24_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/28T52_S24_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/28T52_S24_mapped_count_bbmap
cat /path/to/samples/contigs_list/28T52_S24_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/28T52_S24_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/28T52_S24_mapped.sam
rm -f /path/to/samples/contigs_list/28T52_S24_mapped.bam
rm -f /path/to/samples/contigs_list/28T52_S24_mapped_count_bbmap



bbmap.sh in1=/path/to/samples/28T52_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=/path/to/samples/28T52_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=/path/to/samples/contigs_list/28T52_files/ outm=/path/to/samples/contigs_list/28T52_S4_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS /path/to/samples/contigs_list/28T52_S4_mapped.sam > /path/to/samples/contigs_list/28T52_S4_mapped.bam
samtools sort  /path/to/samples/contigs_list/28T52_S4_mapped.bam -o /path/to/samples/contigs_list/28T52_S4_mapped_sorted.bam
samtools view -@ 20 /path/to/samples/contigs_list/28T52_S4_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > /path/to/samples/contigs_list/28T52_S4_mapped_count_bbmap
cat /path/to/samples/contigs_list/28T52_S4_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > /path/to/samples/contigs_list/28T52_S4_mapped_count_bbmap_fin

rm -f /path/to/samples/contigs_list/28T52_S4_mapped.sam
rm -f /path/to/samples/contigs_list/28T52_S4_mapped.bam
rm -f /path/to/samples/contigs_list/28T52_S4_mapped_count_bbmap


###### coding gene sequence length:
## ls /path/to/samples/*_files/megaHIT_res_fin/* | grep '_contig_seq.fasta' : prints the files with entire path

for file in ` ls /path/to/samples/*_files/megaHIT_res_fin/* | grep '_contig_seq.fasta'`
do

sffx=$(echo $file | sed 's|.*/||g' | sed 's/_genes.*//g')
cat $file | awk '$0 ~ ">" {print c; c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }'  | sed 's/ .*\t/\t/g' > /path/to/samples/contigs_list/${sffx}_geneLen
### code for calculating gene length taken from https://www.danielecook.com/generate-fasta-sequence-lengths/

done

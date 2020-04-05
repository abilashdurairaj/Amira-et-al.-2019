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
export PATH=/path/to/Tools/megahit-1.1.3/:/path/to/Tools/prodigal-2.6.3-1/bin/:/path/to/gcc-8.2.0/bin/:/path/to/Tools/bbmap/:/path/to/Tools/jre1.8.0_191/bin/:/path/to/Tools/seqtk-master/:/path/to/Python-3.7.0b5/:/path/to/Tools/trimmomatic-master/*:/path/to/Tools/bowtie2-2.2.9:/path/to/Tools/hisat2-2.1.0/:/path/to/Tools/bbmap/:$PATH
hm_dr=$1
mkdir -p ${hm_dr}megaHIT_contig_count/

###### Contig count:
######################################################################################################################################################################################################################
##### Mouse samples
######################################################################################################################################################################################################################

bowtie2-build ${hm_dr}megaHIT_contigs/X_final.contigs.fa ${hm_dr}megaHIT_contig_count/X_ref --threads 40
bowtie2 -x ${hm_dr}megaHIT_contig_count/X_ref -1 ${hm_dr}X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/X1_S13_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/X1_S13_mapped.sam > ${hm_dr}megaHIT_contig_count/X1_S13_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/X1_S13_mapped.bam -o ${hm_dr}megaHIT_contig_count/X1_S13_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/X1_S13_sorted.bam > ${hm_dr}megaHIT_contig_count/X1_S13_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/X1_S13_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/X1_S13_count_data_bbmap


bowtie2 -x ${hm_dr}megaHIT_contig_count/X_ref -1 ${hm_dr}X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/X2_S14_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/X2_S14_mapped.sam > ${hm_dr}megaHIT_contig_count/X2_S14_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/X2_S14_mapped.bam -o ${hm_dr}megaHIT_contig_count/X2_S14_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/X2_S14_sorted.bam > ${hm_dr}megaHIT_contig_count/X2_S14_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/X2_S14_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/X2_S14_count_data_bbmap



bowtie2 -x ${hm_dr}megaHIT_contig_count/X_ref -1 ${hm_dr}X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/X4_S15_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/X4_S15_mapped.sam > ${hm_dr}megaHIT_contig_count/X4_S15_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/X4_S15_mapped.bam -o ${hm_dr}megaHIT_contig_count/X4_S15_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/X4_S15_sorted.bam > ${hm_dr}megaHIT_contig_count/X4_S15_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/X4_S15_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/X4_S15_count_data_bbmap


rm -f ${hm_dr}megaHIT_contig_count/X1_S13_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/X1_S13_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/X2_S14_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/X2_S14_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/X4_S15_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/X4_S15_mapped.bam


#### Z files:


bowtie2-build ${hm_dr}megaHIT_contigs/Z_final.contigs.fa ${hm_dr}megaHIT_contig_count/Z_ref --threads 40
bowtie2 -x ${hm_dr}megaHIT_contig_count/Z_ref -1 ${hm_dr}Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/Z2_S16_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/Z2_S16_mapped.sam > ${hm_dr}megaHIT_contig_count/Z2_S16_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/Z2_S16_mapped.bam -o ${hm_dr}megaHIT_contig_count/Z2_S16_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/Z2_S16_sorted.bam > ${hm_dr}megaHIT_contig_count/Z2_S16_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/Z2_S16_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/Z2_S16_count_data_bbmap


bowtie2 -x ${hm_dr}megaHIT_contig_count/Z_ref -1 ${hm_dr}Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/Z3_S17_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/Z3_S17_mapped.sam > ${hm_dr}megaHIT_contig_count/Z3_S17_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/Z3_S17_mapped.bam -o ${hm_dr}megaHIT_contig_count/Z3_S17_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/Z3_S17_sorted.bam > ${hm_dr}megaHIT_contig_count/Z3_S17_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/Z3_S17_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/Z3_S17_count_data_bbmap



bowtie2 -x ${hm_dr}megaHIT_contig_count/Z_ref -1 ${hm_dr}Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/Z4_S18_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/Z4_S18_mapped.sam > ${hm_dr}megaHIT_contig_count/Z4_S18_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/Z4_S18_mapped.bam -o ${hm_dr}megaHIT_contig_count/Z4_S18_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/Z4_S18_sorted.bam > ${hm_dr}megaHIT_contig_count/Z4_S18_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/Z4_S18_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/Z4_S18_count_data_bbmap


rm -f ${hm_dr}megaHIT_contig_count/Z2_S16_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/Z2_S16_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/Z3_S17_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/Z3_S17_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/Z4_S18_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/Z4_S18_mapped.bam


#### V files:

bowtie2-build ${hm_dr}megaHIT_contigs/V_final.contigs.fa ${hm_dr}megaHIT_contig_count/V_ref --threads 40
bowtie2 -x ${hm_dr}megaHIT_contig_count/V_ref -1 ${hm_dr}V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/V1_S10_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/V1_S10_mapped.sam > ${hm_dr}megaHIT_contig_count/V1_S10_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/V1_S10_mapped.bam -o ${hm_dr}megaHIT_contig_count/V1_S10_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/V1_S10_sorted.bam > ${hm_dr}megaHIT_contig_count/V1_S10_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/V1_S10_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/V1_S10_count_data_bbmap


bowtie2 -x ${hm_dr}megaHIT_contig_count/V_ref -1 ${hm_dr}V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/V4_S12_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/V4_S12_mapped.sam > ${hm_dr}megaHIT_contig_count/V4_S12_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/V4_S12_mapped.bam -o ${hm_dr}megaHIT_contig_count/V4_S12_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/V4_S12_sorted.bam > ${hm_dr}megaHIT_contig_count/V4_S12_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/V4_S12_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/V4_S12_count_data_bbmap



bowtie2 -x ${hm_dr}megaHIT_contig_count/V_ref -1 ${hm_dr}V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/V6_S11_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/V6_S11_mapped.sam > ${hm_dr}megaHIT_contig_count/V6_S11_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/V6_S11_mapped.bam -o ${hm_dr}megaHIT_contig_count/V6_S11_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/V6_S11_sorted.bam > ${hm_dr}megaHIT_contig_count/V6_S11_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/V6_S11_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/V6_S11_count_data_bbmap


rm -f ${hm_dr}megaHIT_contig_count/V1_S10_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/V1_S10_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/V4_S12_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/V4_S12_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/V6_S11_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/V6_S11_mapped.bam


##### M files


bowtie2-build ${hm_dr}megaHIT_contigs/M_final.contigs.fa ${hm_dr}megaHIT_contig_count/M_ref --threads 40
bowtie2 -x ${hm_dr}megaHIT_contig_count/M_ref -1 ${hm_dr}M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/M1_S1_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/M1_S1_mapped.sam > ${hm_dr}megaHIT_contig_count/M1_S1_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/M1_S1_mapped.bam -o ${hm_dr}megaHIT_contig_count/M1_S1_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/M1_S1_sorted.bam > ${hm_dr}megaHIT_contig_count/M1_S1_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/M1_S1_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/M1_S1_count_data_bbmap


bowtie2 -x ${hm_dr}megaHIT_contig_count/M_ref -1 ${hm_dr}M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/M2_S2_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/M2_S2_mapped.sam > ${hm_dr}megaHIT_contig_count/M2_S2_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/M2_S2_mapped.bam -o ${hm_dr}megaHIT_contig_count/M2_S2_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/M2_S2_sorted.bam > ${hm_dr}megaHIT_contig_count/M2_S2_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/M2_S2_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/M2_S2_count_data_bbmap



bowtie2 -x ${hm_dr}megaHIT_contig_count/M_ref -1 ${hm_dr}M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/M3_S3_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/M3_S3_mapped.sam > ${hm_dr}megaHIT_contig_count/M3_S3_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/M3_S3_mapped.bam -o ${hm_dr}megaHIT_contig_count/M3_S3_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/M3_S3_sorted.bam > ${hm_dr}megaHIT_contig_count/M3_S3_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/M3_S3_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/M3_S3_count_data_bbmap


rm -f ${hm_dr}megaHIT_contig_count/M1_S1_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/M1_S1_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/M2_S2_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/M2_S2_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/M3_S3_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/M3_S3_mapped.bam


##### N files


bowtie2-build ${hm_dr}megaHIT_contigs/N_final.contigs.fa ${hm_dr}megaHIT_contig_count/N_ref --threads 40
bowtie2 -x ${hm_dr}megaHIT_contig_count/N_ref -1 ${hm_dr}N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/N4_S4_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/N4_S4_mapped.sam > ${hm_dr}megaHIT_contig_count/N4_S4_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/N4_S4_mapped.bam -o ${hm_dr}megaHIT_contig_count/N4_S4_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/N4_S4_sorted.bam > ${hm_dr}megaHIT_contig_count/N4_S4_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/N4_S4_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/N4_S4_count_data_bbmap


bowtie2 -x ${hm_dr}megaHIT_contig_count/N_ref -1 ${hm_dr}N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/N5_S5_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/N5_S5_mapped.sam > ${hm_dr}megaHIT_contig_count/N5_S5_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/N5_S5_mapped.bam -o ${hm_dr}megaHIT_contig_count/N5_S5_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/N5_S5_sorted.bam > ${hm_dr}megaHIT_contig_count/N5_S5_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/N5_S5_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/N5_S5_count_data_bbmap



bowtie2 -x ${hm_dr}megaHIT_contig_count/N_ref -1 ${hm_dr}N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/N6_S6_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/N6_S6_mapped.sam > ${hm_dr}megaHIT_contig_count/N6_S6_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/N6_S6_mapped.bam -o ${hm_dr}megaHIT_contig_count/N6_S6_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/N6_S6_sorted.bam > ${hm_dr}megaHIT_contig_count/N6_S6_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/N6_S6_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/N6_S6_count_data_bbmap


rm -f ${hm_dr}megaHIT_contig_count/N4_S4_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/N4_S4_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/N5_S5_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/N5_S5_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/N6_S6_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/N6_S6_mapped.bam


###### O files


bowtie2-build ${hm_dr}megaHIT_contigs/O_final.contigs.fa ${hm_dr}megaHIT_contig_count/O_ref --threads 40
bowtie2 -x ${hm_dr}megaHIT_contig_count/O_ref -1 ${hm_dr}O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/O1_S7_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/O1_S7_mapped.sam > ${hm_dr}megaHIT_contig_count/O1_S7_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/O1_S7_mapped.bam -o ${hm_dr}megaHIT_contig_count/O1_S7_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/O1_S7_sorted.bam > ${hm_dr}megaHIT_contig_count/O1_S7_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/O1_S7_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/O1_S7_count_data_bbmap


bowtie2 -x ${hm_dr}megaHIT_contig_count/O_ref -1 ${hm_dr}O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/O2_S8_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/O2_S8_mapped.sam > ${hm_dr}megaHIT_contig_count/O2_S8_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/O2_S8_mapped.bam -o ${hm_dr}megaHIT_contig_count/O2_S8_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/O2_S8_sorted.bam > ${hm_dr}megaHIT_contig_count/O2_S8_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/O2_S8_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/O2_S8_count_data_bbmap



bowtie2 -x ${hm_dr}megaHIT_contig_count/O_ref -1 ${hm_dr}O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 ${hm_dr}O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S ${hm_dr}megaHIT_contig_count/O3_S9_mapped.sam --threads 40

samtools view -@ 40 -bS ${hm_dr}megaHIT_contig_count/O3_S9_mapped.sam > ${hm_dr}megaHIT_contig_count/O3_S9_mapped.bam
samtools sort  ${hm_dr}megaHIT_contig_count/O3_S9_mapped.bam -o ${hm_dr}megaHIT_contig_count/O3_S9_sorted.bam
samtools index -@ 40 ${hm_dr}megaHIT_contig_count/O3_S9_sorted.bam > ${hm_dr}megaHIT_contig_count/O3_S9_sorted.bam.bai 
samtools view -@ 40 ${hm_dr}megaHIT_contig_count/O3_S9_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/O3_S9_count_data_bbmap


rm -f ${hm_dr}megaHIT_contig_count/O1_S7_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/O1_S7_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/O2_S8_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/O2_S8_mapped.bam
rm -f ${hm_dr}megaHIT_contig_count/O3_S9_mapped.sam
rm -f ${hm_dr}megaHIT_contig_count/O3_S9_mapped.bam

for file in `ls ${hm_dr}megaHIT_contig_count/ | grep '_bbmap$'`
do

cat ${hm_dr}megaHIT_contig_count/${file} | awk '$1=$1' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}megaHIT_contig_count/${file}_final
done



######## ORF count:

######################################################################################################################################################################################################################
##### Mouse samples
######################################################################################################################################################################################################################
##### for M samples

mkdir -p ${hm_dr}orf_count/;
mkdir -p ${hm_dr}orf_count/M_files/;


############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/M_genes_contig_seq.fasta path=${hm_dr}orf_count/M_files/

bbmap.sh in1=${hm_dr}M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/M_files/ outm=${hm_dr}orf_count/M1_S1_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/M1_S1_mapped.sam > ${hm_dr}orf_count/M1_S1_mapped.bam
samtools sort  ${hm_dr}orf_count/M1_S1_mapped.bam -o ${hm_dr}orf_count/M1_S1_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/M1_S1_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/M1_S1_mapped_count_bbmap
cat ${hm_dr}orf_count/M1_S1_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/M1_S1_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/M1_S1_mapped.sam
rm -f ${hm_dr}orf_count/M1_S1_mapped.bam
rm -f ${hm_dr}orf_count/M1_S1_mapped_count_bbmap


bbmap.sh in1=${hm_dr}M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/M_files/ outm=${hm_dr}orf_count/M2_S2_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/M2_S2_mapped.sam > ${hm_dr}orf_count/M2_S2_mapped.bam
samtools sort  ${hm_dr}orf_count/M2_S2_mapped.bam -o ${hm_dr}orf_count/M2_S2_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/M2_S2_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/M2_S2_mapped_count_bbmap
cat ${hm_dr}orf_count/M2_S2_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/M2_S2_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/M2_S2_mapped.sam
rm -f ${hm_dr}orf_count/M2_S2_mapped.bam
rm -f ${hm_dr}orf_count/M2_S2_mapped_count_bbmap


bbmap.sh in1=${hm_dr}M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/M_files/ outm=${hm_dr}orf_count/M3_S3_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/M3_S3_mapped.sam > ${hm_dr}orf_count/M3_S3_mapped.bam
samtools sort  ${hm_dr}orf_count/M3_S3_mapped.bam -o ${hm_dr}orf_count/M3_S3_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/M3_S3_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/M3_S3_mapped_count_bbmap
cat ${hm_dr}orf_count/M3_S3_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/M3_S3_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/M3_S3_mapped.sam
rm -f ${hm_dr}orf_count/M3_S3_mapped.bam
rm -f ${hm_dr}orf_count/M3_S3_mapped_count_bbmap
rm -rf ${hm_dr}orf_count/M_files/ref/


##### for N samples


############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/N_genes_contig_seq.fasta path=${hm_dr}orf_count/N_files/

bbmap.sh in1=${hm_dr}N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/N_files/ outm=${hm_dr}orf_count/N4_S4_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/N4_S4_mapped.sam > ${hm_dr}orf_count/N4_S4_mapped.bam
samtools sort  ${hm_dr}orf_count/N4_S4_mapped.bam -o ${hm_dr}orf_count/N4_S4_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/N4_S4_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/N4_S4_mapped_count_bbmap
cat ${hm_dr}orf_count/N4_S4_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/N4_S4_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/N4_S4_mapped.sam
rm -f ${hm_dr}orf_count/N4_S4_mapped.bam
rm -f ${hm_dr}orf_count/N4_S4_mapped_count_bbmap



bbmap.sh in1=${hm_dr}N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/N_files/ outm=${hm_dr}orf_count/N5_S5_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/N5_S5_mapped.sam > ${hm_dr}orf_count/N5_S5_mapped.bam
samtools sort  ${hm_dr}orf_count/N5_S5_mapped.bam -o ${hm_dr}orf_count/N5_S5_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/N5_S5_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/N5_S5_mapped_count_bbmap
cat ${hm_dr}orf_count/N5_S5_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/N5_S5_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/N5_S5_mapped.sam
rm -f ${hm_dr}orf_count/N5_S5_mapped.bam
rm -f ${hm_dr}orf_count/N5_S5_mapped_count_bbmap



bbmap.sh in1=${hm_dr}N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/N_files/ outm=${hm_dr}orf_count/N6_S6_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/N6_S6_mapped.sam > ${hm_dr}orf_count/N6_S6_mapped.bam
samtools sort  ${hm_dr}orf_count/N6_S6_mapped.bam -o ${hm_dr}orf_count/N6_S6_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/N6_S6_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/N6_S6_mapped_count_bbmap
cat ${hm_dr}orf_count/N6_S6_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/N6_S6_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/N6_S6_mapped.sam
rm -f ${hm_dr}orf_count/N6_S6_mapped.bam
rm -f ${hm_dr}orf_count/N6_S6_mapped_count_bbmap
rm -rf ${hm_dr}orf_count/N_files/ref/

##### for O samples


############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/O_genes_contig_seq.fasta path=${hm_dr}orf_count/O_files/

bbmap.sh in1=${hm_dr}O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/O_files/ outm=${hm_dr}orf_count/O1_S7_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/O1_S7_mapped.sam > ${hm_dr}orf_count/O1_S7_mapped.bam
samtools sort  ${hm_dr}orf_count/O1_S7_mapped.bam -o ${hm_dr}orf_count/O1_S7_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/O1_S7_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/O1_S7_mapped_count_bbmap
cat ${hm_dr}orf_count/O1_S7_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/O1_S7_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/O1_S7_mapped.sam
rm -f ${hm_dr}orf_count/O1_S7_mapped.bam
rm -f ${hm_dr}orf_count/O1_S7_mapped_count_bbmap

bbmap.sh in1=${hm_dr}O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/O_files/ outm=${hm_dr}orf_count/O2_S8_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/O2_S8_mapped.sam > ${hm_dr}orf_count/O2_S8_mapped.bam
samtools sort  ${hm_dr}orf_count/O2_S8_mapped.bam -o ${hm_dr}orf_count/O2_S8_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/O2_S8_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/O2_S8_mapped_count_bbmap
cat ${hm_dr}orf_count/O2_S8_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/O2_S8_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/O2_S8_mapped.sam
rm -f ${hm_dr}orf_count/O2_S8_mapped.bam
rm -f ${hm_dr}orf_count/O2_S8_mapped_count_bbmap

bbmap.sh in1=${hm_dr}O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/O_files/ outm=${hm_dr}orf_count/O3_S9_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/O3_S9_mapped.sam > ${hm_dr}orf_count/O3_S9_mapped.bam
samtools sort  ${hm_dr}orf_count/O3_S9_mapped.bam -o ${hm_dr}orf_count/O3_S9_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/O3_S9_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/O3_S9_mapped_count_bbmap
cat ${hm_dr}orf_count/O3_S9_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/O3_S9_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/O3_S9_mapped.sam
rm -f ${hm_dr}orf_count/O3_S9_mapped.bam
rm -f ${hm_dr}orf_count/O3_S9_mapped_count_bbmap
rm -rf ${hm_dr}orf_count/O_files/ref/


##### for V samples

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/V_genes_contig_seq.fasta path=${hm_dr}orf_count/V_files/

bbmap.sh in1=${hm_dr}V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/V_files/ outm=${hm_dr}orf_count/V1_S10_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/V1_S10_mapped.sam > ${hm_dr}orf_count/V1_S10_mapped.bam
samtools sort  ${hm_dr}orf_count/V1_S10_mapped.bam -o ${hm_dr}orf_count/V1_S10_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/V1_S10_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/V1_S10_mapped_count_bbmap
cat ${hm_dr}orf_count/V1_S10_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/V1_S10_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/V1_S10_mapped.sam
rm -f ${hm_dr}orf_count/V1_S10_mapped.bam
rm -f ${hm_dr}orf_count/V1_S10_mapped_count_bbmap


bbmap.sh in1=${hm_dr}V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/V_files/ outm=${hm_dr}orf_count/V4_S12_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/V4_S12_mapped.sam > ${hm_dr}orf_count/V4_S12_mapped.bam
samtools sort  ${hm_dr}orf_count/V4_S12_mapped.bam -o ${hm_dr}orf_count/V4_S12_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/V4_S12_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/V4_S12_mapped_count_bbmap
cat ${hm_dr}orf_count/V4_S12_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/V4_S12_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/V4_S12_mapped.sam
rm -f ${hm_dr}orf_count/V4_S12_mapped.bam
rm -f ${hm_dr}orf_count/V4_S12_mapped_count_bbmap


bbmap.sh in1=${hm_dr}V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/V_files/ outm=${hm_dr}orf_count/V6_S11_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/V6_S11_mapped.sam > ${hm_dr}orf_count/V6_S11_mapped.bam
samtools sort  ${hm_dr}orf_count/V6_S11_mapped.bam -o ${hm_dr}orf_count/V6_S11_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/V6_S11_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/V6_S11_mapped_count_bbmap
cat ${hm_dr}orf_count/V6_S11_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/V6_S11_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/V6_S11_mapped.sam
rm -f ${hm_dr}orf_count/V6_S11_mapped.bam
rm -f ${hm_dr}orf_count/V6_S11_mapped_count_bbmap
rm -rf ${hm_dr}orf_count/V_files/ref/


##### for X samples


############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/X_genes_contig_seq.fasta path=${hm_dr}orf_count/X_files/


bbmap.sh in1=${hm_dr}X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/X_files/ outm=${hm_dr}orf_count/X1_S13_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/X1_S13_mapped.sam > ${hm_dr}orf_count/X1_S13_mapped.bam
samtools sort  ${hm_dr}orf_count/X1_S13_mapped.bam -o ${hm_dr}orf_count/X1_S13_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/X1_S13_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/X1_S13_mapped_count_bbmap
cat ${hm_dr}orf_count/X1_S13_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/X1_S13_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/X1_S13_mapped.sam
rm -f ${hm_dr}orf_count/X1_S13_mapped.bam
rm -f ${hm_dr}orf_count/X1_S13_mapped_count_bbmap



bbmap.sh in1=${hm_dr}X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/X_files/ outm=${hm_dr}orf_count/X2_S14_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/X2_S14_mapped.sam > ${hm_dr}orf_count/X2_S14_mapped.bam
samtools sort  ${hm_dr}orf_count/X2_S14_mapped.bam -o ${hm_dr}orf_count/X2_S14_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/X2_S14_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/X2_S14_mapped_count_bbmap
cat ${hm_dr}orf_count/X2_S14_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/X2_S14_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/X2_S14_mapped.sam
rm -f ${hm_dr}orf_count/X2_S14_mapped.bam
rm -f ${hm_dr}orf_count/X2_S14_mapped_count_bbmap



bbmap.sh in1=${hm_dr}X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/X_files/ outm=${hm_dr}orf_count/X4_S15_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/X4_S15_mapped.sam > ${hm_dr}orf_count/X4_S15_mapped.bam
samtools sort  ${hm_dr}orf_count/X4_S15_mapped.bam -o ${hm_dr}orf_count/X4_S15_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/X4_S15_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/X4_S15_mapped_count_bbmap
cat ${hm_dr}orf_count/X4_S15_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/X4_S15_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/X4_S15_mapped.sam
rm -f ${hm_dr}orf_count/X4_S15_mapped.bam
rm -f ${hm_dr}orf_count/X4_S15_mapped_count_bbmap
rm -rf ${hm_dr}orf_count/X_files/ref/



##### for Z samples

mkdir -p ${hm_dr}orf_count/;
mkdir -p ${hm_dr}orf_count/Z_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/Z_genes_contig_seq.fasta path=${hm_dr}orf_count/Z_files/

bbmap.sh in1=${hm_dr}Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/Z_files/ outm=${hm_dr}orf_count/Z2_S16_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/Z2_S16_mapped.sam > ${hm_dr}orf_count/Z2_S16_mapped.bam
samtools sort  ${hm_dr}orf_count/Z2_S16_mapped.bam -o ${hm_dr}orf_count/Z2_S16_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/Z2_S16_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/Z2_S16_mapped_count_bbmap
cat ${hm_dr}orf_count/Z2_S16_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/Z2_S16_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/Z2_S16_mapped.sam
rm -f ${hm_dr}orf_count/Z2_S16_mapped.bam
rm -f ${hm_dr}orf_count/Z2_S16_mapped_count_bbmap


bbmap.sh in1=${hm_dr}Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/Z_files/ outm=${hm_dr}orf_count/Z3_S17_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/Z3_S17_mapped.sam > ${hm_dr}orf_count/Z3_S17_mapped.bam
samtools sort  ${hm_dr}orf_count/Z3_S17_mapped.bam -o ${hm_dr}orf_count/Z3_S17_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/Z3_S17_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/Z3_S17_mapped_count_bbmap
cat ${hm_dr}orf_count/Z3_S17_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/Z3_S17_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/Z3_S17_mapped.sam
rm -f ${hm_dr}orf_count/Z3_S17_mapped.bam
rm -f ${hm_dr}orf_count/Z3_S17_mapped_count_bbmap



bbmap.sh in1=${hm_dr}Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/Z_files/ outm=${hm_dr}orf_count/Z4_S18_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/Z4_S18_mapped.sam > ${hm_dr}orf_count/Z4_S18_mapped.bam
samtools sort  ${hm_dr}orf_count/Z4_S18_mapped.bam -o ${hm_dr}orf_count/Z4_S18_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/Z4_S18_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/Z4_S18_mapped_count_bbmap
cat ${hm_dr}orf_count/Z4_S18_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/Z4_S18_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/Z4_S18_mapped.sam
rm -f ${hm_dr}orf_count/Z4_S18_mapped.bam
rm -f ${hm_dr}orf_count/Z4_S18_mapped_count_bbmap
rm -rf ${hm_dr}orf_count/Z_files/ref/



##### for 16T106 samples


############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/16T106_genes_contig_seq.fasta path=${hm_dr}orf_count/16T106_files/


bbmap.sh in1=${hm_dr}16T106_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}16T106_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/16T106_files/ outm=${hm_dr}orf_count/16T106_S1_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/16T106_S1_mapped.sam > ${hm_dr}orf_count/16T106_S1_mapped.bam
samtools sort  ${hm_dr}orf_count/16T106_S1_mapped.bam -o ${hm_dr}orf_count/16T106_S1_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/16T106_S1_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/16T106_S1_mapped_count_bbmap
cat ${hm_dr}orf_count/16T106_S1_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/16T106_S1_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/16T106_S1_mapped.sam
rm -f ${hm_dr}orf_count/16T106_S1_mapped.bam
rm -f ${hm_dr}orf_count/16T106_S1_mapped_count_bbmap



bbmap.sh in1=${hm_dr}16T106_S20/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}16T106_S20/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/16T106_files/ outm=${hm_dr}orf_count/16T106_S20_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/16T106_S20_mapped.sam > ${hm_dr}orf_count/16T106_S20_mapped.bam
samtools sort  ${hm_dr}orf_count/16T106_S20_mapped.bam -o ${hm_dr}orf_count/16T106_S20_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/16T106_S20_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/16T106_S20_mapped_count_bbmap
cat ${hm_dr}orf_count/16T106_S20_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/16T106_S20_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/16T106_S20_mapped.sam
rm -f ${hm_dr}orf_count/16T106_S20_mapped.bam
rm -f ${hm_dr}orf_count/16T106_S20_mapped_count_bbmap



##### for 16TM29 samples

mkdir -p ${hm_dr}orf_count/;
mkdir -p ${hm_dr}orf_count/16TM29_files/;

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/16TM29_genes_contig_seq.fasta path=${hm_dr}orf_count/16TM29_files/



bbmap.sh in1=${hm_dr}16TM29_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}16TM29_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/16TM29_files/ outm=${hm_dr}orf_count/16TM29_S2_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/16TM29_S2_mapped.sam > ${hm_dr}orf_count/16TM29_S2_mapped.bam
samtools sort  ${hm_dr}orf_count/16TM29_S2_mapped.bam -o ${hm_dr}orf_count/16TM29_S2_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/16TM29_S2_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/16TM29_S2_mapped_count_bbmap
cat ${hm_dr}orf_count/16TM29_S2_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/16TM29_S2_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/16TM29_S2_mapped.sam
rm -f ${hm_dr}orf_count/16TM29_S2_mapped.bam
rm -f ${hm_dr}orf_count/16TM29_S2_mapped_count_bbmap



bbmap.sh in1=${hm_dr}16TM29_S21/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}16TM29_S21/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/16TM29_files/ outm=${hm_dr}orf_count/16TM29_S21_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/16TM29_S21_mapped.sam > ${hm_dr}orf_count/16TM29_S21_mapped.bam
samtools sort  ${hm_dr}orf_count/16TM29_S21_mapped.bam -o ${hm_dr}orf_count/16TM29_S21_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/16TM29_S21_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/16TM29_S21_mapped_count_bbmap
cat ${hm_dr}orf_count/16TM29_S21_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/16TM29_S21_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/16TM29_S21_mapped.sam
rm -f ${hm_dr}orf_count/16TM29_S21_mapped.bam
rm -f ${hm_dr}orf_count/16TM29_S21_mapped_count_bbmap



##### for 27T0 samples

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/27T0_genes_contig_seq.fasta path=${hm_dr}orf_count/27T0_files/


bbmap.sh in1=${hm_dr}27T0_S19/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}27T0_S19/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/27T0_files/ outm=${hm_dr}orf_count/27T0_S19_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/27T0_S19_mapped.sam > ${hm_dr}orf_count/27T0_S19_mapped.bam
samtools sort  ${hm_dr}orf_count/27T0_S19_mapped.bam -o ${hm_dr}orf_count/27T0_S19_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/27T0_S19_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/27T0_S19_mapped_count_bbmap
cat ${hm_dr}orf_count/27T0_S19_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/27T0_S19_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/27T0_S19_mapped.sam
rm -f ${hm_dr}orf_count/27T0_S19_mapped.bam
rm -f ${hm_dr}orf_count/27T0_S19_mapped_count_bbmap



##### for 27T39 samples

bbmap.sh ref=${hm_dr}megaHIT_contigs/27T39_genes_contig_seq.fasta path=${hm_dr}orf_count/27T39_files/


bbmap.sh in1=${hm_dr}27T39_S23/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}27T39_S23/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/27T39_files/ outm=${hm_dr}orf_count/27T39_S23_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/27T39_S23_mapped.sam > ${hm_dr}orf_count/27T39_S23_mapped.bam
samtools sort  ${hm_dr}orf_count/27T39_S23_mapped.bam -o ${hm_dr}orf_count/27T39_S23_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/27T39_S23_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/27T39_S23_mapped_count_bbmap
cat ${hm_dr}orf_count/27T39_S23_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/27T39_S23_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/27T39_S23_mapped.sam
rm -f ${hm_dr}orf_count/27T39_S23_mapped.bam
rm -f ${hm_dr}orf_count/27T39_S23_mapped_count_bbmap




##### for 28T0 samples

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/28T0_genes_contig_seq.fasta path=${hm_dr}orf_count/28T0_files/


bbmap.sh in1=${hm_dr}28T0_S22/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}28T0_S22/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/28T0_files/ outm=${hm_dr}orf_count/28T0_S22_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/28T0_S22_mapped.sam > ${hm_dr}orf_count/28T0_S22_mapped.bam
samtools sort  ${hm_dr}orf_count/28T0_S22_mapped.bam -o ${hm_dr}orf_count/28T0_S22_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/28T0_S22_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/28T0_S22_mapped_count_bbmap
cat ${hm_dr}orf_count/28T0_S22_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/28T0_S22_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/28T0_S22_mapped.sam
rm -f ${hm_dr}orf_count/28T0_S22_mapped.bam
rm -f ${hm_dr}orf_count/28T0_S22_mapped_count_bbmap


bbmap.sh in1=${hm_dr}28T0_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}28T0_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/28T0_files/ outm=${hm_dr}orf_count/28T0_S3_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/28T0_S3_mapped.sam > ${hm_dr}orf_count/28T0_S3_mapped.bam
samtools sort  ${hm_dr}orf_count/28T0_S3_mapped.bam -o ${hm_dr}orf_count/28T0_S3_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/28T0_S3_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/28T0_S3_mapped_count_bbmap
cat ${hm_dr}orf_count/28T0_S3_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/28T0_S3_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/28T0_S3_mapped.sam
rm -f ${hm_dr}orf_count/28T0_S3_mapped.bam
rm -f ${hm_dr}orf_count/28T0_S3_mapped_count_bbmap


##### for 28T52 samples

############# Create index for the contigs & the predicted ORFs:
bbmap.sh ref=${hm_dr}megaHIT_contigs/28T52_genes_contig_seq.fasta path=${hm_dr}orf_count/28T52_files/


bbmap.sh in1=${hm_dr}28T52_S24/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}28T52_S24/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/28T52_files/ outm=${hm_dr}orf_count/28T52_S24_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/28T52_S24_mapped.sam > ${hm_dr}orf_count/28T52_S24_mapped.bam
samtools sort  ${hm_dr}orf_count/28T52_S24_mapped.bam -o ${hm_dr}orf_count/28T52_S24_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/28T52_S24_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/28T52_S24_mapped_count_bbmap
cat ${hm_dr}orf_count/28T52_S24_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/28T52_S24_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/28T52_S24_mapped.sam
rm -f ${hm_dr}orf_count/28T52_S24_mapped.bam
rm -f ${hm_dr}orf_count/28T52_S24_mapped_count_bbmap



bbmap.sh in1=${hm_dr}28T52_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 in2=${hm_dr}28T52_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 path=${hm_dr}orf_count/28T52_files/ outm=${hm_dr}orf_count/28T52_S4_mapped.sam sam=1.4 -Xmx20g
samtools view -@ 20 -bS ${hm_dr}orf_count/28T52_S4_mapped.sam > ${hm_dr}orf_count/28T52_S4_mapped.bam
samtools sort  ${hm_dr}orf_count/28T52_S4_mapped.bam -o ${hm_dr}orf_count/28T52_S4_mapped_sorted.bam
samtools view -@ 20 ${hm_dr}orf_count/28T52_S4_mapped_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | awk '$1=$1' > ${hm_dr}orf_count/28T52_S4_mapped_count_bbmap
cat ${hm_dr}orf_count/28T52_S4_mapped_count_bbmap | sed 's/#.*//g' | sed 's/ /\t/g' | sort -k1 -n > ${hm_dr}orf_count/28T52_S4_mapped_count_bbmap_fin

rm -f ${hm_dr}orf_count/28T52_S4_mapped.sam
rm -f ${hm_dr}orf_count/28T52_S4_mapped.bam
rm -f ${hm_dr}orf_count/28T52_S4_mapped_count_bbmap

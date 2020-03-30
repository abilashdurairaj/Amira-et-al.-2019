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

bowtie2-build /path/to/megaHIT_contigs/X_final.contigs.fa /path/to/megaHIT_contig_count_final/X_ref --threads 40
bowtie2 -x /path/to/megaHIT_contig_count_final/X_ref -1 /path/to/X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/X1_S13/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/X1_S13_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/X1_S13_mapped.sam > /path/to/megaHIT_contig_count_final/X1_S13_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/X1_S13_mapped.bam -o /path/to/megaHIT_contig_count_final/X1_S13_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/X1_S13_sorted.bam > /path/to/megaHIT_contig_count_final/X1_S13_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/X1_S13_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/X1_S13_count_data_bbmap


bowtie2 -x /path/to/megaHIT_contig_count_final/X_ref -1 /path/to/X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/X2_S14/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/X2_S14_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/X2_S14_mapped.sam > /path/to/megaHIT_contig_count_final/X2_S14_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/X2_S14_mapped.bam -o /path/to/megaHIT_contig_count_final/X2_S14_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/X2_S14_sorted.bam > /path/to/megaHIT_contig_count_final/X2_S14_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/X2_S14_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/X2_S14_count_data_bbmap



bowtie2 -x /path/to/megaHIT_contig_count_final/X_ref -1 /path/to/X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/X4_S15/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/X4_S15_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/X4_S15_mapped.sam > /path/to/megaHIT_contig_count_final/X4_S15_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/X4_S15_mapped.bam -o /path/to/megaHIT_contig_count_final/X4_S15_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/X4_S15_sorted.bam > /path/to/megaHIT_contig_count_final/X4_S15_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/X4_S15_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/X4_S15_count_data_bbmap


rm -f /path/to/megaHIT_contig_count_final/X1_S13_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/X1_S13_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/X2_S14_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/X2_S14_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/X4_S15_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/X4_S15_mapped.bam


#### Z files:


bowtie2-build /path/to/megaHIT_contigs/Z_final.contigs.fa /path/to/megaHIT_contig_count_final/Z_ref --threads 40
bowtie2 -x /path/to/megaHIT_contig_count_final/Z_ref -1 /path/to/Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/Z2_S16/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/Z2_S16_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/Z2_S16_mapped.sam > /path/to/megaHIT_contig_count_final/Z2_S16_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/Z2_S16_mapped.bam -o /path/to/megaHIT_contig_count_final/Z2_S16_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/Z2_S16_sorted.bam > /path/to/megaHIT_contig_count_final/Z2_S16_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/Z2_S16_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/Z2_S16_count_data_bbmap


bowtie2 -x /path/to/megaHIT_contig_count_final/Z_ref -1 /path/to/Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/Z3_S17/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/Z3_S17_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/Z3_S17_mapped.sam > /path/to/megaHIT_contig_count_final/Z3_S17_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/Z3_S17_mapped.bam -o /path/to/megaHIT_contig_count_final/Z3_S17_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/Z3_S17_sorted.bam > /path/to/megaHIT_contig_count_final/Z3_S17_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/Z3_S17_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/Z3_S17_count_data_bbmap



bowtie2 -x /path/to/megaHIT_contig_count_final/Z_ref -1 /path/to/Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/Z4_S18/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/Z4_S18_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/Z4_S18_mapped.sam > /path/to/megaHIT_contig_count_final/Z4_S18_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/Z4_S18_mapped.bam -o /path/to/megaHIT_contig_count_final/Z4_S18_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/Z4_S18_sorted.bam > /path/to/megaHIT_contig_count_final/Z4_S18_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/Z4_S18_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/Z4_S18_count_data_bbmap


rm -f /path/to/megaHIT_contig_count_final/Z2_S16_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/Z2_S16_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/Z3_S17_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/Z3_S17_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/Z4_S18_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/Z4_S18_mapped.bam



bowtie2-build /path/to/megaHIT_contigs/V_final.contigs.fa /path/to/megaHIT_contig_count_final/V_ref --threads 40
bowtie2 -x /path/to/megaHIT_contig_count_final/V_ref -1 /path/to/V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/V1_S10/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/V1_S10_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/V1_S10_mapped.sam > /path/to/megaHIT_contig_count_final/V1_S10_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/V1_S10_mapped.bam -o /path/to/megaHIT_contig_count_final/V1_S10_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/V1_S10_sorted.bam > /path/to/megaHIT_contig_count_final/V1_S10_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/V1_S10_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/V1_S10_count_data_bbmap


bowtie2 -x /path/to/megaHIT_contig_count_final/V_ref -1 /path/to/V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/V4_S12/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/V4_S12_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/V4_S12_mapped.sam > /path/to/megaHIT_contig_count_final/V4_S12_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/V4_S12_mapped.bam -o /path/to/megaHIT_contig_count_final/V4_S12_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/V4_S12_sorted.bam > /path/to/megaHIT_contig_count_final/V4_S12_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/V4_S12_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/V4_S12_count_data_bbmap



bowtie2 -x /path/to/megaHIT_contig_count_final/V_ref -1 /path/to/V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/V6_S11/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/V6_S11_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/V6_S11_mapped.sam > /path/to/megaHIT_contig_count_final/V6_S11_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/V6_S11_mapped.bam -o /path/to/megaHIT_contig_count_final/V6_S11_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/V6_S11_sorted.bam > /path/to/megaHIT_contig_count_final/V6_S11_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/V6_S11_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/V6_S11_count_data_bbmap


rm -f /path/to/megaHIT_contig_count_final/V1_S10_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/V1_S10_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/V4_S12_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/V4_S12_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/V6_S11_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/V6_S11_mapped.bam


##### M files


bowtie2-build /path/to/megaHIT_contigs/M_final.contigs.fa /path/to/megaHIT_contig_count_final/M_ref --threads 40
bowtie2 -x /path/to/megaHIT_contig_count_final/M_ref -1 /path/to/M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/M1_S1/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/M1_S1_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/M1_S1_mapped.sam > /path/to/megaHIT_contig_count_final/M1_S1_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/M1_S1_mapped.bam -o /path/to/megaHIT_contig_count_final/M1_S1_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/M1_S1_sorted.bam > /path/to/megaHIT_contig_count_final/M1_S1_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/M1_S1_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/M1_S1_count_data_bbmap


bowtie2 -x /path/to/megaHIT_contig_count_final/M_ref -1 /path/to/M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/M2_S2/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/M2_S2_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/M2_S2_mapped.sam > /path/to/megaHIT_contig_count_final/M2_S2_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/M2_S2_mapped.bam -o /path/to/megaHIT_contig_count_final/M2_S2_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/M2_S2_sorted.bam > /path/to/megaHIT_contig_count_final/M2_S2_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/M2_S2_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/M2_S2_count_data_bbmap



bowtie2 -x /path/to/megaHIT_contig_count_final/M_ref -1 /path/to/M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/M3_S3/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/M3_S3_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/M3_S3_mapped.sam > /path/to/megaHIT_contig_count_final/M3_S3_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/M3_S3_mapped.bam -o /path/to/megaHIT_contig_count_final/M3_S3_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/M3_S3_sorted.bam > /path/to/megaHIT_contig_count_final/M3_S3_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/M3_S3_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/M3_S3_count_data_bbmap


rm -f /path/to/megaHIT_contig_count_final/M1_S1_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/M1_S1_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/M2_S2_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/M2_S2_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/M3_S3_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/M3_S3_mapped.bam


##### N files


bowtie2-build /path/to/megaHIT_contigs/N_final.contigs.fa /path/to/megaHIT_contig_count_final/N_ref --threads 40
bowtie2 -x /path/to/megaHIT_contig_count_final/N_ref -1 /path/to/N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/N4_S4/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/N4_S4_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/N4_S4_mapped.sam > /path/to/megaHIT_contig_count_final/N4_S4_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/N4_S4_mapped.bam -o /path/to/megaHIT_contig_count_final/N4_S4_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/N4_S4_sorted.bam > /path/to/megaHIT_contig_count_final/N4_S4_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/N4_S4_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/N4_S4_count_data_bbmap


bowtie2 -x /path/to/megaHIT_contig_count_final/N_ref -1 /path/to/N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/N5_S5/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/N5_S5_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/N5_S5_mapped.sam > /path/to/megaHIT_contig_count_final/N5_S5_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/N5_S5_mapped.bam -o /path/to/megaHIT_contig_count_final/N5_S5_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/N5_S5_sorted.bam > /path/to/megaHIT_contig_count_final/N5_S5_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/N5_S5_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/N5_S5_count_data_bbmap



bowtie2 -x /path/to/megaHIT_contig_count_final/N_ref -1 /path/to/N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/N6_S6/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/N6_S6_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/N6_S6_mapped.sam > /path/to/megaHIT_contig_count_final/N6_S6_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/N6_S6_mapped.bam -o /path/to/megaHIT_contig_count_final/N6_S6_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/N6_S6_sorted.bam > /path/to/megaHIT_contig_count_final/N6_S6_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/N6_S6_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/N6_S6_count_data_bbmap


rm -f /path/to/megaHIT_contig_count_final/N4_S4_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/N4_S4_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/N5_S5_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/N5_S5_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/N6_S6_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/N6_S6_mapped.bam


###### O files


bowtie2-build /path/to/megaHIT_contigs/O_final.contigs.fa /path/to/megaHIT_contig_count_final/O_ref --threads 40
bowtie2 -x /path/to/megaHIT_contig_count_final/O_ref -1 /path/to/O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/O1_S7/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/O1_S7_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/O1_S7_mapped.sam > /path/to/megaHIT_contig_count_final/O1_S7_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/O1_S7_mapped.bam -o /path/to/megaHIT_contig_count_final/O1_S7_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/O1_S7_sorted.bam > /path/to/megaHIT_contig_count_final/O1_S7_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/O1_S7_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/O1_S7_count_data_bbmap


bowtie2 -x /path/to/megaHIT_contig_count_final/O_ref -1 /path/to/O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/O2_S8/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/O2_S8_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/O2_S8_mapped.sam > /path/to/megaHIT_contig_count_final/O2_S8_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/O2_S8_mapped.bam -o /path/to/megaHIT_contig_count_final/O2_S8_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/O2_S8_sorted.bam > /path/to/megaHIT_contig_count_final/O2_S8_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/O2_S8_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/O2_S8_count_data_bbmap



bowtie2 -x /path/to/megaHIT_contig_count_final/O_ref -1 /path/to/O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.1 -2 /path/to/O3_S9/PE/mouse_nonrRNA_90/phiX_removal_un/un-conc-mate.2 -S /path/to/megaHIT_contig_count_final/O3_S9_mapped.sam --threads 40

samtools view -@ 40 -bS /path/to/megaHIT_contig_count_final/O3_S9_mapped.sam > /path/to/megaHIT_contig_count_final/O3_S9_mapped.bam
samtools sort  /path/to/megaHIT_contig_count_final/O3_S9_mapped.bam -o /path/to/megaHIT_contig_count_final/O3_S9_sorted.bam
samtools index -@ 40 /path/to/megaHIT_contig_count_final/O3_S9_sorted.bam > /path/to/megaHIT_contig_count_final/O3_S9_sorted.bam.bai 
samtools view -@ 40 /path/to/megaHIT_contig_count_final/O3_S9_sorted.bam | cut -f1,3|sort | uniq | cut -f2| sort| uniq -c | sed 's/ /\t/g' | sort -k1 -n > /path/to/megaHIT_contig_count_final/O3_S9_count_data_bbmap


rm -f /path/to/megaHIT_contig_count_final/O1_S7_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/O1_S7_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/O2_S8_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/O2_S8_mapped.bam
rm -f /path/to/megaHIT_contig_count_final/O3_S9_mapped.sam
rm -f /path/to/megaHIT_contig_count_final/O3_S9_mapped.bam


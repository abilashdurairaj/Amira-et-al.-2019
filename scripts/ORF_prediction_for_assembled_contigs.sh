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

export PATH=/path/to/Tools/prodigal-2.6.3-1/bin/:/home/comi/abilash.durai/gcc-8.2.0/bin/:/path/to/Tools/subread-1.6.2/bin/:/path/to/Tools/bbmap/:/path/to/Tools/jre1.8.0_191/bin/:/path/to/Tools/seqtk-master/:/home/comi/abilash.durai/Python-3.7.0b5/:/path/to/Tools/kneaddata/:/path/to/Tools/trimmomatic-master/*:/path/to/Tools/tophat-2.1.1.Linux_x86_64/:/path/to/Tools/bowtie2-2.2.9:/path/to/Tools/hisat2-2.1.0/:/path/to/Tools/kraken2-2.0.7-new/:/naslx/projects/pr74xe/di52yal/Tools/bbmap/:$PATH




### For Mouse samples:
prodigal -i /path/to/megaHIT_contigs/M_final.contigs.fa -o /path/to/megaHIT_contigs/M_genes_contigs  -a /path/to/megaHIT_contigs/M_proteins_contigs.faa -p meta -s /path/to/megaHIT_contigs/M_potential_genes -f gff -d /path/to/megaHIT_contigs/M_genes_contig_seq.fasta
prodigal -i /path/to/megaHIT_contigs/N_final.contigs.fa -o /path/to/megaHIT_contigs/N_genes_contigs  -a /path/to/megaHIT_contigs/N_proteins_contigs.faa -p meta -s /path/to/megaHIT_contigs/N_potential_genes -f gff -d /path/to/megaHIT_contigs/N_genes_contig_seq.fasta
prodigal -i /path/to/megaHIT_contigs/O_final.contigs.fa -o /path/to/megaHIT_contigs/O_genes_contigs  -a /path/to/megaHIT_contigs/O_proteins_contigs.faa -p meta -s /path/to/megaHIT_contigs/O_potential_genes -f gff -d /path/to/megaHIT_contigs/O_genes_contig_seq.fasta
prodigal -i /path/to/megaHIT_contigs/V_final.contigs.fa -o /path/to/megaHIT_contigs/V_genes_contigs  -a /path/to/megaHIT_contigs/V_proteins_contigs.faa -p meta -s /path/to/megaHIT_contigs/V_potential_genes -f gff -d /path/to/megaHIT_contigs/V_genes_contig_seq.fasta
prodigal -i /path/to/megaHIT_contigs/X_final.contigs.fa -o /path/to/megaHIT_contigs/X_genes_contigs -a /path/to/megaHIT_contigs/X_proteins_contigs.faa -p meta -s /path/to/megaHIT_contigs/X_potential_genes -f gff -d /path/to/megaHIT_contigs/X_genes_contig_seq.fasta
prodigal -i /path/to/megaHIT_contigs/Z_final.contigs.fa  -o /path/to/megaHIT_contigs/Z_genes_contigs  -a /path/to/megaHIT_contigs/Z_proteins_contigs.faa -p meta -s /path/to/megaHIT_contigs/Z_potential_genes -f gff -d /path/to/megaHIT_contigs/Z_genes_contig_seq.fasta







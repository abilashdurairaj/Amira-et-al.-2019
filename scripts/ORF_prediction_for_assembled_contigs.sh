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
prodigal -i /path/to/samples/M_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/M_files/megaHIT_res_fin/M_genes_contigs  -a /path/to/samples/M_files/megaHIT_res_fin/M_proteins_contigs.faa -p meta -s /path/to/samples/M_files/megaHIT_res_fin/M_potential_genes -f gff -d /path/to/samples/M_files/megaHIT_res_fin/M_genes_contig_seq.fasta
prodigal -i /path/to/samples/N_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/N_files/megaHIT_res_fin/N_genes_contigs  -a /path/to/samples/N_files/megaHIT_res_fin/N_proteins_contigs.faa -p meta -s /path/to/samples/N_files/megaHIT_res_fin/N_potential_genes -f gff -d /path/to/samples/N_files/megaHIT_res_fin/N_genes_contig_seq.fasta
prodigal -i /path/to/samples/O_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/O_files/megaHIT_res_fin/O_genes_contigs  -a /path/to/samples/O_files/megaHIT_res_fin/O_proteins_contigs.faa -p meta -s /path/to/samples/O_files/megaHIT_res_fin/O_potential_genes -f gff -d /path/to/samples/O_files/megaHIT_res_fin/O_genes_contig_seq.fasta
prodigal -i /path/to/samples/V_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/V_files/megaHIT_res_fin/V_genes_contigs  -a /path/to/samples/V_files/megaHIT_res_fin/V_proteins_contigs.faa -p meta -s /path/to/samples/V_files/megaHIT_res_fin/V_potential_genes -f gff -d /path/to/samples/V_files/megaHIT_res_fin/V_genes_contig_seq.fasta
prodigal -i /path/to/samples/X_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/X_files/megaHIT_res_fin/X_genes_contigs -a /path/to/samples/X_files/megaHIT_res_fin/X_proteins_contigs.faa -p meta -s /path/to/samples/X_files/megaHIT_res_fin/X_potential_genes -f gff -d /path/to/samples/X_files/megaHIT_res_fin/X_genes_contig_seq.fasta
prodigal -i /path/to/samples/Z_files/megaHIT_res_fin/final.contigs.fa  -o /path/to/samples/Z_files/megaHIT_res_fin/Z_genes_contigs  -a /path/to/samples/Z_files/megaHIT_res_fin/Z_proteins_contigs.faa -p meta -s /path/to/samples/Z_files/megaHIT_res_fin/Z_potential_genes -f gff -d /path/to/samples/Z_files/megaHIT_res_fin/Z_genes_contig_seq.fasta






### For Mouse samples:
prodigal -i /path/to/samples/16T106_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/16T106_files/megaHIT_res_fin/16T106_genes_contigs -a /path/to/samples/16T106_files/megaHIT_res_fin/16T106_proteins_contigs.faa -p meta -s /path/to/samples/16T106_files/megaHIT_res_fin/16T106_potential_genes -f gff -d /path/to/samples/16T106_files/megaHIT_res_fin/16T106_genes_contig_seq.fasta
prodigal -i /path/to/samples/16TM29_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/16TM29_files/megaHIT_res_fin/16TM29_genes_contigs  -a /path/to/samples/16TM29_files/megaHIT_res_fin/16TM29_proteins_contigs.faa -p meta -s /path/to/samples/16TM29_files/megaHIT_res_fin/16TM29_potential_genes -f gff -d /path/to/samples/16TM29_files/megaHIT_res_fin/16TM29_genes_contig_seq.fasta
prodigal -i /path/to/samples/27T0_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/27T0_files/megaHIT_res_fin/27T0_genes_contigs -a /path/to/samples/27T0_files/megaHIT_res_fin/27T0_proteins_contigs.faa -p meta -s /path/to/samples/27T0_files/megaHIT_res_fin/27T0_potential_genes -f gff -d /path/to/samples/27T0_files/megaHIT_res_fin/27T0_genes_contig_seq.fasta
prodigal -i /path/to/samples/27T39_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/27T39_files/megaHIT_res_fin/27T39_genes_contigs -a /path/to/samples/27T39_files/megaHIT_res_fin/27T39_proteins_contigs.faa -p meta -s /path/to/samples/27T39_files/megaHIT_res_fin/27T39_potential_genes -f gff -d /path/to/samples/27T39_files/megaHIT_res_fin/27T39_genes_contig_seq.fasta
prodigal -i /path/to/samples/28T0_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/28T0_files/megaHIT_res_fin/28T0_genes_contigs -a /path/to/samples/28T0_files/megaHIT_res_fin/28T0_proteins_contigs.faa -p meta -s /path/to/samples/28T0_files/megaHIT_res_fin/28T0_potential_genes -f gff -d /path/to/samples/28T0_files/megaHIT_res_fin/28T0_genes_contig_seq.fasta
prodigal -i /path/to/samples/28T52_files/megaHIT_res_fin/final.contigs.fa -o /path/to/samples/28T52_files/megaHIT_res_fin/28T52_genes_contigs -a /path/to/samples/28T52_files/megaHIT_res_fin/28T52_proteins_contigs.faa -p meta -s /path/to/samples/28T52_files/megaHIT_res_fin/28T52_potential_genes -f gff -d /path/to/samples/28T52_files/megaHIT_res_fin/28T52_genes_contig_seq.fasta



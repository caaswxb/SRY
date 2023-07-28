# Introduction
SRY is an in silicon method for sorting long-read of sex-limited (Y or W) chromosome. It shows about one times higher
sorting efficiency than tradictional chromosome flow-sorting method. Compared with Whole-genome assembly (WGA) or trio-binning, SRY
covers more genomic regions  of Y chromosome.

SRY identified male specific k-mers (MSK) based on population data. To decrease the impact of population structure and sequencing errors, SRY caculated MSK density of each long read and excludes those with lower marker density.

# Installation
We need kmc, samtools, seqtk and parallel in your environment, you can use conda to install them and execute "export PATH=$PATH:/env/conda/bin/".

# Usage
     Usage: ./SRY_k (parameters with * must be supplied!)
     
        -m <string>*     Male (or female for W) short-read files with comma separated in sample and plus separated between samples
        -f <string>*     Female (or male for W) short-read files with comma separated in sample and plus separated between samples
        -i <int>         Minimum coverage of k-mers (default: 2)
        -a <int>         Maximum coverage of k-mers (default: unlimit)
        -k <int>         K-mer length (default: 21)
        -p <int>         CPU number (default: 1)
        -h               Help and exit.

SRY_k is used for identifying specific k-mers. SRY_pb2ont is used for sorting PacBio CLR or Nanopore long reads based on kmer file, and SRY_hifi is used for sorting hifi (PacBio CCS) reads or contigs based on kmer file. combine_hifi_reads.pl is used to combine the sorted hifi reads when two or more k-mer sets (such as k=21 and k=51) are utilized.

# Paper

The preprint paper of our method is online: https://www.biorxiv.org/content/10.1101/2020.05.25.115592v1

# Introduction
SRY is an in silicon method for sorting long-read of sex-limited (Y or W) chromosome. It shows about one times higher
sorting efficiency than tradictional chromosome flow-sorting method. Compared with Whole-genome assembly (WGA) or trio-binning, SRY
covers more genomic regions  of Y chromosome.

SRY identified male specific k-mers (MSK) based on population data. To decrease the impact of population structure and sequencing errors, SRY caculated MSK density of each long read and excludes those with lower marker density.

# Installation
We need samtools, seqtk, parallel and jellyfish in your environment, you can use conda to install them and execute "export PATH=$PATH:/env/conda/bin/".

# Usage
     Usage: ./SRY (parameters with * must be supplied!)
     
        -m <string>*     Male short-read files with comma separated
        -f <string>*     Female short-read files with comma separated
        -l <string>*     Long-read files of targeted genomes with comma separated, (support for both fa and fq)
        -g <number>*     Approximate genome size of targeted Y chromosome. (The unit is Mb,do NOT add the suffix "M")
        -i <int>         Minimum coverage of k-mers (default: 2)
        -a <int>         Maximum coverage of k-mers (default: unlimit)
        -k <int>         K-mer length (default: 21)
        -p <int>         CPU number (default: 1)
        -h               Help and exit.

SRY_k is used for sorting long reads based on kmer file, and SRY_contig is used for sorting contigs based on kmer file.

# Paper

The preprint paper of our method is online: https://www.biorxiv.org/content/10.1101/2020.05.25.115592v1

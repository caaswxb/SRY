# Introduction
SRY is an in silicon method for sorting and assembling long-read of sex-limited (Y or W) chromosome. It shows about one times higher
sorting efficiency than tradictional chromosome flow-sorting method. Compared with Whole-genome assembly (WGA) or trio-binning, SRY
covers more genomic regions  of Y chromosome.

SRY selects half-depth k-mers of target (such as XY male) individual, and identified male specific k-mers via removing discrete k-mers from X chromosome and autosomes based on population data. To decrease the impact of population structure and sequencing errors, SRY caculated MSK (male specific k-mers) density of long reads and excludes those with lower marker density.

# Installation
Just type ./SRY to show the help and use it.

# Usage

Usage: ./SRY (parameters with * must be supplied!)

-s <string>*       Short-read files of targeted genomes with comma separated
-m <string>*       Male short-read files with comma separated  
-f <string>*       Female short-read files with comma separated
-l <string>*       Long-read files of targeted genomes with comma separated, MUST be fasta
-g <number>*       Approximate genome size of targeted Y chromosome. (The unit is Megabase,DO NOT add the suffix "M" or "m")
-i <int>*          Minimum coverage of k-mers
-a <int>           Maximum coverage of k-mers (default: unlimit)
-k <int>           K-mer length (default: 21)
-h                 Help and exit.

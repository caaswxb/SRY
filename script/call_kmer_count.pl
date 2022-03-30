#!/usr/bin/perl -w
use strict;

die "perl $0 male_fq_files female_fq_files kmer_length min_depth max_depth\n" if @ARGV!=5;

my $kmer_len = $ARGV[2];
my $min_depth = $ARGV[3];
my $max_depth = $ARGV[4];

my $cmd="output/kmer.sh";
open OUT,">$cmd";

my ($filterx_cmdm,$filterx_cmdf);

#cmd of male population
my @msamples = split(/\+/,$ARGV[0]);
my $mnum = $#msamples+1;
my $mlimit = int($mnum*2/3+0.5);

my $seq = '';		
for (my $j=0;$j<@msamples;$j++){
	if ($msamples[$j]=~/,/){
		my @mfiles = split(/,/,$msamples[$j]);
		print OUT "kmer_count -l $kmer_len -f FQ -n $min_depth -o output/M${j}_kmer.dat.gz";
		for (my $i=0;$i<@mfiles;$i++){
			print OUT " -i $mfiles[$i]";
		}
		print OUT "\n";
	}else{
		print OUT "kmer_count -l $kmer_len -f FQ -n $min_depth -o output/M${j}_kmer.dat.gz -i $msamples[$j]\n";
	}

	if ($max_depth == 0){
		$seq .= " output/M${j}_kmer.dat.gz";
	}else{
		$seq .= " <(zcat output/M${j}_kmer.dat.gz| awk \'\$2<=$max_depth\')";
	}
}
$filterx_cmdm="filterx -1 \'cnt>=$mlimit\' -k s $seq |awk \'{for (i=1;i<=NF;i+=2){if (\$i~/[A-Z]/){print \$i;break}}}\' | gzip > output/Male_kmer.dat.gz\n";

#cmd of female population
my @fsamples = split(/\+/,$ARGV[1]);

$seq = '';
for (my $j=0;$j<@fsamples;$j++){
	if ($fsamples[$j]=~/,/){
		my @ffiles = split(/,/,$fsamples[$j]);
		print OUT "kmer_count -l $kmer_len -f FQ -n $min_depth -o output/F${j}_kmer.dat.gz";
		for (my $i=0;$i<@ffiles;$i++){
			print OUT " -i $ffiles[$i]";
		}
		print OUT "\n";
	}else{
		print OUT "kmer_count -l $kmer_len -f FQ -n $min_depth -o output/F{$j}_kmer.dat.gz -i $fsamples[$j]\n";
	}

	if ($max_depth == 0){
		$seq .= " output/F${j}_kmer.dat.gz";
	}else{
		$seq .= " <(zcat output/F${j}_kmer.dat.gz| awk \'\$2<=$max_depth\')";
	}
}
$filterx_cmdf="filterx -k s -1 \'cnt>=1\' $seq |awk \'{for (i=1;i<=NF;i+=2){if (\$i~/[A-Z]/){print \$i;break}}}\' |gzip > output/Female_kmer.dat.gz\n";
close OUT;

my $ftcmd="output/ft.sh";
open OUT1,">$ftcmd";
if ($filterx_cmdm || $filterx_cmdf){
	print OUT1 "$filterx_cmdm" if ($filterx_cmdm);
	print OUT1 "$filterx_cmdf" if ($filterx_cmdf);
}
close OUT1;

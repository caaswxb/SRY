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
	my @mfiles = split(/,/,$msamples[$j]);
	my $m_tmp = "output/SRY_tmp_M$j.file";
	open MOUT,">$m_tmp";
	for (my $i=0;$i<@mfiles;$i++){
		print MOUT "$mfiles[$i]\n";
	}


	if ($max_depth == 0){
		$seq .= " output/M$j.kmer";
	}else{
		$seq .= " <(awk \'\$2<=$max_depth\' output/M$j.kmer)";
	}

	print OUT "mkdir tmp_M$j && kmc -t1 -m3 -hp -k$kmer_len -fq \@$m_tmp tmp_M$j tmp_M$j && kmc_tools transform tmp_M$j dump -s output/M$j.kmer\n";
	close MOUT;
}

$filterx_cmdm="filterx -1 \'cnt>=$mlimit\' -k s $seq |awk \'{for (i=1;i<=NF;i+=2){if (\$i~/[A-Z]/){print \$i;break}}}\' | gzip > output/Male_kmer.dat.gz\n";

#cmd of female population
my @fsamples = split(/\+/,$ARGV[1]);

$seq = '';
for (my $j=0;$j<@fsamples;$j++){
	my @ffiles = split(/,/,$fsamples[$j]);
	my $f_tmp = "output/SRY_tmp_F$j.file";
	open FOUT,">$f_tmp";
	for (my $i=0;$i<@ffiles;$i++){
		print FOUT "$ffiles[$i]\n";
	}

	if ($max_depth == 0){
		$seq .= " output/F$j.kmer";
	}else{
		$seq .= " <(awk \'\$2<=$max_depth\' output/F$j.kmer)";
	}
	print OUT "mkdir tmp_F$j && kmc -t1 -m3 -hp -k$kmer_len -fq \@$f_tmp tmp_F$j tmp_F$j && kmc_tools transform tmp_F$j dump -s output/F$j.kmer\n";
	close FOUT;
}
close OUT;

$filterx_cmdf="filterx -k s -1 \'cnt>=1\' $seq |awk \'{for (i=1;i<=NF;i+=2){if (\$i~/[A-Z]/){print \$i;break}}}\' |gzip > output/Female_kmer.dat.gz\n";

my $ftcmd="output/ft.sh";
open OUT1,">$ftcmd";
if ($filterx_cmdm || $filterx_cmdf){
	print OUT1 "$filterx_cmdm" if ($filterx_cmdm);
	print OUT1 "$filterx_cmdf" if ($filterx_cmdf);
}
close OUT1;

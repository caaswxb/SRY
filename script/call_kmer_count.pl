#!/usr/bin/perl -w
use strict;

die "perl $0 target_fq_files male_fq_files female_fq_files kmer_length\n" if @ARGV!=4;

my $kmer_len = $ARGV[3];

my $cmd="output/kmer.sh";
open OUT,">$cmd";

my ($filterx_cmdt,$filterx_cmdm,$filterx_cmdf);
if ($ARGV[0]=~/,/){
	my @tfiles = split(/,/,$ARGV[0]);
	my $seq = '';
	for (my $i=0;$i<@tfiles;$i++){
		print OUT "kmer_count -l $kmer_len -f FQ -o output/T${i}_kmer.dat.gz -i $tfiles[$i] &\n";
		$seq.=" output/T${i}_kmer.dat.gz";
	}
	$filterx_cmdt="filterx -k s $seq |awk \'{c=0;for(i=2;i<=NF;i+=2){c+=\$i;} print \$1\"\\t\"c}\' |gzip > output/Target_kmer.dat.gz\n";
}else{
	print OUT "kmer_count -l $kmer_len -f FQ -o output/Target_kmer.dat.gz -i $ARGV[0] &\n";
}
if ($ARGV[1]=~/,/){
	my @mfiles = split(/,/,$ARGV[1]);
	my $seq = '';
	for (my $i=0;$i<@mfiles;$i++){
		print OUT "kmer_count -l $kmer_len -f FQ -o output/M${i}_kmer.dat.gz -i $mfiles[$i] &\n";
		$seq.=" output/M${i}_kmer.dat.gz";
	}
	$filterx_cmdm="filterx -k s $seq |awk \'{c=0;for(i=2;i<=NF;i+=2){c+=\$i;} print \$1\"\\t\"c}\' |gzip > output/Male_kmer.dat.gz\n";
}else{
	print OUT "kmer_count -l $kmer_len -f FQ -o output/Male_kmer.dat.gz -i $ARGV[0] &\n";
}

if ($ARGV[2]=~/,/){
	my @ffiles = split(/,/,$ARGV[2]);
	my $seq = '';
	for (my $i=0;$i<@ffiles;$i++){
		print OUT "kmer_count -l $kmer_len -f FQ -o output/F${i}_kmer.dat.gz -i $ffiles[$i] &\n";
		$seq.=" output/F${i}_kmer.dat.gz";
	}
	$filterx_cmdf="filterx -k s $seq |awk \'{c=0;for(i=2;i<=NF;i+=2){c+=\$i;} print \$1\"\\t\"c}\' |gzip > output/Female_kmer.dat.gz\n";
}else{
	print OUT "kmer_count -l $kmer_len -f FQ -o output/Female_kmer.dat.gz -i $ARGV[0] &\n";
}
print OUT "wait\n";

if ($filterx_cmdt || $filterx_cmdm || $filterx_cmdf){
	print OUT "$filterx_cmdt" if ($filterx_cmdt);
	print OUT "$filterx_cmdm" if ($filterx_cmdm);
	print OUT "$filterx_cmdf" if ($filterx_cmdf);
	print OUT "wait\n";
}
close OUT;
`sh output/kmer.sh`;

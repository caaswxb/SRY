#!/usr/bin/perl -w
use strict;

die "perl $0 <loci.fa> <kmer length>\n" if @ARGV!=2;

my $in = $ARGV[0];
open IN,$in;
my $klen = $ARGV[1];

my $id;
while (<IN>){
	chomp;
	if (/>(\w+)/){
		$id = $1;
	}else{
		my $len = length($_);
		for (my $i=0;$i<=($len-$klen);$i++){
			my $seq = substr($_,$i,$klen);
			$seq = uc $seq;
			my $rev = reverse $seq;
			$rev =~tr/ATCG/TAGC/;
			if ($seq lt $rev){
				print "$seq\t$id\n";
			}else{
				print "$rev\t$id\n";
			}
		}
	}
}
close IN;

#!/usr/bin/perl -w
use strict;

die "perl $0 kmer.txt\n" if @ARGV!=1;

my $in = $ARGV[0];
open IN,"$in";

while (<IN>){
	chomp;
	my @info = split;
	my $seq = $info[0];
	$seq =~tr/ACGTacgt/TGCAtgca/;
	$seq = reverse $seq;
	print "$info[0]\n$seq\n";
}
close IN;

#!/usr/bin/perl
use strict;

die "perl $0 changeid.fa.fai x??.kmercount kmer_len\n" if @ARGV!=3;


my $in = $ARGV[0];
open IN,$in;

my @info;
my %hash;
while (<IN>){
	chomp;
	@info = split;
	$hash{$info[0]} = $info[2];
}
close IN;

my $in1 = $ARGV[1];
open IN1,$in1;
my $klen = $ARGV[2];

while (<IN1>){
	chomp;
	@info = split(/:/);
	$info[0]/=2;
	my $start = $info[1]-$hash{$info[0]};
	my $end = $start+($klen*2-1);
	print "$info[0]\t$start\t$end\n";
}
close IN1;

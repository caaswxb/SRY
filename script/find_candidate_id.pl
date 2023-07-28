#!/usr/bin/perl -w
use strict;

die "perl $0 need.kmer kmer2id\n" if @ARGV!=2;

my $in = $ARGV[0];
open IN,$in;

my %hash;
while (<IN>){
	chomp;
	$hash{$_}='';
}
close IN;

my $in1 = $ARGV[1];
open IN1,$in1;

my @info;
while (<IN1>){
	chomp;
	@info = split;
	if (defined $hash{$info[0]}){
		print "$info[1]\n";
	}
}

#!/usr/bin/perl -w
use strict;

die "perl $0 all.seqid ref.fa.fai\n" if @ARGV!=2;

my $in = $ARGV[0];
open IN,$in;

my %hash;
while (<IN>){
	chomp;
	$hash{$_} +=1;
}
close IN;

my $in1 = $ARGV[1];
open IN1,$in1;

my @info;
while (<IN1>){
	chomp;
	@info = split;
	if (exists $hash{$info[0]}){
		my $density = sprintf("%.4f",$hash{$info[0]}*1000/$info[1]);
		print "$info[0]\t$hash{$info[0]}\t$info[1]\t$density\n";
	}
}
close IN1;

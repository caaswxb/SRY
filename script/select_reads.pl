#!/usr/bin/perl -w
use strict;

die "perl $0 all.density limit_density old2new_id ref.fa\n" if @ARGV!=4;

my $in = $ARGV[0];
open IN,$in;

my $limit = $ARGV[1];

my @info;
my %hash;
while (<IN>){
	chomp;
	@info = split;
	if ($info[3]>=$limit){
		$hash{$info[0]} = '';
	}
}
close IN;

my $in1 = $ARGV[2];
open IN1,$in1;

my $flag = 0;
my %old2new;
while (<IN1>){
	chomp;
	@info = split(/\t/);
	#if ($flag == 0){
	#	$flag =1;
	#}else{
		$old2new{$info[1]} = $info[0];
	#}
}
close IN1;

my $in2 = $ARGV[3];
open IN2,$in2;

my $out = "output/candidate_target_reads.fa";
open OUT,">$out";
my $out1 = "output/candidate_other_reads.fa";
open OUT1,">$out1";

my $id;
$flag = 0;
while (<IN2>){
	chomp;
	if (/>(\S+)/){
		$id = $1;
		if (defined $hash{$id}){
			$flag = 1;
			print OUT ">$old2new{$id}\n";
		}else{
			$flag = 0;
			print OUT1 ">$old2new{$id}\n";
		}
	}else{	
		if ($flag == 1){
			print OUT "$_\n";
		}else{
			print OUT1 "$_\n";
		}
	}
}
close IN2;
close OUT;
close OUT1;

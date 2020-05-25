#!/usr/bin/perl -w
use strict;

my $in = $ARGV[0];
open IN,$in;

my @info;
my $offset;
my $last_len;
my $flag = 0;
while (<IN>){
	chomp;
	@info = split;
	
	if ($flag == 0){
		$offset = length($info[0])+2;
		$flag = 1;
	}else{
		$offset += (length($info[0])+2);
		$offset += $last_len;
	}
	print "$info[0]\t$offset\n";
	$last_len = $info[1]+1;
}
close IN;

#!/usr/bin/perl -w
use strict;

die "perl $0 out1 out2\n" if @ARGV!=2;

#my $out = "output/origin2newid.txt";
my $out = $ARGV[0];
open OUT,">$out";
#my $out1 = "output/changeid.fa";
my $out1 = $ARGV[1];
open OUT1,">$out1";

my $count = 0;
print OUT "Origin_id\tNew_id\n";
while (<STDIN>){
	chomp;
	if (/>(.*)/){
		$count++;
		print OUT "$1\t$count\n";
		print OUT1 ">$count\n";
	}else{
		print OUT1 "$_\n";
	}
}
close OUT;
close OUT1;

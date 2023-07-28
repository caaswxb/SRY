#!/usr/bin/perl -w
use strict;

die "perl $0 file1 ...\n" if @ARGV==0;

my %hash;
my $flag = 0;
for (my $i=0;$i<@ARGV;$i++){
	my $in = $ARGV[$i];
	open IN,$in;
	while (<IN>){
		chomp;
		if (/>(\S+)/){
			my $id = $1;
			if (!defined $hash{$id}){
				$hash{$id} = "";
				print "$_\n";
				$flag = 1;
			}else{
				$flag = 0;
			}
		}else{
			if ($flag == 1){
				print "$_\n";
			}
		}	
	}
	close IN;
}

#!/usr/bin/perl
use strict;

die "perl $0 ONTseq_offset.txt x??.kmercount\n" if @ARGV!=2;

=pod
if [ -z $FILE ];then
	echo "Usage:$0 <x??>"
	exit
fi

awk -F':' '{print $1}' $FILE.kmercount |uniq | awk '{print $1/2}' > $FILE.id
=cut

my $in = $ARGV[0];
open IN,$in;

my @info;
my %hash;
while (<IN>){
	chomp;
	@info = split;
	$hash{$info[0]} = $info[1];
}
close IN;

my $in1 = $ARGV[1];
open IN1,$in1;

while (<IN1>){
	chomp;
	@info = split(/:/);
	$info[0]/=2;
	my $start = $info[1]-$hash{$info[0]};
	my $end = $start+41;
	print "$info[0]\t$start\t$end\n";
}
close IN1;

#!/usr/bin/perl -w
use strict;

die "perl $0 target_fq_files male_fq_files female_fq_files kmer_length\n" if @ARGV!=4;

my @tfiles = split(/,/,$ARGV[0]);
my @mfiles = split(/,/,$ARGV[1]);
my @ffiles = split(/,/,$ARGV[2]);
my $kmer_len = $ARGV[3];

my $tcommand = "kmer_count -l $kmer_len -f FQ -o output/Target_kmer.dat.gz";
foreach my $tf (@tfiles){
        $tcommand .=" -i $tf";
}
print "Executing command \"$tcommand\"\n";
system("$tcommand");

my $mcommand = "kmer_count -l $kmer_len -f FQ -o output/Male_kmer.dat.gz";
foreach my $mf (@mfiles){
	$mcommand .=" -i $mf";
}
print "Executing command \"$mcommand\"\n";
system("$mcommand");

my $fcommand = "kmer_count -l $kmer_len -f FQ -o output/Female_kmer.dat.gz";
foreach my $ff (@ffiles){
	$fcommand .=" -i $ff";
}
print "\nExecuting command \"$fcommand\"\n";
system("$fcommand");

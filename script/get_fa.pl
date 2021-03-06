#!/usr/bin/perl -w

die "perl $0 x??.loci ref.fa kmer_len\n" if @ARGV!=3;

my $in = $ARGV[0];
open IN,$in;

my @info;
my %hash;
while (<IN>){
	chomp;
	@info = split;
	push(@{$hash{$info[0]}},$info[1]);
}
close IN;

my $in1 = $ARGV[1];
open IN1,$in1;
my $klen = $ARGV[2];

my $flag = 0;
my $id;
while (<IN1>){
	chomp;
	if (/>(\S+)/){
		$id = $1;
		if (defined $hash{$id}){
			$flag = 1;
		}else{
			$flag = 0;
		}
	}else{
		if ($flag == 1){
			my $ref = $hash{$id};
			for (my $i=0;$i<@$ref;$i++){
				my $extend_len = (2*$klen-1);
				my $seq=substr($_,$ref->[$i],$extend_len);
				print ">$id:$ref->[$i]\n$seq\n";		
			}
			#`kmer_count -l 21 -i $out -o $in.kmer`;
			#`filterx -k s $in.kmer $pre.st |wc -l >> $pre.count`;
			#`filterx -k s $in.kmer xcn.st |wc -l >> $in.count`; #test
			#exit;
		}
	}
}
close IN1;

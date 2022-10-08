#!/usr/bin/perl

use Excel::Writer::XLSX;
use XML::Parser;
use Text::ParseWords;
use Data::Dumper qw(Dumper);
use List::MoreUtils qw(uniq);
use List::MoreUtils qw(firstidx);
use strict;

our $i=0;
my $filename = $ARGV[0];
our $cc;

open (XMLFILE, "<$filename");

while (<XMLFILE>){

#$_ =~ s/\n//g;
$cc = $cc.$_;
}
close (XMLFILE);

#print $cc;

our $pcopen;
our $pccount=0;
our $tax;
our $basemonat;
our $basemonatcount=0;
$filename =~ s/.xml/.xlsx/;
our %taxvalue = ();
my %namevaluebase = ();
our %pcbase = ();
our %pcbase1 = ();
our $pcbase1;
our $pcbase;
my @splited=split(/(<[^<]+>)/,$cc);
our $name;
our $value;
our @columns;

foreach (@splited){#1 #for every row
    if ($_ =~ /\w+/ and $_ !~ /xml/){#2 #if letters and not 'xml' in content
    	if ($_ =~ m/<ParametresContrats /){$pcopen=1;}
    	if ($_ =~ m/<BaseMontantSpecifique / or $_ =~ m/<\w+Prev>/){$basemonat=1;}
    	if ($_ =~ m/<Taux>/ or $_ =~ m/<Montant>/){$tax = $_;$tax =~ s/<//;$tax =~ s/>//;}
    	if ($_ =~ m/<\/Taux>/ or $_ =~ m/<\/Montant>/){$tax="";}
    	if ($_ =~ m/<\/BaseMontantSpecifique>/ or $_ =~ m/<\/\w+Prev>/){$basemonat=0;$basemonatcount++;}
    	if ($_ =~ m/<\/ParametresContrats>/){$pcopen=0;$pccount++;$basemonatcount=0;}
    	my @splitedbyspace=split(/ /,$_);
    	my @tags=quotewords('\s+', 0, $_); # splits the lines into tags
    	
	if ($_ =~ m/^\d*\.\d*$/ and $tax =~ m/.+/){#10
	$pcbase1{$pccount}{$basemonatcount}{$tax}=$_;
	#print $tax." ".$_."\n";
	}#10
#build base hash %namevaluebase
    	foreach (@tags){#for every row unless in contract #3
    	    if ($_ =~ m/\d\dT\d\d/){$_ =~ s/T/ /;} # removes T from date
    	    $_ =~ s/\/>//g;
    	    $_ =~ s/>$//;
    	    if ($_ =~ m/.+=.+/){ # checks if there is "=" it's real name/value couple #6
    	        my @namevalue = split(/=/,$_);
    	        $name=$namevalue[0]; $value=$namevalue[1];
    	        if ($pcopen==0 and $basemonatcount==0){#7
    	        #$namevaluebase{$name}=$value;
    	        $pcbase{base}{$name}=$value;
    	        #print $name." = ".$pcbase{base}{$name}."\n"; 
    	        }#7
#build base parametres contrats
    		elsif ($pcopen>0 and $basemonat==0){#if ParametresContrats but not BaseMontantSpecifique #8
    		$pcbase{$pccount}{$name}=$value;
    		}#8
    		else {#if ParametresContrats and BaseMontantSpecifique #9
    		$pcbase1{$pccount}{$basemonatcount}{$name}=$value;
    		#print $name." ".$value." ".$basemonatcount."\n";
    		}#9
    	    }#6
	}#3
	
    }#2
}#1

my $x=0;
my $pcprinted; my $bmprinted; my $bmcontentprinted; #our %pcprinted;
my $bm0printed; my $bm0contentprinted;


my $workbook  = Excel::Writer::XLSX->new( $filename );
my $worksheet = $workbook->add_worksheet();

#generate list of columns
for $pcprinted ( keys %pcbase1 ){#3
    for $bmprinted ( keys %{ $pcbase1{$pcprinted} } ){#2
	
	#print base tags
        for $bm0printed ( keys %{ $pcbase{base} } ){#4
		#print $bm0printed." = ".$pcbase{base}{$bm0printed}."\n";
		push (@columns,$bm0printed);
        }#4
        #print base contract tags
        for $bm0printed ( keys %{ $pcbase{$pcprinted} } ){#5
                #print $bm0printed." = ".$pcbase{$pcprinted}{$bm0printed}."\n";
                push (@columns,$bm0printed);
        }#5
	#print BaseMontantSpecifique
	for $bmcontentprinted ( keys %{ $pcbase1{$pcprinted}{$bmprinted} } ){#1
	        #print $bmcontentprinted." = ".$pcbase1{$pcprinted}{$bmprinted}{$bmcontentprinted}." ".$x."\n";
	        push (@columns,$bmcontentprinted);
	}#1

	#print "\n\n";
    }#2
    #print "\n---------------------------------------------\n";
}#3

#make the list of columns unique and write field names into the first row
my $i=0;
	our @columns1 = uniq @columns;
	foreach my $column (@columns1){
	$worksheet->write( 0, $i, $column );
	$i++;
	####################
	my $index = firstidx { $_ eq $column } @columns1;
	#print $index."  ";
	####################
	}

my $i=1;
#print rows into excel sheet
for $pcprinted ( keys %pcbase1 ){#3
    for $bmprinted ( keys %{ $pcbase1{$pcprinted} } ){#2
        #print base tags
	for $bm0printed ( keys %{ $pcbase{base} } ){#4
	    #print $bm0printed." = ".$pcbase{base}{$bm0printed}."\n";
	    my $column = firstidx { $_ eq $bm0printed } @columns1;
	    $worksheet->write( $i, $column, $pcbase{base}{$bm0printed} );
	}#4
	#print base contract tags
	for $bm0printed ( keys %{ $pcbase{$pcprinted} } ){#5
    	    #print $bm0printed." = ".$pcbase{$pcprinted}{$bm0printed}."\n";
    	    my $column = firstidx { $_ eq $bm0printed } @columns1;
    	    $worksheet->write( $i, $column, $pcbase{$pcprinted}{$bm0printed} );
	}#5
        #print BaseMontantSpecifique
        for $bmcontentprinted ( keys %{ $pcbase1{$pcprinted}{$bmprinted} } ){#1
    	    #print $bmcontentprinted." = ".$pcbase1{$pcprinted}{$bmprinted}{$bmcontentprinted}." ".$x."\n";
    	    my $column = firstidx { $_ eq $bmcontentprinted } @columns1;
    	    $worksheet->write( $i, $column, $pcbase1{$pcprinted}{$bmprinted}{$bmcontentprinted} );
        }#1
        $i++;
    }#2
}#3

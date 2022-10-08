#!/usr/bin/perl -w
#Author:
#Purpose: explain hashes

$make = "Honda";

$firstname = "Dean"; # This is a scalar variable type.

@fullname = ("Iliyan","Emilov","Katsarov"); # this is an array

%make_model = ("Honda","Accord","Toyota","Corolla"); # this is a hash
	
	print "$firstname","\n";
	print "$make makes the: ";
	print $make_model{"$make"},"\n"; # the value that corresponds to the key Honda is Accord. N.B. -> You must have an even number of key/values. 
	print "$fullname[2]\n"; # second (count starts from 0) scalar from the array is Katsarov 
	print "\n";
	print "@fullname[0..$#fullname]","\n";

$player = "Sharapova";
%player_country = (
	Venus => "USA",
	Sharapova => "Russia",
	Serena => "USA",
	Pironkova => "Bg",
	); #Another (clearer) way of declaring a hash.

	print $player_country{"$player"}, "\n";


@num_of_players = keys %player_country;
@num_of_players2 = values %player_country;	

print "@num_of_players[0..$#num_of_players]\n";
print "@num_of_players2[0..$#num_of_players2]\n";



print "@fullname[0..$#fullname]\n";
#end

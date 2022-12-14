#!/usr/bin/perl -w
#***************************************************************************
#    PrintAnalyzer
#    Generate some stats from cups page_log file
#    copyright            : (C) 1999 - 2003 by Thies Moeller                         
#    email                : moeller@tu-harburg.de 
#***************************************************************************

#***************************************************************************
#*                                                                         *
#*   This program is free software; you can redistribute it and/or modify  *
#*   it under the terms of the GNU General Public License as published by  *
#*   the Free Software Foundation; either version 2 of the License, or     *
#*   (at your option) any later version.                                   * 
#*                                                                         *
#***************************************************************************
use strict;
use warnings;
use POSIX qw(strftime);
use Time::Local;
use Getopt::Std;



##############
# edit place of your page_log file or give it as option "-f filename"
##############
my %opt;
my $PAGE_LOG_FILE;

getopts("f:q",\%opt);

if (exists $opt{"f"}) { $PAGE_LOG_FILE = $opt{f};}
else {$PAGE_LOG_FILE = "/var/log/cups/page_log";}

##############
# edit start and end of normal work time
# activity outside this interval will be marked with an "!" 
# to disable set WorkStart to 0 and WorkEnd to 24
##############
my $WorkStart = 07;
my $WorkEnd   = 22;


############################ nothing to modify below this line ##############

my %userRequests  = ();
my %userPages     = ();
my %hourRequests  = ();
my %dateRequests  = ();
my %datePages     = ();
my %pageRequests  = ();
my %queueRequests = ();
my %queuePages    = ();
my %pageHeu       = ();
my %copyRequests  = ();
my %logline       = ();
my %lastlogline   = ();
my %billingStats  = ();
my %queueUserStats  = ();
my $totalReq      = 0;
my $totalPages    = 0;

sub DateCompare
{
	    my $date1 = substr($a, 6, 2) * 1024;  # Years
            my $date2 = substr($b, 6, 2) * 1024;

	    $date1 += substr($a,3,2) * 64;       # Months
	    $date2 += substr($b,3,2) * 64;

	    $date1 += substr($a, 0, 2);          # Days
	    $date2 += substr($b, 0, 2);
            return ($date1 <=> $date2);
}


sub tzdiff2sec
{
## this method is copied from LogReport Time.pm
## Copyright (C) 2000-2002 Stichting LogReport Foundation LogReport@LogReport.org

    die "tzdiff2sec needs 1 arg\n"
 	  unless @_ == 1;

    # e.g. +0100 or -0900 ; +hh:mm, +hhmm, or +hh
    my ( $sign, $hour, $min ) = $_[0] =~ /^([+-])?(\d\d):?(\d\d)?$/
	    or die "invalid tzdiff format: $_[0]. It must looks like +0100 or -01:00\n";
    $sign ||= "+";
    $hour ||= 0;
    $min  ||= 0;
    my $sec = $hour * 60 * 60 + $min * 60;
    $sec *= -1 if $sign eq '-';
    return $sec;
}

sub getMonth
{
        my $AllMonths= 'JanFebMarAprMayJunJulAugSepOctNovDec';
	my $month = shift(@_);
	return index($AllMonths, $month)/3;
}



sub DateTime2Epoch
{
    my ($day,$month,$year,$hour,$min,$sec,$tz)=
	    unpack'@1 A2 @4 A3 @8 A4 @13 A2 @16 A2 @19 A2 @22 A5', shift();

    my $epoch=timegm  $sec , 
	              $min , 
		      $hour, 
		      $day,  
		      getMonth($month),       
		      $year;  
    return $epoch - tzdiff2sec($tz);
}

sub PrintDayLog
{
	my $dateReq;

############# Output Form ################
format DAYLOG_TOP =

Daily Usage
Date               %Requests        Pages
-----------------------------------------
.

format DAYLOG =
@<<<<<<<<<<<<<     @>>>>>>>     @>>>>>>>   
$dateReq,$dateRequests{$dateReq},$datePages{$dateReq}
.
############# Output Form ################


        $-=0;
        $~="DAYLOG";
        $^="DAYLOG_TOP";
        foreach $dateReq (sort DateCompare keys %dateRequests)
            {
            #printf("Monat %d\n",getMonth($dateReq));
            write;
            }
}

sub PrintUserLog
{
	my $userReq;
	my $pageperjob;

############# Output Form ################
format USERLOG_TOP =
PrinterAccounting
Username            Requests      Pages   Pages/Request
--------------------------------------------------------
.

format USERLOG =
@<<<<<<<<<<<<<<<<<< @>>>>>>>   @>>>>>>>   @>>>>>>>>
$userReq,           $userRequests{$userReq}, $userPages{$userReq}, $pageperjob
.
############# Output Form ################

        $-=0;
        $~="USERLOG";
        $^="USERLOG_TOP";
        foreach $userReq (sort { $userPages{$b} <=> $userPages{$a}} keys %userRequests)
            {
            $pageperjob = sprintf("%5d", POSIX::ceil($userPages{$userReq} / $userRequests{$userReq}));
            write ;
            }
}

sub PrintHourLog
{
	my $hourReq;
	my $outOfWorkingTime;

############# Output Form ################
format HOURLOG_TOP =
Hour Usage
Hour        Requests     
---------------------
.

format HOURLOG =
@<@<<<<<     @>>>>>>>  
$outOfWorkingTime,$hourReq,$hourRequests{$hourReq}
.
############# Output Form ################


	$-=0;
        $~="HOURLOG";
        $^="HOURLOG_TOP";

         foreach $hourReq (sort {$a <=> $b} keys %hourRequests)
            {
	    if($hourReq <$WorkStart  || $hourReq > $WorkEnd)
	    {
		    if($hourRequests{$hourReq} == 0)
		    {
			    next;
		    }
		    else
		    {
			    $outOfWorkingTime = "!";
		    }
	    }
	    else
	    {
		   $outOfWorkingTime = " ";
	    }
            write;
            }

}

sub PrintRequestSize
{
	my $pageReq;
	my %pageHeu;
	my $pageHeuK;
        my $pageperHeu; 
############# Output Form ################

format REQUESTLOG_TOP =
Heuristic
JobSize         %Requests
---------------------------
.

format REQUESTLOG =
@|||||||||||    @>>>>>>>>
$pageHeuK,$pageperHeu
.
############# Output Form ################

        # sammeln der Daten
        foreach $pageReq (sort {$a <=> $b}  keys %pageRequests)
            {
            if($pageReq >0 && $pageReq <=10)
	            {$pageHeu{"1.    0-10"}+=$pageRequests{$pageReq}};
            if ($pageReq >10 && $pageReq <=20)
                   {$pageHeu{ "2.   20-30"}+=$pageRequests{$pageReq}};
            if ($pageReq >20 && $pageReq <=30)
                   {$pageHeu{ "3.   30-40"}+=$pageRequests{$pageReq}};
            if ($pageReq >40 && $pageReq <=50)
                   {$pageHeu{ "4.   40-50"}+=$pageRequests{$pageReq}};
            if ($pageReq >50 && $pageReq <=100)
                   {$pageHeu{ "5.  50-100"}+=$pageRequests{$pageReq}};
            if ($pageReq >100 && $pageReq <=200)
                   {$pageHeu{ "6. 100-200"}+=$pageRequests{$pageReq}};
            if ($pageReq >200 )
                   {$pageHeu{ "7. 200-   "}+=$pageRequests{$pageReq}};
        }
        $-=0;
        $~="REQUESTLOG";
        $^="REQUESTLOG_TOP";

        foreach $pageHeuK (sort keys %pageHeu)
            {
     	     $pageperHeu = sprintf("%5.2f", 100*$pageHeu{$pageHeuK}/$totalReq);
             write;
        }
}

sub PrintCopySize
{
	my $copyReq;
	my %copyHeu;
        my $copyHeuK;
	my $copyperheu;
############# Output Form ################
format COPY_TOP =
Heuristic
Copies           %Requests
---------------------------
.
format COPYLOG =
@|||||||||||||    @>>>>>>>>
$copyHeuK,$copyperheu
.
############# Output Form ################

        
        foreach $copyReq (sort {$a <=> $b}  keys %copyRequests)
            {
            if($copyReq == 1 )
	            {$copyHeu{" 1.    single"}+=$copyRequests{$copyReq}};
	    if($copyReq == 2)
	            {$copyHeu{" 2.    2     "}+=$copyRequests{$copyReq}};		    
	    if($copyReq == 3)
	            {$copyHeu{" 3.    3     "}+=$copyRequests{$copyReq}};		    		    
	    if($copyReq == 4)
	            {$copyHeu{" 4.    4     "}+=$copyRequests{$copyReq}};		    		    		    
	    if($copyReq >=5 && $copyReq <=10)
	            {$copyHeu{" 5.    5-10  "}+=$copyRequests{$copyReq}};		    
            if ($copyReq >10 && $copyReq <=20)
                   {$copyHeu{ " 6.   20-30  "}+=$copyRequests{$copyReq}};
            if ($copyReq >20 && $copyReq <=30)
                   {$copyHeu{ " 7.   30-40  "}+=$copyRequests{$copyReq}};
            if ($copyReq >40 && $copyReq <=50)
                   {$copyHeu{ " 8.   40-50  "}+=$copyRequests{$copyReq}};
            if ($copyReq >50 && $copyReq <=100)
                   {$copyHeu{ " 9.  50-100  "}+=$copyRequests{$copyReq}};
            if ($copyReq >100 && $copyReq <=200)
                   {$copyHeu{ "10. 100-200  "}+=$copyRequests{$copyReq}};
            if ($copyReq >200 )
                   {$copyHeu{ "11. 200-   "}+=$copyRequests{$copyReq}};
        }
        $-=0;
        $~="COPYLOG";
        $^="COPY_TOP";
        foreach $copyHeuK (sort keys %copyHeu)
            {
             $copyperheu = sprintf("%5.2f", 100*$copyHeu{$copyHeuK}/$totalReq);
             write;
        }
}

sub PrintQueueLog
{
	my $queueReq;
	my $reqperqueue;
	my $pagepermin;
	my $pageperqueue ;
############# Output Form ################
format QUEUELOG_TOP =
Queue Heuristic
Queue                      %Requests        %Pages     Pages
--------------------------------------------------------------
.

format QUEUELOG =
@>>>>>>>>>>>>>>>>>>>>>     @>>>>>>>     @>>>>>>>      @>>>>>>>>
$queueReq,$reqperqueue,$pageperqueue,$queuePages{$queueReq}
.
############# Output Form ################


	$-=0;
        $~="QUEUELOG";
        $^="QUEUELOG_TOP";
    foreach $queueReq (sort { $queuePages{$b} <=> $queuePages{$a} } keys %queuePages)
     {
        $reqperqueue  = sprintf("%5.2f", 100*$queueRequests{$queueReq}/$totalReq);
	$pageperqueue = sprintf("%5.2f", 100*$queuePages{$queueReq}/$totalPages);
        write;
    }

}

sub PrintBillingLog
{
	my $billing;
	my $pageperbilling ;
	my $billinguser;

############# Output Form ################
format BILLINGLOG_TOP =
Billing Heuristic
Billing                           Pages
--------------------------------------------------------------
.

format BILLINGLOG =
@<<<<<<<<<<<<<<<<<<<<<<<<        @>>>>>>>>
$billing,$pageperbilling
.

format BILLINGUSERLOG =
|- @>>>>>>>>>>>>>>>>>>>>>        @>>>>>>>>
$billinguser,$pageperbilling
.
############# Output Form ################


	$-=0;
        $~="BILLINGLOG";
        $^="BILLINGLOG_TOP";
    foreach $billing (sort keys %billingStats)
     {
	$pageperbilling = $billingStats{$billing}{"total_pages"};
        $~="BILLINGLOG";
        write;
        $~="BILLINGUSERLOG";
        foreach $billinguser ( sort {$billingStats{$billing}{"user"}{$b} <=> $billingStats{$billing}{"user"}{$a}} keys %{$billingStats{$billing}{"user"}})
	{
	  $pageperbilling = $billingStats{$billing}{"user"}{$billinguser};
          write;		
	}
    }

}

sub PrintQueueUserLog
{
	my $queue;
	my $pageperqueue;
	my $queueuser;

############# Output Form ################
format QUEUEUSER_TOP =
Queue-User
Queue              User             Pages
--------------------------------------------------------------
.

format QUEUENAME =
@<<<<<<<<<<<<<<<<<<<<<<<<        
$queue
.

format QUEUEUSERLOG =
|- @>>>>>>>>>>>>>>>>>>>>>        @>>>>>>>>
$queueuser,$pageperqueue
.
############# Output Form ################


	$-=0;
        $~="QUEUENAME";
        $^="QUEUEUSER_TOP";
    foreach $queue (sort keys %queueUserStats)
     {
        $~="QUEUENAME";
        write;
        $~="QUEUEUSERLOG";
        foreach $queueuser ( sort {$queueUserStats{$queue}{$b} <=> $queueUserStats{$queue}{$a}} keys %{$queueUserStats{$queue}})
	{
	  $pageperqueue = $queueUserStats{$queue}{$queueuser};
          write;		
	}
    }

}

sub HandleNewJob
{
 my $realpages  = $lastlogline{num_pages}*$lastlogline{copies};	
 my $hourstring = POSIX::strftime "%H", localtime($lastlogline{time}) ;
 my $daystring  = POSIX::strftime "%d/%m/%y", localtime($lastlogline{time}) ;
 
 $userRequests{$lastlogline{user}}++;
 $userPages{$lastlogline{user}}+=$realpages;
 $dateRequests{$daystring}++;
 $datePages{$daystring}+=$realpages;
 $pageRequests{$realpages}++;
 $queueRequests{$lastlogline{printer}}++;
 $queuePages{$lastlogline{printer}}+=$realpages;
 $hourRequests{$hourstring}++;         
 $copyRequests{$lastlogline{copies}}++;
 $billingStats{$lastlogline{billing}}{"user"}{$lastlogline{user}}     += $realpages;
 $billingStats{$lastlogline{billing}}{"printer"}{$lastlogline{printer}}  += $realpages;
 $billingStats{$lastlogline{billing}}{"total_pages"}      += $realpages;
 $queueUserStats{$lastlogline{printer}}{$lastlogline{user}} += $realpages;

 $totalReq++;
 $totalPages+=$realpages;
}

sub InitHourHistogram
{
 my $i;
 for ($i = 0 ; $i <=24 ; $i++)
 {
	 my $hourstring = sprintf("%02d", $i);
	 $hourRequests{$hourstring}=0;
 }
}

# main
open(PAGELOG,"$PAGE_LOG_FILE") || die "Can't open pagelog file $PAGE_LOG_FILE";


#initialize the hourhistogram
InitHourHistogram;

while(<PAGELOG>)
{
     my $time;
     my $pagenum;
     %logline = ();
     chomp();
    ($logline{printer},
     $logline{user},
     $logline{jobid},
     $time,
     $pagenum,
     $logline{copies},
     $logline{billing}) =
        ($_ =~ /^(.*)\s(.*)\s(\d+)\s(\[.*\])\s(\d+)\s(\d+)\s(.*)$/)
        or do {
	if(! exists $opt{"q"}) {print STDERR "Cannot convert $_ \n";}
	next;
	};
    # downcase username because of samba
    $logline{user}=~ tr/A-Z/a-z/;
    # handle empty user
    if ($logline{user} eq "") {
	    $logline{user}="TestPages";
    }
    # handle empty billing code
    if ($logline{billing} eq "") {
	    $logline{billing}="-none-";
    }
    my $endtime = DateTime2Epoch( $time );

    if ( ! defined $lastlogline{jobid} ||  $lastlogline{jobid} ne $logline{jobid} )
	{
            # new job;
            $logline{num_pages} = 1;
            $logline{time} = $endtime;
            if ( defined $lastlogline{jobid} ) {
  		 HandleNewJob;
		 };
        } else {
            # same job; update info
            $logline{num_pages} = $lastlogline{num_pages} + 1;
            $logline{time} = $lastlogline{time};
        }
	%lastlogline= %logline;

}
close(PAGELOG);

# handle last job
if ( defined $lastlogline{jobid} ) {
     HandleNewJob;
     }



PrintQueueLog;
PrintQueueUserLog;
PrintRequestSize;
PrintCopySize;
PrintBillingLog;
PrintUserLog;
PrintHourLog;
PrintDayLog;

__END__

=head1 NAME

PrintAnalyzer - create statistics from CUPS page_log file

=head1 SYNOPSIS

 PrintAnalyzer [-f filename][-q] 

=head1 DESCRIPTION

This Tool generates statistics from the CUPS page_log file.

Features:

=over 8

=item Queue usage

=item Pages per user per queue (Accounting)

=item Jobsize histogram (all queues in one)

=item Number of copies histogram (all queues in one)

=item Jobs/Pages per hour (all queues in one)

=item Jobs/Pages per day (all queues in one)

=item Jobs/Pages per user (all queues in one)

=item Pages per Billingcode (all queues in one)

=item Pages per User per Billingcode (all queues in one)

=back	

=head1 OPTIONS AND ARGUMENTS

=over 8

=item B<-f> filename

Location of the page_log file

=item B<-q>

Quiet operation

=back

=head1 SEE ALSO

 http://www.cups.org

=head1 AUTHOR

 Thies Moeller

=cut







#!/usr/local/perl/bini -w  
###PROGRAM FOR UNEVEN REGION WISE RANDOM SAMPLING ######By Jayanthi Jayakumar#####
use strict;
#use Array::Shuffle qw(shuffle_array);
use List::Util qw(shuffle);
use Getopt::Long;                                                                                                                                                                   
use File::Basename;                                                                                                                                                                                      
use File::DosGlob qw(bsd_glob);                                                                                                                                                                          
$|=1;                                                                                                                                                                                                    
my $pattern = '/Volumes/DATA/H1N1/Global_HA_March2019/year_wise/*.fasta';                                                                                                                                 
my @combined = glob $pattern;  
for (my $p=0;$p<@combined;$p++)
{
    my $filename_txt = $combined[$p];
    my @file_name = split(/\//,$filename_txt);
    my $file = pop(@file_name);
    my $filename_out = "/Volumes/DATA/H1N1/Global_HA_March2019/year_wise/"."/"."$file";
print $file,"\n";
############################To create directory for each input file################ 
system `mkdir -p "$file"`;
############################To convert fasta file to single line sequence for each ID #####
open("FASTA","<$filename_out") or die "Could not open $file, $!";
my $file_out="$file"."/"."$file"."single_line.txt";
open("OUT",">$file_out");
my @inp1=<FASTA>;
for(my $i=0;$i<@inp1;$i++)
{
chomp($inp1[$i]);
if ($inp1[$i]=~m/^>/)
{
chomp($inp1[$i]);
#$inp[$i]=~s/\n/#/g;
$inp1[$i].="#".$inp1[$i+1];
print OUT "$inp1[$i]";
}
}
close OUT;
close FASTA;
##################To separate the files based on region ##################################
open("FASTA3","<$file_out") or "die can't open file";
open("FASTA4",">$file"."/"."Africa.fasta");
open("FASTA5",">$file"."/"."Europe.fasta");
open("FASTA6",">$file"."/"."SG.fasta");
open("FASTA7",">$file"."/"."MEA.fasta");
open("FASTA8",">$file"."/"."SEA.fasta");
open("FASTA9",">$file"."/"."NAmer.fasta");
open("FASTA10",">$file"."/"."SAmer.fasta");
open("FASTA11",">$file"."/"."Oceania.fasta");
open("FASTA12",">$file"."/"."SA.fasta");
open("FASTA13",">$file"."/"."EA.fasta");
my @inp3=<FASTA3>;
my $len=@inp3;
for(my $i=0;$i<$len;$i++)
{
chomp($inp3[$i]);
if($inp3[$i]=~m/#/)
{
my @k=split(/#/,$inp3[$i]);
if ($k[0]=~m/Africa/)
{
print FASTA4 $k[0],"#",$k[1],"\n";
}
if ($k[0]=~m/Europe/)
{
print FASTA5 $k[0],"#",$k[1],"\n";
}
if ($k[0]=~m/SG/)
{
print FASTA6 $k[0],"#",$k[1],"\n";
}
if ($k[0]=~m/MiddleE_WA/)
{
print FASTA7 $k[0],"#",$k[1],"\n";
}
if ($k[0]=~m/SEAsia/)
{
print FASTA8 $k[0],"#",$k[1],"\n";
}
if ($k[0]=~m/NorthAmerica/)
{
print FASTA9 $k[0],"#",$k[1],"\n";
}
if ($k[0]=~m/SouthAmerica/)
{
print FASTA10 $k[0],"#",$k[1],"\n";
}
if ($k[0]=~m/Oceania/)
{
print FASTA11 $k[0],"#",$k[1],"\n";
}
if ($k[0]=~m/SouthAsia/)
{
print FASTA12 $k[0],"#",$k[1],"\n";
}
if ($k[0]=~m/EastAsia/)
{
print FASTA13 $k[0],"#",$k[1],"\n";
}
}
}
###########To read the each separated region and do a rdm sampling####
my $pattern1 = "$file"."/"."*.fasta";  
print $pattern1, "\n" ;                                                                                                                              
my @combined1 = glob $pattern1;  
for (my $p1=0;$p1<@combined1;$p1++)
{
    my $filename_txt1 = $combined1[$p1];
    my @file_name1 = split(/\//,$filename_txt1);
    my $file1 = pop(@file_name1);
    #my $filename_out = "/Volumes/DATA/H1N1/Global_HA_March2019/year_wise/"."/"."$file";
print $file1,"\n";

#####To read the lines from Text file and store in an array ########
open("TXT","<$file"."/"."$file1");
my $file_out2="$file1"."rdm_set.txt";
open("OUT1",">$file"."/"."$file_out2");
my @inp;
while (<TXT>) 
{
chomp($_);
    push(@inp,$_);
}
######To shuffle the line#########################
my @neworder = shuffle(@inp);
print "Please provide the required number of random sequences \n";
my $k=<>;

########################IF STATEMENT FOR RANDOM SEQUENCE below 12 or above 12### If below 12 from any 12 months.
#############IF above 12 Each month there should be evenly distributed sequences##i.e; if random seq #12 we want then ##
####Each month 1 sequence####

############To Print the desired number of shuffled lines ########
for(my $i=0;$i<$k;$i++)
{
print OUT1 "$neworder[$i]\n";
}
close OUT1;
close TXT;

open("TXT2","<$file"."/"."$file_out2");
my $file_out3="$file"."/"."$file1"."out_seq.fa";
open("OUT2",">$file_out3");
my @inp2=<TXT2>;
for(my $j=0;$j<@inp2;$j++)
{
chomp($inp2[$j]);
if ($inp2[$j]=~m/^>/)
{
$inp2[$j]=~s/\n>/#>/g;
$inp2[$j]=~s/>/\n>/g;
$inp2[$j]=~s/#/\n/g;
print OUT2 "$inp2[$j]";
}
}
}
system  `rm  "$file"/*.txt`;
system  `rm "$file"/*.fasta`;
system  `cat "$file"/*.fa > "$file"_rdm.fasta`;
system  `rm "$file"/*.fa`;
close OUT2;
close TXT2;

}


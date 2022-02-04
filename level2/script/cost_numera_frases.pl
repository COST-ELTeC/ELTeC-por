#!/usr/bin/perl -w

if ($ARGV[0] eq "-h") { print <<FIM;

COST_NUMERA_FRASES
Programa que põe os números das frases certos depois de apagar alguns
erros

Chamada: $0 < ficheiro de entrada

                                      DMS, 7 de março de 2021

FIM
exit;
} else {
    $fich=$ARGV[0];
    shift;
}

$dentroforeign=0;
$dentroquote=0;
$nums=0;
while (<>) {
#   if (/<word id=\"1\"/ and not /postag=\"X\"/) {
   if (/<word id=\"1\"/ and not $dentroforeign and not $dentroquote) {
       print "<s xml:id=\"$fich.s$nums\">\n$_";
       $nums++;
   } else {
       print;
       if (/<quote/) {
	   $dentroquote=1;
       } elsif (/<foreign/) {
	   $dentroforeign=1;
       } elsif (/<\/foreign/) {
	   $dentroforeign=0;
       } elsif (/<\/quote/) {
	   $dentroquote=0;
       }
   }
}

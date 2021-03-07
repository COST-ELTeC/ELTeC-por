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

$nums=0;
while (<>) {
   if (/<word id=\"1\"/ and not /postag=\"X\"/) {
   	print "<s xml:id=\"$fich.s$nums\">\n$_";
	$nums++;
   } else {
       print;
   }
}			

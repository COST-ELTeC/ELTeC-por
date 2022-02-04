#!/usr/bin/perl -w

if ($ARGV[0]) { print <<FIM;

COST_TRATA_QUOTES
Programa que retira os casos de separação de frases dentro de <quote>

Chamada: $0 < ficheiro de entrada

                                      DMS, 4 de fevereiro de 2022

FIM
exit;
}
$fich=join('',<>);
@partes=split '</l>', $fich;

foreach $parte (@partes) {

    ($antes,$linha)=($parte=~/^(.*)<l>\n(.*)$/ms);
#    print "Linha: $linha\n";
    $linha=~s/<\/s>\n//g;
#    print "Linha2: $linha\n";
    print "$antes<l>\n$linha</l>" if ($linha);
}
print $partes[$#partes];


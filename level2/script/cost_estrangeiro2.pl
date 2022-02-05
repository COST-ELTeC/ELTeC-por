#!/usr/bin/perl -w

if ($ARGV[0]) { print <<FIM;

COST_ESTRANGEIRO2
Programa que muda a POS de tudo o que está dentro da tag foreign
para postag="X"

Chamada: $0 < ficheiro de entrada

                                      DMS, 5 de março de 2021

FIM
exit;
}
$fich=join('',<>);
@partes=split '</foreign>', $fich;
foreach $parte (@partes) {

    ($antes,$fore,$foreign)=($parte=~/^(.*)(<foreign.*?>\n)(.*)$/ms);
    $foreign=~s/postag=\".*?\"/postag=\"X\"/g;
    $foreign=~s#</s>\n##g;
    print "$antes$fore$foreign</foreign>" if ($foreign);

}
print $partes[$#partes];

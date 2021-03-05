#!/usr/bin/perl -w

if ($ARGV[0]) { print <<FIM;

COST_ESTRANGEIRO
Programa que muda a POS de tudo o que está dentro de um parágrfo estrangeiro
para postag="X"

Chamada: $0 < ficheiro de entrada

                                      DMS, 3 de março de 2021

FIM
exit;
}
$/="</p>";
while (<>) {
    if (/<p .*? xml:lang/) {
	s/postag=\".*?\" /postag=\"X\" /g;
    } elsif (/<quote xml:lang/) {
	($antes,$quote)=($_=~m%^(.*?)(<quote.*</quote>)(.*)$%s);
	$quote=~s/postag=\".*?\"/postag=\"X\"/g;
	$_=$antes.$quote.$depois;
    }
   print;
}

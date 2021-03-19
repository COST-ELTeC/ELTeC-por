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
	s#</s>\n##g; #porque em casos estrangeiros não se contam frases
    } elsif (/<foreign xml:lang/) {
	($antes,$quote,$depois)=($_=~m%^(.*?)(<foreign.*</foreign>)(.*)$%s);
	$quote=~s/postag=\".*?\"/postag=\"X\"/g;
	$quote=~s#</s>\n##g;
	$_=$antes.$quote.$depois;
    
    } elsif (/<quote xml:lang/) {
	($antes,$quote,$depois)=($_=~m%^(.*?)(<quote.*?</quote>)(.*)$%s);
	$quote=~s/postag=\".*?\"/postag=\"X\"/g;
	$quote=~s#</s>\n##g;
#	$quote=~s#</s>\n</l>#</l>#g;  # porque não se contam s em textos estranegiros
	$_=$antes.$quote.$depois;
    }
   print;
}

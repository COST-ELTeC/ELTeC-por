#!/usr/bin/perl -w

if ($ARGV[0] eq "-h") { print <<FIM;

COST_TRADUZ_PQUOTE
Programa que pega no resultado do conversor do PALAVRAS para MALT e
põe <p> e <quote> e <l>

Chamada: $0 < ficheiro de entrada

                                      DMS, 28 de fevereiro de 2021

FIM
exit;
} else {
    $fich=$ARGV[0];
    shift;
}
$par=0;
$nums=0;
$nump=0;
while (<>) {
   if (/<p ([^>]*?)>/) {
	s#<p ([^>]*?)>#<p xml:id=\"$fich.p$nump\" $1>#g;
	$nump++;
	print;
    } elsif (/<p>/) {
	s#<p>#<p xml:id=\"$fich.p$nump\">#g;
	$nump++;
	print;
    } elsif (/<note /) {
	s/<note /<note xml:id=/g;
	print;
    } elsif (/form=\"\.\.\.\"/ and not /word id=\"1\"/) {
	$talvezfimlinha=1;
	$guardalinha=$_;
    } elsif (/form=\"\.\"/ and $talvezfimlinha) {
	$talvezfimlinha=0;
    } elsif ($talvezfimlinha) {
	$talvezfimlinha=0;
	print $guardalinha;
	$guardalinha="";
	print;
    } elsif (/<word id=\"1\" /) {
	print "<s xml:id=\"$fich.s$nums\">\n$_";
	$nums++;
    } elsif (/^\s*$/) {
	print "</s>\n";
    } else {
	print;
    }
}

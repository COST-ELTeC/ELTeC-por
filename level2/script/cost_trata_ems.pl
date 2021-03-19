#!/usr/bin/perl -w

if ($ARGV[0]) { print <<FIM;

COST_TRATA_EMS
Programa que pega no resultado do conversor do PALAVRAS para MALT e
desdobra as EM

Chamada: $0 < ficheiro de entrada

                                      DMS, 28 de fevereiro de 2021

FIM
exit;
}
$em=0;
while (<>) {
    if (/_/) {
	$linha=$_;
	($forma)=($_=~/form=\"(.*?)?\"/);
	$forma=~s/\(/\\\(/g;
	$forma=~s/\)/\\\)/g;
	@formas=split(/_/,$forma);
#	print "formas: @formas\n";
# aqui faz-se mais alguma coisa se for EM
#	if (/postag=\"PROP/ and / sem=(.*?) /) {
	if (/ner=\"NER:(.*?)\"/ and not (/postag=\"X\"/)) {
	    $ner=$1;
	    $ner=~s/\s.*//;
#	    $ner=~s/|//g;
	    print "<rs type=\"$ner\">\n";
	    $linha=~s/ner=\".*?\"//;
	    $em=1;
	}
	foreach $f (@formas) {
	    $linha2=$linha;
	    $linha2=~s/$forma/$f/;
	    if ($conta) {
		$linha2=~s/id=\"1\"/id="0"/;
	    }
	    print $linha2;
	    $conta++;
	} 
	$conta=0;
	if ($em) {
	    print "</rs>\n";
	    $em=0;
	}
    } elsif (/NER:(.*?)\"/ and not (/postag=\"X\"/)) {
	$ner=$1;
	$ner=~s/\s.*//;
	print "<rs type=\"$ner\">\n";
	s/ner=\".*?\"//;
	print "$_</rs>\n";
    } else {
	print;
    }
}

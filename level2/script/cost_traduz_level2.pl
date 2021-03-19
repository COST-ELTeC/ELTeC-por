#!/usr/bin/perl -w

if ($ARGV[0] eq "-h") { print <<FIM;

COST_TRADUZ_LEVEL2
Programa que pega no resultado do conversor do PALAVRAS para MALT ed
ransforma no formato do level do 

Chamada: $0 < ficheiro de entrada

                                      DMS, 28 de fevereiro de 2021

FIM
exit;
} else {

    $fich=$ARGV[0];
    shift;
}
$numw=$numpont=0;
while (<>) {
    if (/<word/) {
	($palavra,$lema,$pos)=($_=~m/ form=\"(.*?)\" base=\"(.*?)\" postag="(.*?)\"/);
#	print "$palavra POS $pos\n";
	if (/morf=/) {
	    ($morf)=($_=~/morf=\"(.*?)\"/);
	} else {
	    $morf="";
	}
	if ($palavra) {
	    print "<w xml:id=\"$fich.w$numw\" pos=\"$pos\" lemma=\"$lema\" msd=\"$morf\">$palavra</w>\n";
	    $numw++;
	} else {
	    ($palavra,$pos)=($_=~m/ form=\"(.*?)\" postag="(.*?)\"/);
	    print "<pc xml:id=\"$fich.pc$numpont\" pos=\"$pos\">$palavra</pc>\n";
	    $numpont++;
	}
#    } elsif (/<lixo/ or /^<[A-Z]/ or /<DERP/) {
#    } elsif (/<lixo/ or /<DER[PS]/) {
    } elsif (/<lixo/) {
#    } elsif (/<lixo/ or /\[sórd/ or /décimo=/) {
    } else {
	print;
    }
}

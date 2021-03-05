#!/usr/bin/perl -w

if ($ARGV[0]) { print <<FIM;

COST_JUNTA_DUPLO_CLITICO
Programa que junta os cliticos depois do resultado do malt.

Chamada: $0 < ficheiro de entrada

                                      DMS, 4 de março de 2021

FIM
exit;
}

while (<>) {
    if (/form=\"se\-\"/ and /hyfen/) {
	($id,$palavraant,$lemaant,$posant,$morfant)=($_=~m/ id=\"(.*?)\" form=\"(.*?)\" base=\"(.*?)\" postag=\"(.*?)\" morf=\"(.*?)\"/ );
	$clitico=1;
#	print "$palavra POS $pos\n";
    } elsif (/<word/ and $clitico and /form=\"(.*?)\"/) {
	$palavra=$1;
	$contraida="$palavraant$palavra";
	$pal=$contraida;
	s/form=\"(.*?)\"/form="$pal"/;
	s/base=\"/base="$lemaant+/;
	s/postag=\"/postag="$posant+/;
	s/morf=\"/morf="$morfant+/;
	s/id=\".*?\" /id="$id" /;
	$palavraant="";
	$lemaant="";
	$posant="";
	$morfant="";
	$clitico=0;
	print;
    } else {
	print;
    }
}

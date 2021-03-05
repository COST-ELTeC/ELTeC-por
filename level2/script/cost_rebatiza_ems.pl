#!/usr/bin/perl -w

if ($ARGV[0] eq "-h") { print <<FIM;

COST_REBATIZA_EMS
Programa que muda os nomes das EMS do PALAVRAS para as do COST

DEMO EVENT FAC MISC ORG PERS PLACE ROLE WORK

Chamada: $0 < ficheiro de entrada

                                      DMS, 5 de março de 2021

FIM
exit;
}
%trads=("Hnat","DEMO","Hprof", "ROLE","official","ROLE", "civ", "PLACE", "top", "PLACE", "site", "PLACE", "hum", "PERS", "groupind", "PERS", "event", "EVENT", "cyclic", "EVENT", "occ", "EVENT", "media", "WORK", "product", "WORK", "tit", "WORK", "artwork", "WORK", "brand", "WORK", "org", "ORG", "inst", "ORG", "party", "ORG");

while (<>) {
    if (/<rs type=\"(.*?)\"/) {
	$tipo=$1;
#	print "TIPO: $tipo\n";
	if (exists $trads{$tipo}) {
	    s/$tipo/$trads{$tipo}/;
	} else {
	    s/$tipo/MISC/;
	}
    }
    print;
}

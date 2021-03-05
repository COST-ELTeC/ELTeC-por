#!/usr/bin/perl -w

if ($ARGV[0]) { print <<FIM;

COST_JUNTA_CONTRACOES
Programa que junta as contrações depois do resultado do malt.

Chamada: $0 < ficheiro de entrada

                                      DMS, 4 de março de 2021

FIM
exit;
}

while (<>) {
    if (/<word/ and /sam\-&gt/) {
	($id,$palavraant,$lemaant,$posant)=($_=~m/ id=\"(.*?)\" form=\"(.*?)\" base=\"(.*?)\" postag=\"(.*?)\"/);
#	print "$palavra POS $pos\n";
	if (not $palavraant) { # para tratar desse problema, de não ter pos
	    ($id,$palavraant,$lemaant,$morfant)=($_=~m/ id=\"(.*?)\" form=\"(.*?)\" base=\"(.*?)\"/ );
	    $posant="PRP";
	}
    } elsif (/<word/ and /extra=\"-sam/ and /form=\"(.*?)\"/) {
	$palavra=$1;
	$contraida="$palavraant+$palavra";
	$pal=&regenera_pal($contraida);
	s/form=\"(.*?)\"/form="$pal"/;
	s/base=\"/base="$lemaant+/;
	s/postag=\"/postag="$posant+/;
	s/ extra=\".*?\"//;
	s/id=\".*?\" /id="$id" /;
	$palavraant="";
	$lemaant="";
	$posant="";
	print;
    } else {
	print;
    }
}
sub regenera_pal {
    local $pala=$_[0];
    $pala=~s/^De\+/D/;
    $pala=~s/^de\+/d/;
    $pala=~s/^Em\+/N/;
    $pala=~s/^em\+/n/;
    $pala=~s/^Por\+/Pel/;
    $pala=~s/^por\+/pel/;
    $pala=~s/^a\+a/à/;
    $pala=~s/^A\+a/À/;
    $pala=~s/^a\+/a/;
    $pala=~s/^A\+/A/;
    $pala=~s/^Eis\+/Ei/;
    $pala=~s/^eis\+/ei/;
    $pala=~s/=de\+/=d/;
    $pala=~s/=a\+a/=à/;
    $pala=~s/=a\+/=a/;
    $pala=~s/^lhe\&lhes\+/lh/;
    $pala=~s/^me\+/m/;
    $pala=~s/^te\+/t/;
    $pala=~s/^para\+/pr/;
    $pala=~s/^Para\+/Pr/;

    $pala=~s/^Com\+mim/Comigo/;
    $pala=~s/^com\+mim/comigo/;
    $pala=~s/^Com\+ti/Contigo/;
    $pala=~s/^com\+ti/contigo/;
    $pala=~s/^Com\+si/Consigo/;
    $pala=~s/^com\+si/consigo/;
    $pala=~s/^Com\+nós/Connosco/;
    $pala=~s/^com\+nós/connosco/;
    $pala=~s/^Com\+vós/Convosco/;
    $pala=~s/^com\+vós/convosco/;

    $pala=~s/^aquele\+outr/aqueloutr/;
    $pala=~s/^([Dd])e\+entre/$1entre/;
    return $pala; 
}

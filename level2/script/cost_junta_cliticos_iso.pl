#!/usr/bin/perl -w

if ($ARGV[0]) { print <<FIM;

COST_JUNTA_CLITICOS
Programa que junta os cliticos depois do resultado do malt.

Chamada: $0 < ficheiro de entrada

                                      DMS, 4 de março de 2021

FIM
exit;
}

while (<>) {
    if (/<word/ and /hyfen/) {
	($id,$palavraant,$lemaant,$posant,$morfant)=($_=~m/ id=\"(.*?)\" form=\"(.*?)\" base=\"(.*?)\" postag=\"(.*?)\" morf=\"(.*?)\"/ );
	$clitico=1;
	if (not $palavraant) { # para tratar desse problema, de não ter pos
	    ($id,$palavraant,$lemaant,$morfant)=($_=~m/ id=\"(.*?)\" form=\"(.*?)\" base=\"(.*?)\" morf=\"(.*?)\"/ );
	    $posant="PRP";
	}
#	print "$palavra POS $pos\n";
    } elsif (/<word/ and $clitico and /form=\"(.*?)\"/) {
	$palavra=$1;
	$contraida="$palavraant$palavra";
	$pal=&regenera_pal($contraida);
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

sub regenera_pal {
    local $pala=$_[0];
#    print STDERR "REGENERA $pala...\n";
    if (($morfant =~/PR.*IND/) or ($morfant =~/FUT.*IND/) or ($morfant =~/COND/) or ($morfant =~/PS.*IND/) or ($morfant =~/IMPF.*IND/) or ($morfant =~/MQP.*IND/) or ($morfant =~/INF/) or ($morfant =~/PR.*SUBJ/)) { 
# presente e mais-que-perfeito e perfeito e imperfeito e presente do conjuntivo
        $pala=~s/mos\-([nv]os)/mo-$1/;
   }    
    if (($morfant =~/IMPF.*IND/) 
                 or ($morfant =~/PR.*IND/)) # altera<E7><E3>o 2 Maio 2010
    {
        $pala=~s/as\-l([oa]s*)/a-l$1/;
    }
    if ($morfant =~/PR.*IND/) {
        $pala=~s/es\-l([oa]s*)/e-l$1/;
    }
    if (($morfant =~/INF/) or ($morfant =~/FUT.*SUBJ/) or ($morfant =~/FUTHAVER/) ) {
# infinitivo
        $pala=~s/er\-l([^h])/ê-l$1/;
        $pala=~s/ar\-l([^h])/á-l$1/;
        $pala=~s/ir\-l([^h])/i-l$1/;
        $pala=~s/or\-l([^h])/ô-l$1/;
        $pala=~s/ôr\-l([^h])/ô-l$1/; 
    }

    if ($morfant =~/COND/) {
# condicional
        $pala=~s/eri(a[sm]*)\-l([oa]s*)/ê-l$2-i$1/;
        $pala=~s/ari(a[sm]*)\-l([oa]s*)/á-l$2-i$1/;
        $pala=~s/iri(a[sm]*)\-l([oa]s*)/i-l$2-i$1/;
        $pala=~s/ori(a[sm]*)\-l([oa]s*)/ô-l$2-i$1/;
        $pala=~s/ôri(a[sm]*)\-l([oa]s*)/ô-l$2-i$1/;# para o verbo p<F4>r 13/6/2007
        $pala=~s/eri(a[sm]*)\-(se|me|mos*|mas*|[nv]os|lh[eao]s*)/er-$2-i$1/;
        $pala=~s/ari(a[sm]*)\-(se|me|mos*|mas*|[nv]os|lh[eao]s*)/ar-$2-i$1/;
        $pala=~s/iri(a[sm]*)\-(se|me|mos*|mas*|[nv]os|lh[eao]s*)/ir-$2-i$1/;
        $pala=~s/ori(a[sm]*)\-(se|me|mos*|mas*|[nv]os|lh[eao]s*)/or-$2-i$1/;
        $pala=~s/ôri(a[sm]*)\-(se|me|mos*|mas*|[nv]os|lh[eao]s*)/or-$2-i$1/; 
    }
# futuro
    if ($morfant =~/FUT_IND/) {
        $pala=~s/([aeioô])r(ás*)\-(se|te|me|mos*|mas*|[nv]os|lh[eao]s*)/$1r-$3-$2/;
        $pala=~s/([aeioô])r(eis*)\-(se|me|te|mos*|mas*|[nv]os|lh[eao]s*)/$1r-$3-$2/ if ($lemaant !~/[aeio]rar$/);
        $pala=~s/([aeioô])remos\-(se|me|te|mos*|mas*|[nv]os|lh[eao]s*)/$1r-$2-emos/;
        $pala=~s/([aeioô])rão\-(se|me|te|mos*|mas*|[nv]os|lh[eao]s*)/$1r-$2-ão/;
        $pala=~s/erá\-(l[ao]s*)/ê-$1-á/;
        $pala=~s/ará\-(l[ao]s*)/á-$1-á/;
        $pala=~s/irá\-(l[ao]s*)/i-$1-á/;
        $pala=~s/orá\-(l[ao]s*)/ô-$1-á/;
        $pala=~s/ôrá\-(l[ao]s*)/ô-$1-á/;# para o verbo p<F4>r 13/6/2007
    }
    $pala=~s/uz\-l([oa])/u-l$1/; #para mudar puz-los para pu-los 12/3/2006
    $pala=~s/iz\-l([oa])/i-l$1/; #para mudar fiz-los para fi-los 29/8/2006
    $pala=~s/oz\-l([oa])/ô-l$1/; #para mudar poz-los para p<F4>-los 19/1/2008
    $pala=~s/ez\-l([oa])/ê-l$1/; #para mudar fez-los para f<EA>-los 29/8/2006
    $pala=~s/az\-l([oa])/á-l$1/; #para mudar faz-los para f<E1>-los 13/6/2007
    $pala=~s/\-$//;
    return $pala;
}

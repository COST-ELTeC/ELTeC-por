#!/usr/bin/perl 

if ($ARGV[0] eq "-h") { print <<FIM;

COST_TRANSFORMA_LEVEL1
Programa que p�e o n�vel 1 do COST de uma forma que ret�m as tags do XML
partindo do <front>

                                         DMS, 28 de fevereiro de 2021
FIM
exit;
} else {
    $fich=$ARGV[0];
    shift;
}

open(FICH,$fich) or die "N�o consegui abrir o ficheiro $fich\n";
@Texto=<FICH>;
close(FICH);
$texto=join('',@Texto);
@bocados=split(/<front>/,$texto);
$cabecalho=$bocados[0];
# aqui trato o que � preciso no cabe�alho
$pref=$fich;
$pref=~s/_.*$//;
open(CABECALHO, ">cabe$pref") or die "N�o consegui abrir cabe$pref\n";
$cabecalho=~s#<\?xml-model href=\"../../Schemas/eltec-1.rng#<\?xml-model href=\"https://github.com/COST-ELTEC/Schemas/raw/master/eltec-2.rng#g;
$cabecalho=~s#<encodingDesc n="eltec-1">\n<p/>#<encodingDesc n="eltec-2">\n<p>The information for level 2 (tokenisation, sentence separation, lemmatisation, morphological analysis and named entity recognition) was performed by the <ref target="https://visl.sdu.dk/visl/pt/">PALAVRAS</ref> parser, with some post conversion for UD-features and ELTeC requirements.</p>#;
print CABECALHO $cabecalho;
close(CABECALHO);
#print $cabecalho, "\n<front>\n<div type=\"titlePage\">";
#exit(0);
$Texto=$bocados[1];
$Texto=~s#<ref target=(\".*?\"/>)# <ref_target=$1 #g;
$Texto=~s/^.*<front>//s;
$Texto=~s#<p>\s*#<p>\n#gs;
$Texto=~s#</p>#\n</p>#gs;
$Texto=~s#<l>#<l>\n#gs;
$Texto=~s#([\w,])\s*</l>#$1....\n</l>#gs;
$Texto=~s#([^\n])</l>#$1\n</l>#gs;
$Texto=~s/<note xml:id=(\".*?\")> /<note $1>\n/g;
$Texto=~s/(<p xml:lang=\".*?\">)/$1\n/g;
$Texto=~s#</note>#\n</note>#gs;
# Isto aqui em baixo era para transformar as tags do XML em algo "comest�vel" pelo PALAVRAS
#$Texto=~s/<\/p>//g;
#$Texto=~s/<p>/PARAGRAFO!\n/g;
#$Texto=~s/<p xml:lang=\"(.*?)\">/PARAGRAFO$1!\n/g;
#$Texto=~s/<l>/LINHA!\n/g;
#$Texto=~s/<\/l>/FIMLINHA!\n/g;
#$Texto=~s/<quote>/CITACAO!\n/g;
#$Texto=~s/<\/quote>/FIMCITACAO!\n/g;
#$Texto=~s/<div type=\"chapter"\><head>(.*?)<\/head>/DIVISAO$1!\n/g;
#$Texto=~s/<div type=\"chapter\">/DIVCAPITULO!\n/;
#$Texto=~s/<\/div>/FIMDIVISAO!\n/g;
#$Texto=~s/<div type=\"notes\">/DIVNOTAS!\n/g;
#$Texto=~s/<\/back>/FIMBACK!\n/g;
#$Texto=~s/<back>/DIVBACK!\n/g;
#$Texto=~s/<\/body>/FIMBODY!\n/g;
#$Texto=~s/<body>/DIVBODY!\n/g;
#$Texto=~s/<\/front>/FIMFRONT!\n/g;
#$Texto=~s/<\/note>/\nFIMNOTA!\n/g;
#$Texto=~s/<note xml:id=\"(.*?)\">/DIVNOTA$1!\n/g;
#$Texto=~s/<ref target=.*?>//g;
print $Texto;

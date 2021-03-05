#!/usr/bin/perl 

if ($ARGV[0] eq "-h") { print <<FIM;

COST_LIMPA_MALT
Programa que retira  a parte do XML do MALT

                                         DMS, 28 de fevereiro de 2021
FIM
exit;
} 



@Texto=<>;
$texto=join('',@Texto);
$texto=~s/^.*<body>/<body>/s;
$texto=~s/<\/sentence[^>]*>\n//g;
$texto=~s/<multistar[0-9]>\n//g;
$texto=~s#</TEI>.*$#</TEI>\n#s;
print $texto;

# How to use the scripts
Here are all the programs used for conversion from PALAVRAS's malt format to ELTeC level 2 format.
The pipeline is as follows
for i in POR000[2-9]*xml; do pref=`echo $i | sed 's/_.*//'`; cost_transforma_level1.pl $i | ~/palavras-r14008/por.pl --prop-dep | ~/palavras-r14008/bin/visldep2malt.pl --lang pt --markup c --fields n --xml h |cost_limpa_malt.pl | cost_traduz_pquote.pl $pref | cost_estrangeiro.pl| cost_trata_ems.pl | cost_remove_s_repetidos.pl | cost_junta_contracoes.pl| cost_junta_duplo_clitico.pl | iconv -f utf8 -t iso-8859-1 > temp$pref; export PERL_UNICODE=0; cat temp$pref | cost_junta_cliticos.pl| iconv -f iso-8859-1 -t utf8| cost_traduz_level2.pl $pref | cost_rebatiza_ems.pl > res$i;  cat cabe$pref res$i > ../level2/$i; export PERL_UNICODE=SDA; done;

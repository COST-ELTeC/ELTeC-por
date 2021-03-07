#!/usr/bin/perl -w

if ($ARGV[0]) { print <<FIM;

COST_REMOVE_S_REPETIDOS
Programa que retira os caos espúrios de </s>

Chamada: $0 < ficheiro de entrada

                                      DMS, 28 de fevereiro de 2021

FIM
exit;
}
$/="</p>";
while (<>) {
    s#</p>#</s>\n</p>#g;
    s#</l>#</s>\n</l>#g;
#    s#<p>\n</s>#<p>#g;
    s#<l>\n</s>#<l>#g;
    s#(<p xml.*?>)\n</s>#$1#g;
    s#</s>\n</s>\n<foreign ([^>]*?)>\n</s>\n</s>#<foreign $1>#g;
    s#<foreign ([^>]*?)>\n</s>\n</s>#<foreign $1>#g;
    s#</s>\n</s>\n</foreign>\n</s>\n</s>#</foreign>\n</s>#g;
    s#</s>\n</s>\n</foreign>#</foreign>#g;
    s#</s>\n</s>#</s>#g;
    print;
}

exit();
if ($ola) {
    s#(<p .*?xml:id=.*?>)\n</s>\n</s>#$1#;
    s#(<note xml:id=.*?>)\n</s>\n</s>\n</p>#$1#;
    s#</div>\n</s>\n</s>#</p>\n</div>#; #adiciono um fim de parágrafo, mas que fica a mais no back...
    s#</head>\n</s>\n</s>\n</p>#</head>#;

    s#(<rs type=.*?>)\n(<s xml:id=.*?>)#$2\n$1#; # para resolver a ordem das EM na primeira palavra de uma frase...
    s#<quote>\n</s>\n</s>\n<l>\n</s>\n</s>#<quote>\n<l>#g;
    s#</l>\n</s>\n</s>\n<l>\n</s>\n</s>#</s>\n</l>\n<l>#g;
    s#</l>\n</s>\n</s>\n</quote>\n</s>\n</s>#</s>\n</l>\n</quote>#g;
    s#<quote>\n</s>\n</s>#<quote>#g;
    s#</quote>\n</s>\n</s>#</quote>#g;
    s#<body>\n</s>\n</s>#<body>#;
    s#</body>\n</s>\n</s>#</body>#;
    s#(<div type=\"chapter\">)\n</s>\n</s>\n</p>#$1#g;
    s#(<div type=\"notes\">)\n</s>\n</s>#$1#;
    s#</front>\n</s>\n</s>#</front>#;
    s#</back>\n</s>#</back>\n</text>\n</TEI>\n#;
    s#<back>\n</s>\n</s>#<back>#;
    s#</note>\n</s>\n</s>#</p>\n</note>#;
    s#</note>\n</p>\n</div>#</note>\n</div>#; # e aqui retiro-o
    s#</s>\n</s>#</s>#g;
    print;
}

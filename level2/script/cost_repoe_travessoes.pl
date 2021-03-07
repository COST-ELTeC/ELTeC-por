#!/usr/bin/perl -w

if ($ARGV[0]) { print <<FIM;

COST_REPOE_TRAVESSOES
Programa que coloca travessõe sonde não está nada. Eventualmente tb poderá
marcar o discurso direto, se na pos puser COMECA e ACABA

Chamada: $0 < ficheiro de entrada

                                      DMS, 6 de março de 2021

FIM
exit;
}
@Texto=<>;
$texto=join('',@Texto);
$texto=~s#pos=\"\"></pc>#pos="pu">--</pc>#gs;
print $texto;


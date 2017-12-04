%{
#include <cstdio>
#include <iostream>
#include "sintatico.tab.h"

using namespace std;

int linha = 1;

extern int yylval;
%}

%%
"INICIO"          return(INICIO);
"DEADPOOL"        return(DEADPOOL);
"ESPADINHA"       return(ESPADINHA);
"PONTARIA"        return(PONTARIA);
"CURAACELERADA"   return(CURAACELERADA);
"MESTREDASARMAS"  return(MESTREDASARMAS);
"VELOCIDADE"      return(VELOCIDADE);
"IRONMAN"         return(IRONMAN);
"ARMADEFOTONS"    return(ARMADEFOTONS);
"RAIODEENERGIA"   return(RAIODEENERGIA);
"VISAOTERMAL"     return(VISAOTERMAL);
"MAGNETISMO"      return(MAGNETISMO);
"INVISIBILIDADE"  return(INVISIBILIDADE);
[a-z0-9]*    {return(INVALIDO);}
\n	     { ++linha; return (END_OF_LINE);}
"FIM"        return (FIM);
.            ;
%%

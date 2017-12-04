%{
#include <cstdio>
#include <iostream>
using namespace std;

extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern int linha;


int yyerror(const char *mens);
%}
%start battle 
%token GUERREIRO ATAQUE ESCUDO POCAO
%token MAGO BOLADEFOGO CANALIZAR CURAR
%token LADRAO FLECHA ESQUIVA ATADURA 
%token INICIO END_OF_LINE FIM INVALIDO
%left  GUERREIRO MAGO LADRAO INICIO END_OF_LINE FIM
%%
battle    :	INICIO END_OF_LINE jogar END_OF_LINE
		{
			exit(0);
		}
		;
jogar	: GUERREIRO comandosGuerreiro END_OF_LINE jogar |
        
        MAGO comandosMago END_OF_LINE jogar |
        
        LADRAO comandosLadrao END_OF_LINE | fim
        
comandosGuerreiro : 
       		ATAQUE 
		{
			printf("GUERREIRO ATAQUE    ");
		} 
		| 
		ESCUDO 
		{
			printf("GUERREIRO ESCUDO    ");
		} 
		|
		POCAO
		{
			printf("GUERREIRO POCAO     ");
	        } 
		|INVALIDO
		{
			printf("GUERREIRO INVALIDO  ");
		} 
		;
comandosMago  : INVALIDO 
		{
			printf("MAGO      INVALIDO  ");
		} 
		|
        	BOLADEFOGO
        	{
        		printf("MAGO      BOLADEFOGO");
        	}
		|
		CANALIZAR 
		{
			printf("MAGO      CANALIZAR ");
		}
		|
		CURAR 
		{
			printf("MAGO      CURAR     ");
		} 
		;
comandosLadrao :  INVALIDO
		{
			printf("LADRAO    INVALIDO  ");
		} 
		|
	 	FLECHA 
		{
			printf("LADRAO    FLECHA    ");
		}
		|
		ESQUIVA 
		{
			printf("LADRAO    ESQUIVA   ");
		}
                |
		ATADURA 
		{
			printf("LADRAO    ATADURA   ");
		}
		;
fim: FIM
%%
/* codigo do usuario */

int
main(int argc, char **argv)
{
	char arquivoJogador[30];
	FILE *arquivo;
	
	cout << " Por favor, informe o arquivo do jogador: ";
	cin >> arquivoJogador;
	arquivo = fopen(arquivoJogador,"r");

	if (!arquivo) {
		printf("\nFalha ao abrir arquivo[%s] do jogador!\n",arquivoJogador);
		return -1;
	}
	
	// Seta o LEX para ler o arquivo1 atraves da variavel yyin 
	yyin = arquivo;
	
	// Realiza o parse para o arquivo
	do {
		yyparse();
	} while ( !feof(arquivo) );
	
	fclose(arquivo);

	return(0);
}




int
yyerror(const char *mens)
{
	fprintf(stderr, "Comando da linha %d inválido: %s\n\n", linha, mens);
	return(1);
}



int 
yywrap(void) {	
	// A funcao yywrap, deve retornar 0 para continuar o parse com outro arquivo
	return(1);
}

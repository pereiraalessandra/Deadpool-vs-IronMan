%{
#include <cstdio>
#include <iostream>
using namespace std;

#define DEADPOOL_HP_TOTAL 20000
#define IRON_MAN_HP_TOTAL 20000

extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern int linha;

int deadpoolHP = DEADPOOL_HP_TOTAL;
int ironManHP = IRON_MAN_HP_TOTAL;

int yyerror(const char *mens);

void espadinha();
void pontaria();
void curaAcelerada();
void mestreDasArmas();
void velocidade();
void armaDeFotons();
void raioDeEnergia();
void visaoTermal();
void magnetismo();
void invisibilidade();

%}
%start battle 
%token DEADPOOL ESPADINHA PONTARIA CURA_ACELERADA MESTRE_DAS_ARMAS VELOCIDADE
%token IRONMAN ARMA_DE_FOTONS RAIO_DE_ENERGIA VISAO_TERMAL MAGNETISMO INVISIBILIDADE
%token INICIO END_OF_LINE FIM INVALIDO
%left  DEADPOOL IRONMAN INICIO END_OF_LINE FIM
%%
battle    :	INICIO END_OF_LINE turnoDeadpool END_OF_LINE |
			INICIO END_OF_LINE turnoIronMan END_OF_LINE
		{
			exit(0);
		}
		;
turnoDeadpool	: DEADPOOL comandosDeadpool END_OF_LINE turnoIronMan |
				  FIM
        	;

turnoIronMan	: IRON_MAN comandosIronMan END_OF_LINE turnoDeadpool |
				  FIM
		;

comandosDeadpool : 
       		ESPADINHA
		{
			espadinha();
		} 
		| 
		PONTARIA 
		{
			pontaria();
		} 
		|
		CURA_ACELERADA
		{
			curaAcelerada();
	        }
		|
		MESTRE_DAS_ARMAS
		{
			mestreDasArmas();
		}
		|
		VELOCIDADE
		{
			velocidade();
		}
		|INVALIDO
		{
			printf("COMANDO INVALIDO");
		} 
		;
comandosIronMan  :
        	ARMA_DE_FOTONS
        	{
        		armaDeFotons();
        	}
		|
		RAIO_DE_ENERGIA 
		{
			raioDeEnergia();
		}
		|
		VISAO_TERMAL 
		{
			visaoTermal();
		} 
		|
		MAGNETISMO
		{
			magnetismo();
		}
		|
		INVISIBILIDADE
		{
			invisibilidade();
		}		
		INVALIDO 
		{
			printf("COMANDO INVALIDO");
		} 					
		;
FIM: FIM;
%%
/* codigo do usuario */

int main(int argc, char **argv)
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

int yyerror(const char *mens)
{
	fprintf(stderr, "Comando da linha %d inválido: %s\n\n", linha, mens);
	return(1);
}

void espadinha() {

}

void pontaria() {

}

void curaAcelerada() {

}

void mestreDasArmas() {

}

void velocidade() {

}

void armaDeFotons() {

}

void raioDeEnergia(); {

}

void visaoTermal() {

}

void magnetismo() {

}

void invisibilidade() {

}

int yywrap(void) {	
	// A funcao yywrap, deve retornar 0 para continuar o parse com outro arquivo
	return(1);
}

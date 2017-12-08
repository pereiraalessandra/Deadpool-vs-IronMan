%{
#include <cstdio>
#include <iostream>
using namespace std;

extern int yylex();
extern int yyparse();
extern FILE *yyin;

extern int linha;

#define HP_DEADPOOL 20000
#define HP_IRONMAN 20000

int deadpoolHP = HP_DEADPOOL;
int ironManHP = HP_IRONMAN;

bool pontariaDead = false;
bool velocidadeDead = false;

bool visaoTermalIron = false;
bool magnetismoIron = false;

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

void verificaMorte();

%}
%start batalha
%token DEADPOOL ESPADINHA PONTARIA CURA_ACELERADA MESTRE_DAS_ARMAS VELOCIDADE
%token IRONMAN ARMA_DE_FOTONS RAIO_DE_ENERGIA VISAO_TERMAL MAGNETISMO INVISIBILIDADE
%token INICIO END_OF_LINE FIM INVALIDO
%left  DEADPOOL IRONMAN INICIO END_OF_LINE FIM
%%
batalha    :	INICIO END_OF_LINE turnoDeadpool END_OF_LINE |
			INICIO END_OF_LINE turnoIronMan END_OF_LINE
		{
			exit(0);
		}
		;
turnoDeadpool	: DEADPOOL comandosDeadpool END_OF_LINE turnoIronMan | FIM ;

turnoIronMan	: IRONMAN comandosIronMan END_OF_LINE turnoDeadpool | FIM ;

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
%%
/* codigo do usuario */

int main(int argc, char **argv)
{
	char arquivoEntrada[30];
	FILE *arquivo;

	cout << "Informe o arquivo de Entrada: ";
	cin >> arquivoEntrada;
	arquivo = fopen(arquivoEntrada,"r");

	if (!arquivo) {
	  cout<<"Arquivo invalido";
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

void verificaMorte() {
	 if(deadpoolHP <= 0){
	 		cout<<"Morte DEDPOOL"<<endl;
			exit(0);
	 }
	 else if(ironManHP <= 0){
	 		cout<<"Morte IRONMAN"<<endl;
	 		exit(0);
	 }
	 cout<<"DEADPOOL HP: "<<deadpoolHP<<" IRONMAN HP:"<<ironManHP<<endl;
}

void espadinha() {
		int dano = 0;
		if(!magnetismoIron){
				if (pontariaDead){
						dano = (HP_IRONMAN * 0.15) * 2;
						pontariaDead = false;
				} else {
						dano = (HP_IRONMAN * 0.15);
				}
		}
		magnetismoIron = false;

		ironManHP -= dano;
		cout<<"Ataque ESPADINHA"<<endl;
		verificaMorte();
}

void pontaria() {
	  pontariaDead = true;
		cout<<"PONTARIA"<<endl;
}

void curaAcelerada() {
		int cura;
		cura = (HP_DEADPOOL * 0.05);
		deadpoolHP += cura;
		cout<<"CURA ACELERADA"<<endl;
		verificaMorte();
}

void mestreDasArmas() {
		int dano = 0;
		if (pontariaDead){
				dano = (HP_IRONMAN * 0.15) * 2;
				pontariaDead = false;
		} else {
				dano = (HP_IRONMAN * 0.15);
		}
		ironManHP -= dano;
		cout<<"Ataque MESTRE DAS ARMAS"<<endl;
		verificaMorte();
}

void velocidade() {
		velocidadeDead = true;
		cout<<"VELOCIDADE"<<endl;
}

void armaDeFotons() {
		int dano = 0;
		if (!velocidadeDead){
			  if(visaoTermalIron){
						dano = (HP_DEADPOOL * 0.25) * 2;
						visaoTermalIron = false;
				}else{
					dano = (HP_DEADPOOL * 0.25);
				}
		}
		velocidadeDead = false;

		deadpoolHP -= dano;
		cout<<"Ataque ARMA DE FOTONS"<<endl;
		verificaMorte();
}

void raioDeEnergia() {
		int dano = 0;
		if (!velocidadeDead){
				if(visaoTermalIron){
						dano = (HP_DEADPOOL * 0.15) * 2;
						visaoTermalIron = false;
				}else{
						dano = (HP_DEADPOOL * 0.15);
				}
		}
		velocidadeDead = false;

		deadpoolHP -= dano;
		cout<<"Ataque RAIO DE ENERGIA"<<endl;
		verificaMorte();
}

void visaoTermal() {
		visaoTermalIron = true;
		cout<<"VISAO TERMAL"<<endl;
}

void magnetismo() {
		magnetismoIron = true;
		cout<<"MAGNETISMO"<<endl;
}

void invisibilidade() {
		int sucesso = true;//falta tratar uma aleatoriedade
		if (sucesso){
				raioDeEnergia();
		}
		cout<<"INVISIBILIDADE"<<endl;
}

int yywrap(void) {
	// A funcao yywrap, deve retornar 0 para continuar o parse com outro arquivo
	return(1);
}

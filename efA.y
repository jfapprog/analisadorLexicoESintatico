%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	
	/*variáveis globais externas - ficheiro efAFlex.c*/
	extern int yylineno;	
	extern FILE* yyin;

	/*variável global*/
	int numeroErros = 0;

	/*função externa - ficheiro efAFlex.c*/
	extern int yylex();
	
	/*protótipo da função chamada em caso de não reconhecimento da sintaxe*/
	int yyerror(char* s);
	
%}

%union {
	int numInt;
	double numDou;
	char nomeVar[128+1];
}

%type <nomeVar> listaInst 
%type <nomeVar> instrucao
%type <nomeVar> condicional
%type <nomeVar>	afirmacao
%type <nomeVar> atribuicao
%type <nomeVar> ciclo
%type <nomeVar> condicao
%type <nomeVar> expressao
%token <numInt> INTEIRO
%token <numDou> REAL
%token <nomeVar> VARIAVEL
%right ATRIB /* estabelece a prioridade nas regras */
%left SOMA SUB 
%left MULT DIV
%left IGUAL DIFERENTE MAIOR MENOR MAIORIGUAL MENORIGUAL
%token SE SENAO ENQUANTO PARA
%token SEN COS ARCSEN ARCCOS LOG INT
%token PONTOVIR ABREPAR FECHAPAR ABRECHA FECHACHA

%%

programa	:	listaInst	{}
			;

listaInst	:	listaInst instrucao		{strcpy($$,$1); strcat($$,$2);}
			|	instrucao				{strcpy($$,$1);}			
			;

instrucao	:	condicional 	{strcpy($$,$1); printf("Condicional:\t%s\n", $1);}
			|	afirmacao		{strcpy($$,$1); printf("Afirmação:\t%s\n", $1);}
			|	error PONTOVIR	{yyerrok; yyclearin;}
			|	error FECHACHA	{yyerrok; yyclearin;}	
			;

condicional	:	SE ABREPAR condicao FECHAPAR ABRECHA listaInst FECHACHA SENAO ABRECHA listaInst FECHACHA	{strcpy($$,"se("); strcat($$,$3); strcat($$,"){"); strcat($$,$6); strcat($$,"}senao{"); strcat($$,$10); strcat($$,"}");}
			;

afirmacao	:	atribuicao	{strcpy($$,$1);}
			|	ciclo		{strcpy($$,$1);}
			;

atribuicao	:	VARIAVEL ATRIB expressao PONTOVIR	{strcpy($$,$1); strcat($$,":="); strcat($$,$3); strcat($$,";");}
			;

ciclo		:	ENQUANTO ABREPAR condicao FECHAPAR ABRECHA listaInst FECHACHA {strcpy($$,"enquanto("); strcat($$,$3); strcat($$,"){"); strcat($$,$6); strcat($$,"}");}
			|	PARA ABREPAR VARIAVEL ATRIB expressao PONTOVIR condicao PONTOVIR VARIAVEL ATRIB expressao FECHAPAR ABRECHA listaInst FECHACHA		{strcpy($$,"para("); strcat($$,$3); strcat($$,":="); strcat($$,$5); strcat($$,";"); strcat($$,$7); strcat($$,";"); strcat($$,$9); strcat($$,":="); strcat($$,$11); strcat($$,"){"); strcat($$,$14); strcat($$,"}");}				
			;

condicao	:	expressao IGUAL expressao		{strcpy($$,$1); strcat($$,"="); strcat($$,$3);}
			|	expressao DIFERENTE expressao	{strcpy($$,$1); strcat($$,"<>"); strcat($$,$3);}
			|	expressao MAIOR expressao		{strcpy($$,$1); strcat($$,">"); strcat($$,$3);}
			|	expressao MENOR expressao		{strcpy($$,$1); strcat($$,"<"); strcat($$,$3);}
			|	expressao MAIORIGUAL expressao	{strcpy($$,$1); strcat($$,">="); strcat($$,$3);}
			|	expressao MENORIGUAL expressao	{strcpy($$,$1); strcat($$,"<="); strcat($$,$3);}
			;

expressao	:	expressao SOMA expressao				{strcpy($$,$1); strcat($$,"+"); strcat($$,$3);}
			|	expressao SUB expressao					{strcpy($$,$1); strcat($$,"-"); strcat($$,$3);}
			|	expressao MULT expressao				{strcpy($$,$1); strcat($$,"*"); strcat($$,$3);}
			|	expressao DIV expressao					{strcpy($$,$1); strcat($$,"/"); strcat($$,$3);}
			|	ABREPAR expressao FECHAPAR				{strcpy($$,"("); strcat($$,$2); strcat($$,")");}
			|	SEN ABREPAR expressao FECHAPAR			{strcpy($$,"seno("); strcat($$,$3); strcat($$,")");}	
			|	COS ABREPAR expressao FECHAPAR			{strcpy($$,"coseno("); strcat($$,$3); strcat($$,")");}			
			|	ARCSEN ABREPAR expressao FECHAPAR		{strcpy($$,"arcosseno("); strcat($$,$3); strcat($$,")");}	
			|	ARCCOS ABREPAR expressao FECHAPAR 		{strcpy($$,"arcocosseno("); strcat($$,$3); strcat($$,")");}	
			|	LOG ABREPAR expressao FECHAPAR			{strcpy($$,"log("); strcat($$,$3); strcat($$,")");}	
			|	INT ABREPAR expressao FECHAPAR			{strcpy($$,"int("); strcat($$,$3); strcat($$,")");}				
			|	INTEIRO									{sprintf($$,"%d",$1);}
			|	SUB INTEIRO 							{int n = -$2; sprintf($$,"%d",n);}
			|	REAL									{sprintf($$,"%g",$1);}
			|	SUB REAL 								{double n = -$2; sprintf($$,"%g",n);}	
			|	VARIAVEL								{strcpy($$,$1);}
			|	SUB VARIAVEL {strcpy($$,"-"); strcat($$,$2);}	
			;	
%%

int main(int argc, char** argv) {
	
	if (argc > 2) {
		fprintf(stderr,"Sintaxe: efA [nome_ficheiro]\n");
		return 1;
	}

	if (argc == 2) {
		yyin = fopen(argv[1],"r");
		if (!yyin) {
			fprintf(stderr,"Erro ao abrir o ficheiro \"%s\"\n", argv[1]);
			return 1;
		}
	}
	
	yyparse();
	
	printf("Análise completa.\n");
	if (numeroErros > 0)
		printf("%d erro(s) encontrados(s) no código!\n", numeroErros);
	else
		printf("Código sem erros.\n");
		

	return 0;
}

int yyerror(char* s) {
		fprintf(stderr,"Linha %d:\t%s\n", yylineno, s);
		numeroErros++;
		return 1;
}


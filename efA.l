%option noyywrap
%option yylineno

%{
	#include <stdlib.h>
	#include <string.h>
	#include "efABison.h"
%}

DIGITO		[0-9]
SINAL		[-+]
NINTEIRO	{DIGITO}+
NREAL		{DIGITO}+([.]{DIGITO}+)?([Ee]{SINAL}?{DIGITO}+)?
VAR     	[a-zA-Z][a-zA-Z0-9_]{0,31}

%%

{NINTEIRO}	{yylval.numInt = atoi(yytext); return INTEIRO;}
{NREAL}		{yylval.numDou = atof(yytext); return REAL;}
se			{return SE;}
senao		{return SENAO;}
enquanto	{return ENQUANTO;}
para		{return PARA;}
seno		{return SEN;}
coseno		{return COS;}
arcosseno	{return ARCSEN;}
arcocosseno	{return ARCCOS;}
log			{return LOG;}
int			{return INT;}
"="			{return IGUAL;}
"<>"		{return DIFERENTE;}
">"			{return MAIOR;}
"<"			{return MENOR;}
">="		{return MAIORIGUAL;}
"<="		{return MENORIGUAL;}
"+"			{return SOMA;}
"-"			{return SUB;}
"*"			{return MULT;}
"/"			{return DIV;}
":="		{return ATRIB;}
{VAR}		{strcpy(yylval.nomeVar,yytext); return VARIAVEL;}
";" 		{return PONTOVIR;}
"(" 		{return ABREPAR;}
")" 		{return FECHAPAR;}
"{" 		{return ABRECHA;}
"}" 		{return FECHACHA;}
[ \t\n]+	{}

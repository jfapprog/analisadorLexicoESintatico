/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_EFABISON_H_INCLUDED
# define YY_YY_EFABISON_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INTEIRO = 258,
    REAL = 259,
    VARIAVEL = 260,
    ATRIB = 261,
    SOMA = 262,
    SUB = 263,
    MULT = 264,
    DIV = 265,
    IGUAL = 266,
    DIFERENTE = 267,
    MAIOR = 268,
    MENOR = 269,
    MAIORIGUAL = 270,
    MENORIGUAL = 271,
    SE = 272,
    SENAO = 273,
    ENQUANTO = 274,
    PARA = 275,
    SEN = 276,
    COS = 277,
    ARCSEN = 278,
    ARCCOS = 279,
    LOG = 280,
    INT = 281,
    PONTOVIR = 282,
    ABREPAR = 283,
    FECHAPAR = 284,
    ABRECHA = 285,
    FECHACHA = 286
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 21 "efA.y" /* yacc.c:1909  */

	int numInt;
	double numDou;
	char nomeVar[128+1];

#line 92 "efABison.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_EFABISON_H_INCLUDED  */

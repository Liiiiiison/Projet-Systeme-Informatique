/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    tMAIN = 258,                   /* tMAIN  */
    tCONST = 259,                  /* tCONST  */
    tINT = 260,                    /* tINT  */
    tCOMA = 261,                   /* tCOMA  */
    tSEMICOLON = 262,              /* tSEMICOLON  */
    tAO = 263,                     /* tAO  */
    tAF = 264,                     /* tAF  */
    tPRINT = 265,                  /* tPRINT  */
    tDEC = 266,                    /* tDEC  */
    tEGAL = 267,                   /* tEGAL  */
    tPO = 268,                     /* tPO  */
    tPF = 269,                     /* tPF  */
    tSOU = 270,                    /* tSOU  */
    tADD = 271,                    /* tADD  */
    tDIV = 272,                    /* tDIV  */
    tMUL = 273,                    /* tMUL  */
    tERROR = 274,                  /* tERROR  */
    tNB = 275,                     /* tNB  */
    tID = 276                      /* tID  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define tMAIN 258
#define tCONST 259
#define tINT 260
#define tCOMA 261
#define tSEMICOLON 262
#define tAO 263
#define tAF 264
#define tPRINT 265
#define tDEC 266
#define tEGAL 267
#define tPO 268
#define tPF 269
#define tSOU 270
#define tADD 271
#define tDIV 272
#define tMUL 273
#define tERROR 274
#define tNB 275
#define tID 276

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 7 "compilateur.y"
 int nb; char var; 

#line 112 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

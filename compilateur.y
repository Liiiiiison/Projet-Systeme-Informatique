%{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}
%union { int nb; char var; }
%token tMAIN tCONST tINT tCOMA tSEMICOLON tAO tAF tPRINT tDEC tFL tEGAL tPO tPF tSOU tADD tDIV tMUL tERROR
%token <nb> tNB
%token <var> tID
%type <nb> Expr DivMul Terme
%start Compiler
%%
Compiler :	  Compiler | Start ;
Start :		tMAIN tAO Code ;

Declaration : tCONST tID tSEMICOLON { } //int a; allouer de la mémoire (vérifier si y en a plusieurs)
		| tINT tID tEGAL tNB tSEMICOLON {} //int a=1; ""
		| Declaration {}

Code :		Declaration {}
		| Expr tSEMICOLON{} //a=b+c; b+c est une expression
		| tID tEGAL Expr tSEMICOLON {}
		| Code Code {}
		| Affichage {};

//code de la calculatrice (à refaire avec les bonnes priorités de calcul %left)
Expr :		  Expr tADD DivMul { $$ = $1 + $3; }
		| Expr tSOU DivMul { $$ = $1 - $3; }
		| DivMul { $$ = $1; } ;
DivMul :	  DivMul tMUL Terme { $$ = $1 * $3; }
		| DivMul tDIV Terme { $$ = $1 / $3; }
		| Terme { $$ = $1; } ;
Terme :		  tPO Expr tPF { $$ = $2; }
		| tID { $$ = var[$1]; }
		| tNB { $$ = $1; }


Affichage : tPRINT tPO tDEC tCOMA tNB tPF tSEMICOLON {}

/*Calculatrice : Calcul Calculatrice | Calcul ;		
Calcul :	  Expr tFL { printf("> %d\n", $1); }
		| tID tEGAL Expr tFL { var[(int)$1] = $3; } ;
Expr :		  Expr tADD DivMul { $$ = $1 + $3; }
		| Expr tSOU DivMul { $$ = $1 - $3; }
		| DivMul { $$ = $1; } ;
DivMul :	  DivMul tMUL Terme { $$ = $1 * $3; }
		| DivMul tDIV Terme { $$ = $1 / $3; }
		| Terme { $$ = $1; } ;
Terme :		  tPO Expr tPF { $$ = $2; }
		| tID { $$ = var[$1]; }
		| tNB { $$ = $1; } ;*/
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Calculatrice\n"); // yydebug=1;
  yyparse();
  return 0;
}

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
%type <nb> Expr DivMul Terme Code Declaration
%start Compiler
%%
Compiler :	  Compiler | Start ;
Start :		tMAIN tAO Code ; // tMAIN tAO Code tAF ?

Code :		Declaration {}
		| Expr tSEMICOLON {$$ = $1 ;} //a=b+c; b+c est une expression
		| tID tEGAL Expr tSEMICOLON {var[int($1)]=$3 ;} // pas sûr de celui la
		| Code Code {}
		| Affichage {$$ = $1};

Declaration : tCONST tID tSEMICOLON {} //int a; allouer de la mémoire (vérifier si y en a plusieurs)
		| tINT tID tEGAL tNB tSEMICOLON {var[int($2)]=$4 ; } //int a=1; ""
		| Declaration {}

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


Affichage : tPRINT tPO tDEC tCOMA tID tPF tSEMICOLON {printf("%d",$5) ;} // à compléter pour plus tard avec les autres possibilités

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

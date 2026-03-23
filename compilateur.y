%{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}
%union { int nb; char var; }
%token tMAIN tCONST tINT tCOMA tSEMICOLON tAO tAF tPRINT tDEC tEGAL tPO tPF tSOU tADD tDIV tMUL tERROR
%token <nb> tNB
%token <var> tID
%type <nb> Expr DivMul Terme Code Declaration
%type <var> Affichage
%start Compiler
%%
Compiler :		tINT tMAIN tPO tPF tAO Codes tAF // tMAIN tAO Code tAF ?

Codes :  Code Codes {printf("CODES - Code Codes\n");}
		| Code {printf("CODES - Code tout seul\n");}

Code :		Declaration {printf("CODE - Déclaration\n"); $$ = $1;}
		| Expr tSEMICOLON {printf("CODE - Expr\n"); $$ = $1;} //a=b+c; b+c est une expression
		| tID tEGAL Expr tSEMICOLON {printf("CODE - a=1; \n");$$=$3;}
		| Affichage {printf("CODE - Affichage\n");$$ = $1;}

Declaration : tCONST tID tSEMICOLON {$$=1; printf("DECLARATION - const\n"); } //int a; allouer de la mémoire (vérifier si y en a plusieurs)
		| tINT tID tEGAL tNB tSEMICOLON {$$=1; printf("DECLARATION - int = \n"); } 
		| tINT tID tSEMICOLON{printf("DECLARATION - int\n");};

//code de la calculatrice (à refaire avec les bonnes priorités de calcul %left)
Expr :		  Expr tADD DivMul { $$ = $1 + $3; }
		| Expr tSOU DivMul { $$ = $1 - $3; }
		| DivMul { $$ = $1; printf("EXPR - Divmul\n");};
DivMul :	  DivMul tMUL Terme { $$ = $1 * $3; }
		| DivMul tDIV Terme { $$ = $1 / $3; }
		| Terme { $$ = $1; } ;
Terme :		  tPO Expr tPF { $$ = $2; }
		| tID { $$ = var[$1]; }
		| tNB { $$ = $1; }


Affichage : tPRINT tPO tDEC tCOMA tID tPF tSEMICOLON {$$ = $5 ; printf("%d\n",$5) ;} // à compléter pour plus tard avec les autres possibilités

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

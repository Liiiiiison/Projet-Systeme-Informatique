%{
#include <stdlib.h>
#include <stdio.h>
#include "mem.h" 
void yyerror(char *s);
%}
%union { int nb; char * var; }
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

Code :		Declaration {printf("CODE - Déclaration\n"); }
		| tID tEGAL Expr tSEMICOLON {
			printf("CODE - a=1; \n");
			int var = is_var($1);
			if (var==-1) { //index introuvable
				perror("Erreur : %d non déclarée", $1);
			} elsif(var==0 && is_init($1) )  {
				perror("Erreur : %d est une constante déjà initialisée", $1);
			} else {
				int index = get_index($1);
				if (var == 0) {
					init_const($1);
				} else {
					init_int($1);
				}
				printf("AFC %d $3", index);
			}
			free($1); //TODO pour chaque tID
		} //a=b+c; b+c est une expression
		| Affichage {printf("CODE - Affichage\n")}
		//| Expr tSEMICOLON {printf("CODE - Expr\n"); } si jamais on doit compiler a++/a-- ce serait à changer 

Declaration : tCONST tINT tID tSEMICOLON { 
					printf("DECLARATION - const\n");
					int adresse = add_const($3) ; 
				} 
		| tCONST tINT tID tEGAL tNB tSEMICOLON { 
			printf("DECLARATION - const = \n", );
			if ((int adresse = add_const($3))!=-1){
				if (init_const(adresse)!=-1) {
					printf("AFC %d $5", adresse);
				} else {
					perror("Erreur : constante déjà initalisée");
				}
			} else {
				perror("Erreur de compilation : constante déjà déclarée")
			}
		} 
		| tINT tID tSEMICOLON{
			printf("DECLARATION - int = \n", );
			if ((int adresse = add_int($2))==-1){
				perror("Erreur de compilation : constante déjà déclarée")
			}
		}  //int a; allouer de la mémoire (vérifier si y en a plusieurs)
		| tINT tID tEGAL tNB tSEMICOLON { 
			printf("DECLARATION - int = \n", );
			if ((int adresse = add_int($2))!=-1){
				if (init_int(adresse)!=-1) {
					printf("AFC %d $4", adresse);
				} else {
					perror("Erreur : entier déjà initalisé");
				}
			} else {
				perror("Erreur de compilation : entier déjà déclaré")
			}	
		} 

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
DivMul :	  DivMul tMUL Terme { $
$ = $1 * $3; }
		| DivMul tDIV Terme { $$ = $1 / $3; }
		| Terme { $$ = $1; } ;
Terme :		  tPO Expr tPF { $$ = $2; }
		| tID { $$ = var[$1]; }
		| tNB { $$ = $1; } ;*/
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Calculatrice\n"); // yydebug=1;
  init_table();
  yyparse();
  return 0;
}

//TODO : - if
// - while
// - appels de fonctions 
// a = b
// fonctions de mem avec le char *  : ne pas comparer les adresse + vérifier les tailels  

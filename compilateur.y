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
%type <nb> Expr Code Declaration Terme
%type <var>  Affichage
%right tEGAL
%left tADD tSOU
%left tMUL tDIV
%start Compiler
%%
Compiler :		tINT tMAIN tPO tPF tAO Codes tAF // tMAIN tAO Code tAF ?

Codes :  Code Codes {printf("CODES - Code Codes\n");}
		| Code {printf("CODES - Code tout seul\n");}

Code :		Declaration {printf("CODE - Déclaration\n"); }
		| tID tEGAL Expr tSEMICOLON {
			printf("CODE - a=1; \n");
			int variable = is_var($1);
			if (variable==-1) { //index introuvable
				perror("\tErreur : %d non déclarée\n");
			} else if(variable==0 && is_init($1) )  {
				perror("\tErreur : %d est une constante déjà initialisée\n");
			} else {
				int index = get_index($1);
				if (variable == 0) {
					int a = init_const(index); // pq int a ? c'est quoi a ? [Warning : unused variable a]
				} else {
					int a = init_int(index);
				}
				printf("\tAFC %d $3\n", index);
			}
			reinit_temp() ; // réinitialise l'index des variables temporaires 
			free($1); //on free après le strdup du compilateur.l -> TODO pour chaque tID
		} //a=b+c; b+c est une expression
		| Affichage {printf("CODE - Affichage\n");}
		//| Expr tSEMICOLON {printf("CODE - Expr\n"); } si jamais on doit compiler a++/a-- ce serait à changer 

Declaration : tCONST tINT tID tSEMICOLON { 
					printf("DECLARATION - const\n");
					int adresse = add_const($3) ; 
				} 
		| tCONST tINT tID tEGAL tNB tSEMICOLON { 
			printf("DECLARATION - const = \n");
			int adresse=add_const($3);
			if (adresse!=-1){
				if (init_const(adresse)!=-1) {
					printf("\tAFC %d $5\n", adresse);
				} else {
					perror("Erreur : constante déjà initalisée\n");
				}
			} else {
				perror("Erreur de compilation : constante déjà déclarée\n");
			}
		} 
		| tINT tID tSEMICOLON{

			printf("DECLARATION - int \n");

			int adresse = add_int($2);

			if (adresse==-1){
				perror("\tErreur de compilation : entier déjà déclarée\n");
			}
		}  //int a; allouer de la mémoire (vérifier si y en a plusieurs)
		| tINT tID tEGAL tNB tSEMICOLON { 
			
			printf("DECLARATION - int = \n");

			int adresse = add_int($2);
			free($2);
			if (adresse!=-1){
				if (init_int(adresse)!=-1) {
					printf("\tAFC %d $4\n", adresse);
				} else {
					perror("\tErreur : entier déjà initalisé\n");
				}
			} else {
				perror("\tErreur de compilation : entier déjà déclaré\n");
			}	
		} 

//code de la calculatrice (à refaire avec les bonnes priorités de calcul %left)
Expr : Expr tADD Expr {
			printf("EXPR - ADD\n");
			printf("\tADD $$ $1 $3\n"); }
		| Expr tSOU Expr {
			printf("EXPR - SOU\n");
			printf("\tSOU $$ $1 $3\n"); }
		| Expr tMUL Expr {
			printf("EXPR - MUL\n");
			printf("\tMUL $$ $1 $3\n"); }
		| Expr tDIV Expr {
			printf("EXPR - DIV\n");
			printf("\tDIV $$ $1 $3\n"); }
		| Terme { $$ = $1; } ;
Terme :		  tPO Expr tPF { $$ = $2; }
		| tID { $$ = get_index($1); }
		| tNB { $$ = add_temp(); }

Affichage : tPRINT tPO tDEC tCOMA tID tPF tSEMICOLON {$$ = $5 ; printf("%d\n",$5) ;} 
// à compléter pour plus tard avec les autres possibilités

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
  printf("test du compilateur\n"); // yydebug=1;
  init_mem();
  yyparse();
  return 0;
}

//TODO : - if
// - while
// - appels de fonctions 
// a = b
// fonctions de mem avec le char *  : ne pas comparer les adresse + vérifier les tailels  

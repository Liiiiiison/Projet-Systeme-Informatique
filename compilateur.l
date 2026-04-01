%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap

%%

"main" { return tMAIN; }
"const" { return tCONST;}
"int" { return tINT;}
[ \t]+ ;
"," { return tCOMA; }
";" { return tSEMICOLON; }
"{"	{ return tAO; }
"}"	{ return tAF; }
"="	{ return tEGAL; }
"-"	{ return tSOU; }
"+"	{ return tADD; }
"*"	{ return tMUL; }
"/"	{ return tDIV; }
"("	{ return tPO; }
")"	{ return tPF; }
"printf" { return tPRINT; } //à voir avec le guillemet
"%d" {return tDEC; }

[A-Za-z][A-Za-z0-9_]* {
	  yylval.var = strdup(yytext); // strdup -> malloc + strcpy => faire un free après
	  return tID;
	}
[0-9]+	{
	  yylval.nb = atoi(yytext);
	  return tNB;
	}
[0-9]+e?-[0-9]+|[0-9]+ { // [0-9]+e(-[0-9]+|[0-9]+)
	  yylval.nb = atof(yytext);
	  return tNB;
	}
[\n]+ ;	
.	{ return tERROR; }

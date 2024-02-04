%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h" // Inclua o header gerado pelo Bison
#include "quadrupla.h"
 
extern FILE *yyin;
extern quadrupla *quad;
extern int quad_count;
extern char* temp();
%}

%%

[ \t\n]              ; // Ignorar espaços em branco e quebras de linha
"int"                { return INT; }
"if"                 { return IF; }
"else"               { return ELSE; }
"while"              { return WHILE; }
"do"                 { return DO; }
"for"                { return FOR; }
"("                  { return '('; }
")"                  { return ')'; }
"{"                  { return '{'; }
"}"                  { return '}'; }
";"                  { return ';'; }
">"					 { return '>'; }
"<"                  { return '<'; }
[0-9]+               { yylval = atoi(yytext); return NUM; } 
[a-zA-Z][a-zA-Z0-9]* { yylval = strdup(yytext); return ID; }
"+"                { return '+'; } // Escape o operador '+'
"-"                { return '-'; } // Escape o operador '-'
"*"                { return '*'; } // Escape o operador '*'
"/"                  { return '/'; }
"="                  { return '='; }

.                    { printf("Caractere inesperado: %s\n", yytext); }
%%

int yywrap(){
	return 1;
}
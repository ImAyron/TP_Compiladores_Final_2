%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "muxtela.tab.h" // Inclua o header gerado pelo Bison
#include "quadrupleStruct.h"
 
extern FILE *yyin;
extern quadrupleStruct *quad;
extern int quad_count;
extern char* temp();
%}

%%

[ \t\n]              ; // Ignorar espaços em branco e quebras de linha
"int"       		 { printf("Palavra chave 'int'\n"); return INT; }
"if"        		 { printf("Palavra chave 'if'\n"); return IF; }
"else"      		 { printf("Palavra chave 'else'\n"); return ELSE; }
"while"     		 { printf("Palavra chave 'while'\n"); return WHILE; }
"do"        		 { printf("Palavra chave 'do'\n"); return DO; }
"for"       		 { printf("Palavra chave 'for'\n"); return FOR; }
"("                  { printf("Parentese de abertura\n"); return '('; }
")"                  { printf("Parentese de fechamento\n"); return ')'; }
"{"                  { printf("Chave de abertura\n"); return '{'; }
"}"                  { printf("Chave de abertura\n"); return '}'; }
";"                  { printf("Ponto e virgula\n"); return ';'; }
">"					 { printf("Sinal de maior\n"); return '>'; }
"<"                  { printf("Sinal de menor\n"); return '<'; }
[0-9]+               { printf("Valor numerico: %s\n", yytext); yylval = atoi(yytext); return NUM; } 
[a-zA-Z][a-zA-Z0-9]* { printf("Texto: %s\n", yytext); yylval = strdup(yytext); return ID; }
"+"                	 { printf("Operador de adicao\n"); return '+'; } // Escape o operador '+'
"-"                	 { printf("Operador de subtracao\n"); return '-'; } // Escape o operador '-'
"*"                	 { printf("Operador de multiplicacao\n"); return '*'; } // Escape o operador '*'
"/"                  { printf("Operador de divisao\n"); return '/'; }
"="                  { printf("Operador de igualdade\n"); return '='; }

.                    { printf("Caractere inesperado: %s\n", yytext); }
%%

int yywrap(){
	return 1;
}
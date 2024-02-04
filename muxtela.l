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

[ \t ]              ; // Ignorar espaços em branco e quebras de linha
"int"       		 { printf("Palavra chave 'int '"); return INT; }
"if"        		 { printf("Palavra chave 'if' "); return IF; }
"else"      		 { printf("Palavra chave 'else' "); return ELSE; }
"while"     		 { printf("Palavra chave 'while' "); return WHILE; }
"do"        		 { printf("Palavra chave 'do' "); return DO; }
"for"       		 { printf("Palavra chave 'for' "); return FOR; }
"("                  { printf("Parentese de abertura "); return '('; }
")"                  { printf("Parentese de fechamento "); return ')'; }
"{"                  { printf("Chave de abertura "); return '{'; }
"}"                  { printf("Chave de abertura "); return '}'; }
";"                  { printf("Ponto e virgula "); return ';'; }
">"					 { printf("Sinal de maior "); return '>'; }
"<"                  { printf("Sinal de menor "); return '<'; }
"<="				 { printf("Sinal de menor igual "); return MENORIGUAL; }
">="                 { printf("Sinal de maior igual "); return MAIORIGUAL; }
"=="       			 { printf("Sinal de igual\n"); return IGUAL; }
"!="                 { printf("Sinal de diferenca\n"); return DIFERENTE; }
"!"                  { printf("Sinal de negacao\n"); return NEGACAO  ; }
"&&"        		 { printf("Sinal E Logico\n"); return E; }
"||"        		 { printf("Sinal OU logico\n"); return OU; }
[0-9]+               { printf("Valor numerico: %s ", yytext); yylval = atoi(yytext); return NUM; } 
[a-zA-Z][a-zA-Z0-9]* { printf("Texto: %s ", yytext); yylval = strdup(yytext); return ID; }
"+"                	 { printf("Operador de adicao "); return '+'; } // Escape o operador '+'
"-"                	 { printf("Operador de subtracao "); return '-'; } // Escape o operador '-'
"*"                	 { printf("Operador de multiplicacao "); return '*'; } // Escape o operador '*'
"/"                  { printf("Operador de divisao "); return '/'; }
"="                  { printf("Operador de igualdade "); return '='; }

.                    { printf("Caractere inesperado: %s ", yytext); }
%%

int yywrap(){
	return 1;
}
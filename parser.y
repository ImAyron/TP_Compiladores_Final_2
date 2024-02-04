%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "quadrupla.h"

extern FILE *yyin;
extern int yylex();
void yyerror(const char *s);
char*temp(){
    static int temp_count=0;
    char*temp_name=(char*)malloc(8);
    snprintf(temp_name,8,"_temp %d",temp_count);
    temp_count++;
    return temp_name;
}
%}

%token INT IF ELSE WHILE DO FOR NUM ID
%left '+' '-'
%left '*' '/'
%right '='

%%

program:
    statements
    ;

statements:
    statements statement
    |
    statement
    ;

statement:
    INT ID ';'
    {
        $$ = $1;
        printf("(=, , ,%s)\n",$1);
    }
    |
    ID '=' exp ';'
    {
        $$ = $3; 
        printf("(=, , ,%s)\n", $3);
    }
    |
    IF '(' condition ')' '{' statement '}'
    |
    IF '(' condition ')' '{' statement '}' ELSE '{' statement '}'
    |
    WHILE '(' condition ')' '{' statement '}'
    |
    DO '{'statement '}' WHILE '(' condition ')' ';'
    |
    FOR '(' statement ';' condition ';' statement ')' '{' statement '}'
    ;

condition:
    exp
    |
    exp '>' exp
    {
        if ($1 != '_' && $3 != '_') {
            char *temp_name = temp();
            printf("(>,%s,%s,%s)\n", $1, $3, temp_name);
        } else {
            printf("(>,%s,%s,%s)\n", $1, $3, $$);
        }
    }
    |exp '<' exp
    {
        if ($1 != '_' && $3 != '_') {
            char *temp_name = temp(); // Crie um nome temporário
            printf("(<,%s,%s,%s)\n", $1, $3, temp_name);
        } else {
            printf("(<,%s,%s,%s)\n", $1, $3, $$);
        }
    }
    ;

exp:
    exp '+' exp
    {
        char *temp_name = temp(); // Crie um nome temporário
        $$ = temp_name; // Atribua o ponteiro para a variável temporária
        printf("(+,%s,%s,%s)\n", $1, $3, $$); // Gere a quadrupla
    }
    |
    exp '-' exp
    {
        char *temp_name = temp(); // Crie um nome temporário
        $$ = temp_name; // Atribua o ponteiro para a variável temporária
        printf("(-,%s,%s,%s)\n", $1, $3, $$);
    }
    |
    exp '*' exp
    {
        char *temp_name = temp(); // Crie um nome temporário
        $$ = temp_name; // Atribua o ponteiro para a variável temporária
        printf("(*,%s,%s,%s)\n", $1, $3, $$);
    }
    |
    exp '/' exp
    {
       char *temp_name = temp(); // Crie um nome temporário
        $$ = temp_name; // Atribua o ponteiro para a variável temporária
        printf("(/,%s,%s,%s)\n", $1, $3, $$);
    }
    |
    ID
    {
        $$ = $1;
        printf("(=,%s,%s,%s)\n", $1, "", $$);
    }
    |
    NUM
    {
        char *temp_name = temp(); // Crie um nome temporário
        $$ = temp_name; // Atribua o ponteiro para a variável temporária
        printf("(=,%d,%s,%s)\n", $1, "", $$);
    }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s", s);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <arquivo de entrada>\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Erro ao abrir o arquivo");
        return 1;
    }

    yyin = input_file;

    yyparse();

    fclose(input_file);

    return 0;
}

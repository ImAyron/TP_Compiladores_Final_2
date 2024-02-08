%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "quadrupleStruct.h"

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

%token INT IF ELSE WHILE DO FOR NUM ID MENORIGUAL MAIORIGUAL DIFERENTE NEGACAO IGUAL E OU
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
    {
       
        char *label1 = temp();
        char *label2 = temp();
        printf("(IF, %s, %s, )\n", $3, label1);
        printf("(+, %s, %s, %s)\n", $3, label1, $$);
        printf("(=, %s, , %s)\n", $$, $3);
        printf("(goto, , , %s)\n", label2);
        printf("(%s, , , )\n", label1);
    }
    |
    IF '(' condition ')' '{' statement '}' ELSE '{' statement '}'
    {
        printf("IAM HERE if\n");
        char *label1 = temp();
        char *label2 = temp();
        printf("(IF, %s, %s, %s)\n", $3, $6, label1);
        printf("(goto, , , %s)\n", label2);
        printf("(%s, , , )\n", label1);
    }
    |
    WHILE '(' condition ')' '{'
    {
        char *label1 = temp();
        char *label2 = temp();
        char *temp0 = temp();
        printf("(%s, , , )\n", label1);
        printf("(IF, %s, , %s)\n", $3, label2);
        printf("(%s, , , )\n", label2);
        printf("(goto, , , %s)\n", label1);
        printf("(%s, , , )\n", label2);
    }
    statement
    {
        printf("if (!%s) goto %s;\n", $3, $1); // Condição de saída do loop
        printf("goto %s;\n", $1); // Salto de volta para o início do loop
        printf("%s:\n", $2); // Imprime o rótulo de fim
    }
    '}'
    ;

    |
    DO '{' statement '}' WHILE '(' condition ')' ';'
    {
        char *label1 = temp();
        char *label2 = temp();
        char *temp0 = temp();
        printf("(%s, , , )\n", label1);
        printf("(%s, , , )\n", label2);
        printf("(IF, %s, , %s)\n", $5, label1);
        printf("(goto, , , %s)\n", label2);
        printf("(%s, , , )\n", label1);
    }
    |
    FOR '(' statement ';' condition ';' statement ')' '{' statement '}'
    {
        char *label1 = temp();
        char *label2 = temp();
        char *temp0 = temp();
        printf("(%s, , , )\n", label1);
        printf("(%s, , , )\n", label2);
        printf("(IF, %s, , %s)\n", $5, label2);
        printf("(goto, , , %s)\n", label1);
        printf("(%s, , , )\n", label2);
    }

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
    |
    exp '<' exp
    {
        if ($1 != '_' && $3 != '_') {
            char *temp_name = temp(); // Crie um nome temporário
            printf("(<,%s,%s,%s)\n", $1, $3, temp_name);
        } else {
            printf("(<,%s,%s,%s)\n", $1, $3, $$);
        }
    }
    |
    exp MENORIGUAL exp
    {
        if ($1 != '_' && $3 != '_') {
            char *temp_name = temp(); // Crie um nome temporário
            printf("(<=,%s,%s,%s)\n", $1, $3, temp_name);
        } else {
            printf("(<=,%s,%s,%s)\n", $1, $3, $$);
        }
    }
    |
    exp MAIORIGUAL exp
    {
        if ($1 != '_' && $3 != '_') {
            char *temp_name = temp(); // Crie um nome temporário
            printf("(>=,%s,%s,%s)\n", $1, $3, temp_name);
        } else {
            printf("(>=,%s,%s,%s)\n", $1, $3, $$);
        }
    }
    |
    exp NEGACAO exp
    {
        if ($1 != '_' && $3 != '_') {
            char *temp_name = temp(); // Crie um nome temporário
            printf("(!,%s,%s,%s)\n", $1, $3, temp_name);
        } else {
            printf("(!,%s,%s,%s)\n", $1, $3, $$);
        }
    }
    |
    exp DIFERENTE exp
    {
        if ($1 != '_' && $3 != '_') {
            char *temp_name = temp(); // Crie um nome temporário
            printf("(!=,%s,%s,%s)\n", $1, $3, temp_name);
        } else {
            printf("(!=,%s,%s,%s)\n", $1, $3, $$);
        }
    }
    |
    exp IGUAL exp
    {
        if ($1 != '_' && $3 != '_') {
            char *temp_name = temp(); // Crie um nome temporário
            printf("(==,%s,%s,%s)\n", $1, $3, temp_name);
        } else {
            printf("(==,%s,%s,%s)\n", $1, $3, $$);
        }
    }
     |
    exp E exp
    {
        if ($1 != '_' && $3 != '_') {
            char *temp_name = temp(); // Crie um nome temporário
            printf("(&&,%s,%s,%s)\n", $1, $3, temp_name);
        } else {
            printf("(&&,%s,%s,%s)\n", $1, $3, $$);
        }
    }
     |
    exp OU exp
    {
        if ($1 != '_' && $3 != '_') {
            char *temp_name = temp(); // Crie um nome temporário
            printf("(||,%s,%s,%s)\n", $1, $3, temp_name);
        } else {
            printf("(||,%s,%s,%s)\n", $1, $3, $$);
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

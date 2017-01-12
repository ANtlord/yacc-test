%{
int yylex();
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
%}

%union {int num; char sym; char* identifier; char paren}         /* Yacc definitions */
%start line
%token exit_command
%token print_command
%token <num> number
%type <num> line term expr
%token <sym> symbol
%type <sym> qwe
/*%token month*/

%%

/* descriptions of expected inputs     corresponding actions (in C) */
line    : exit_command          {exit(EXIT_SUCCESS);}
        | print_command expr    { printf("printing %d\n", $2); }
        | expr                  {$$ = $1;}
        | qwe                   {$$ = $1;}
        ;

expr    : '('expr')'            { $$ = $2; }
        | term                  { $$ = $1; }
        ;

qwe     : symbol                { $$ = $1; }
        | symbol qwe            { $$ = $1; }
        ;

term    : number                { $$ = $1; }
        ;

%%
#include "main.c"

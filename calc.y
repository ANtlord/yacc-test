%{
int yylex();
void yyerror (char *s);
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
%}

%union {
    int num;
    char* identifier;
}         /* Yacc definitions */
/*%union {int num; char sym; char* identifier; char paren}         [> Yacc definitions <]*/
%start line
%token exit_command
%token print_command
%token <space> space_
%token <num> number
%token <identifier> identifier_
%token l_parenthes
%token r_parenthes

%token keyword_class
%token keyword_struct
%token keyword_typedef
%token keyword_alias
%token keyword_template

%token sym_dot_comma
%token sym_comma
%token keyword_this
%token spec_auto

%token spec_final
%token spec_in
%token spec_lazy
%token spec_out
%token spec_ref
%token spec_scope

%token spec_const
%token spec_immutable
%token spec_inout
%token spec_shared

%token btype_bool
%token btype_byte
%token btype_ubyte
%token btype_short
%token btype_ushort
%token btype_int
%token btype_uint
%token btype_long
%token btype_ulong
%token btype_char
%token btype_wchar
%token btype_dchar
%token btype_float
%token btype_double
%token btype_real
%token btype_ifloat
%token btype_idouble
%token btype_ireal
%token btype_cfloat
%token btype_cdouble
%token btype_creal
%token btype_void

%type <num> line term expr
%type <identifier> classDeclaration
/*%token month*/

%%

/* descriptions of expected inputs     corresponding actions (in C) */
line    : exit_command          {exit(EXIT_SUCCESS);}
        | print_command expr    { printf("printing %d\n", $2); }
        | expr                  {$$ = $1;}
        ;

expr    : l_parenthes expr r_parenthes            { $$ = $2; }
        | term                  { $$ = $1; }
        | classDeclaration      { print("found declaration %s", $1); }
        ;

/*qwe     : identifier_                { $$ = $1; }*/
        /*| identifier_ qwe            { $$ = $1; }*/
        /*;*/
classDeclaration : keyword_class identifier_ sym_dot_comma  { $$ = $2; }
                 | keyword_class identifier_ aggregateBody  { $$ = $2; }
                 ;

aggregateBody : '{''}'
              | '{' declDefs '}'
              ;

declDefs : declDef
         | declDef declDefs
         ;

declDef : constructor
        ;

constructor : keyword_this parameters
            | keyword_this parameters memberFunctionAttributes
            ;

parameters : l_parenthes r_parenthes
           | l_parenthes parametersList r_parenthes
           ;

parametersList : parameter
               | parameter sym_comma parametersList
               ;

/* TODO: implement remaining rules. See: http://dlang.org/spec/function.html#Parameters */
parameter : inOutopt basicType Declarator
          ;

inOutopt : spec_auto
         | spec_final
         | spec_in
         | spec_lazy
         | spec_out
         | spec_ref
         | spec_scope
         | typeCtor
         ;

typeCtor : spec_const
         | spec_immutable
         | spec_inout
         | spec_shared
         ;

/* TODO: implement remaining rules. See: http://dlang.org/spec/declaration.html#BasicType */
basicType : basicTypeX
          ;

basicTypeX : btype_bool
           | btype_byte
           | btype_ubyte
           | btype_short
           | btype_ushort
           | btype_int
           | btype_uint
           | btype_long
           | btype_ulong
           | btype_char
           | btype_wchar
           | btype_dchar
           | btype_float
           | btype_double
           | btype_real
           | btype_ifloat
           | btype_idouble
           | btype_ireal
           | btype_cfloat
           | btype_cdouble
           | btype_creal
           | btype_void
           ;

declarator : varDeclarator
           | altDeclarator
           ;

varDeclarator: identifier_
             | basicType2 identifier_
             ;

basicType2 : basicType2X
           | basicType2X basicType2
           ;

basicType2X: '*'
           ;

altDeclarator:
             ;

term    : number                { $$ = $1; }
        | identifier_           { $$ = $1; }
        ;

%%
#include "main.c"

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
%token <num> number
%token <identifier> identifier_
%token l_parenthes
%token r_parenthes
%token l_brace
%token r_brace

%token keyword_class
%token keyword_struct
%token keyword_typedef
%token keyword_alias
%token keyword_template
%token keyword_nothrow
%token keyword_pure

/*%token sym_dot_comma*/
%token sym_comma
%token keyword_this
%token keyword_return
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

%type <identifier> line term expr
%type <identifier> classDeclaration

%%

/* descriptions of expected inputs     corresponding actions (in C) */
line    : exit_command                  {exit(EXIT_SUCCESS);}
        | print_command expr ';'           { printf("printing %s\n", $2); }
        | line print_command expr ';'           { printf("printing %s\n", $3); }
        | expr                          {$$ = $1;}
        | line expr                          {$$ = $1;}
        ;

expr    : l_parenthes expr r_parenthes            { $$ = $2; }
        | term                  { $$ = $1; }
        | classDeclaration      { printf("found declaration %s\n", $1);}
        ;

classDeclaration : keyword_class identifier_ ';'  { $$ = $2; }
                 | keyword_class identifier_ aggregateBody { $$ = $2; }
                 ;

aggregateBody : l_brace r_brace
              /*| l_brace declDefs r_brace*/
              ;

/*declDefs : declDef*/
         /*| declDef declDefs*/
         /*;*/

/*declDef : constructor*/
        /*;*/

/*constructor : keyword_this parameters*/
            /*| keyword_this parameters memberFunctionAttributes*/
            /*;*/

/*parameters : l_parenthes r_parenthes*/
           /*| l_parenthes parametersList r_parenthes*/
           /*;*/

/*parametersList : parameter*/
               /*| parameter sym_comma parametersList*/
               /*;*/

/*[> TODO: implement remaining rules. See: http://dlang.org/spec/function.html#Parameters <]*/
/*parameter : inOut basicType declarator*/
          /*| basicType declarator*/
          /*;*/

/*inOut : inOutX*/
      /*| inOut inOutX*/
      /*;*/

/*inOutX : spec_auto*/
      /*| spec_final*/
      /*| spec_in*/
      /*| spec_lazy*/
      /*| spec_out*/
      /*| spec_ref*/
      /*| spec_scope*/
      /*| typeCtor*/
      /*;*/

/*typeCtor : spec_const*/
         /*| spec_immutable*/
         /*| spec_inout*/
         /*| spec_shared*/
         /*;*/

/*[> TODO: implement remaining rules. See: http://dlang.org/spec/declaration.html#BasicType <]*/
/*basicType : basicTypeX*/
          /*;*/

/*basicTypeX : btype_bool*/
           /*| btype_byte*/
           /*| btype_ubyte*/
           /*| btype_short*/
           /*| btype_ushort*/
           /*| btype_int*/
           /*| btype_uint*/
           /*| btype_long*/
           /*| btype_ulong*/
           /*| btype_char*/
           /*| btype_wchar*/
           /*| btype_dchar*/
           /*| btype_float*/
           /*| btype_double*/
           /*| btype_real*/
           /*| btype_ifloat*/
           /*| btype_idouble*/
           /*| btype_ireal*/
           /*| btype_cfloat*/
           /*| btype_cdouble*/
           /*| btype_creal*/
           /*| btype_void*/
           /*;*/

/*declarator : varDeclarator*/
           /*| altDeclarator*/
           /*;*/

/*varDeclarator: identifier_*/
             /*| basicType2 identifier_*/
             /*;*/

/*basicType2 : basicType2X*/
           /*| basicType2X basicType2*/
           /*;*/

/*[> TODO: implement remaining rules. See: https://dlang.org/spec/grammar.html#BasicType2X <]*/
/*basicType2X: '*'*/
           /*| '['']'*/
           /*;*/

/*altDeclarator : basicType2 identifier_ altDeclaratorSuffixes*/
              /*| identifier_ altDeclaratorSuffixes*/
              /*| basicType2 l_parenthes altDeclaratorX r_parenthes*/
              /*| l_parenthes altDeclaratorX r_parenthes*/
              /*| basicType2 l_parenthes altDeclaratorX r_parenthes altFuncDeclaratorSuffix*/
              /*| l_parenthes altDeclaratorX r_parenthes altFuncDeclaratorSuffix*/
              /*| basicType2 l_parenthes altDeclaratorX r_parenthes altDeclaratorSuffixes*/
              /*| l_parenthes altDeclaratorX r_parenthes altDeclaratorSuffixes*/
              /*;*/

/*altDeclaratorX : basicType2 identifier_*/
               /*| identifier_*/
               /*| basicType2 identifier_ altFuncDeclaratorSuffix*/
               /*| identifier_ altFuncDeclaratorSuffix*/
               /*| altDeclarator*/
               /*;*/

/*altFuncDeclaratorSuffix: parameters memberFunctionAttributes*/
                       /*| parameters*/
                       /*;*/

/*altDeclaratorSuffixes : altDeclaratorSuffix*/
                      /*| altDeclaratorSuffix altDeclaratorSuffixes*/
                      /*;*/

/*[> TODO: implement remaining rules. See: https://dlang.org/spec/grammar.html#AltFuncDeclaratorSuffix <]*/
/*altDeclaratorSuffix : '['']'*/
                    /*;*/

/*memberFunctionAttributes : memberFunctionAttribute*/
                         /*| memberFunctionAttribute memberFunctionAttributes*/
                         /*;*/

/*memberFunctionAttribute*/
    /*: spec_const*/
    /*| spec_immutable*/
    /*| spec_inout*/
    /*| keyword_return*/
    /*| spec_shared*/
    /*| functionAttribute*/
    /*;*/

/*functionAttribute: keyword_nothrow*/
                 /*| keyword_pure*/
                 /*| property*/
                 /*;*/
/*property : '@' propertyIdentifier*/
         /*| userDefinedAttribute*/
         /*;*/

/*propertyIdentifier: "property"*/
                  /*| "safe"*/
                  /*| "trusted"*/
                  /*| "system"*/
                  /*| "disable"*/
                  /*| "nogc"*/
                  /*;*/

/*[> TODO: implement remaining rules. See: https://dlang.org/spec/grammar.html#UserDefinedAttribute <]*/
/*userDefinedAttribute : '@' identifier_;*/

term    : number                { $$ = $1; }
        | identifier_           { $$ = $1; }
        ;

%%
#include "main.c"

%{
#include "y.tab.h"
%}
%%

"class"                {return keyword_class;}
"struct"               {return keyword_struct;}
"typedef"              {return keyword_typedef;}
"alias"                {return keyword_alias;}
"template"             {return keyword_template;}

"return"               {return keyword_return;}
"this"                 {return keyword_this;}
"nothrow"              {return keyword_nothrow;}
"pure"                 {return keyword_pure;}

"auto"                 {return spec_auto;}
"final"                {return spec_final;}
"in"                   {return spec_in;}
"lazy"                 {return spec_lazy;}
"out"                  {return spec_out;}
"ref"                  {return spec_ref;}
"scope"                {return spec_scope;}

"const"                {return spec_const;}
"immutable"            {return spec_immutable;}
"inout"                {return spec_inout;}
"shared"               {return spec_shared;}

"safe"                 {return funcattr_safe;}
"property"             {return funcattr_property;}
"trusted"              {return funcattr_trusted;}
"system"               {return funcattr_system;}
"disable"              {return funcattr_disable;}
"nogc"                 {return funcattr_nogc;}

"bool"                 {return btype_bool;}
"byte"                 {return btype_byte;}
"ubyte"                {return btype_ubyte;}
"short"                {return btype_short;}
"ushort"               {return btype_ushort;}
"int"                  {return btype_int;}
"uint"                 {return btype_uint;}
"long"                 {return btype_long;}
"ulong"                {return btype_ulong;}
"char"                 {return btype_char;}
"wchar"                {return btype_wchar;}
"dchar"                {return btype_dchar;}
"float"                {return btype_float;}
"double"               {return btype_double;}
"real"                 {return btype_real;}
"ifloat"               {return btype_ifloat;}
"idouble"              {return btype_idouble;}
"ireal"                {return btype_ireal;}
"cfloat"               {return btype_cfloat;}
"cdouble"              {return btype_cdouble;}
"creal"                {return btype_creal;}
"void"                 {return btype_void;}

[;@]                    {return yytext[0];}
","                    {return sym_comma;}


"exit"                 {return exit_command;}
"print"                {return print_command;}
[_a-zA-Z][_a-zA-Z0-9]* {yylval.identifier = yytext; return identifier_;}
[0-9]+                 {yylval.num = atoi(yytext); return number;}
"("                    {return l_parenthes;}
")"                    {return r_parenthes;}
"{"                    {return l_brace;}
"}"                    {return r_brace;}
[ \t\n]                ;
.                      {ECHO; yyerror ("unexpected character");}

%%
int yywrap (void) {return 1;}


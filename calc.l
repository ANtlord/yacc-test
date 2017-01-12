%{
#include "y.tab.h"
%}
%%

"exit"                 {return exit_command;}
"print"                {return print_command;}
[_a-zA-Z][_a-zA-Z0-9]* {yylval.sym = yytext; return identifier;}
[0-9]+                 {yylval.num = atoi(yytext); return number;}
[()]                   {yylval.paren = yytext[0]; return paren;}

%%
int yywrap (void) {return 1;}


%{
#include "y.tab.h"
%}
%%

[a-zA-Z]			   {yylval.sym = yytext[0]; return symbol;}
[0-9]+                 {yylval.num = atoi(yytext); return number;}
"exit"				   {return exit_command;}

%%
int yywrap (void) {return 1;}


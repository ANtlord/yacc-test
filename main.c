void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
extern char *yytext;
int main() {
    /*int token = yylex();*/
    /*while (token) {*/
        /*printf("%i - %s\n", token, yytext);*/
        /*token = yylex();*/
    /*}*/
    /*return 0;*/
    return yyparse();
}

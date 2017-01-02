void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 
int main() {
    int val = yylex();
    printf("%i", val);
    return 0;
}

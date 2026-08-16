%{
#include <stdio.h>
%}

/* Regex */
DIGITO      [0-9]
NUMERO      {DIGITO}+
ESPACO      [ \t]

%%

{ESPACO}+   { /* ignora espaços e tabulações */ }

"("         { printf("LPAREN\n"); }
")"         { printf("RPAREN\n"); }

"<="        { printf("REL_OP <=\n"); }
">="        { printf("REL_OP >=\n"); }
"=="        { printf("REL_OP ==\n"); }
"!="        { printf("REL_OP !=\n"); }
"<"         { printf("REL_OP <\n"); }
">"         { printf("REL_OP >\n"); }

"+"         { printf("PLUS\n"); }
"-"         { printf("MINUS\n"); }
"*"         { printf("TIMES\n"); }
"/"         { printf("DIVIDE\n"); }
"%"         { printf("MOD\n"); }
"^"         { printf("POWER\n"); }
"|"         { printf("ABS\n"); }

{NUMERO}    { printf("NUMBER %s\n", yytext); }

\n          { printf("NEWLINE\n"); }
<<EOF>>     { printf("NEWLINE\n"); yyterminate();}

.           { printf("Mystery character %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror(argv[1]);
            return 1;
        }
    }
    /* se nenhum arquivo for passado, yyin permanece stdin */

    yylex();

    if (argc > 1) fclose(yyin);
    return 0;
}

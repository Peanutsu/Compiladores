%{
#include <stdio.h>
%}

/* Regex */
DIGITO      [0-9]
LETRA       [a-zA-Z_]
ID          {LETRA}({LETRA}|{DIGITO})*
NUMERO      {DIGITO}+(\.{DIGITO}+)?
ESPACO      [ \t\n]
COMENTARIO  "//".*

%%

{ESPACO}+    { /* ignora espaços, tabulações e quebras de linha */ }
{COMENTARIO} { /* descarta comentário de linha */ }

"if"         { printf("IF\n"); }
"else"       { printf("ELSE\n"); }
"while"      { printf("WHILE\n"); }
"return"     { printf("RETURN\n"); }

{ID}         { printf("ID %s\n", yytext); }
{NUMERO}     { printf("NUMBER %s\n", yytext); }

.            { printf("SIMBOLO %s\n", yytext); }

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

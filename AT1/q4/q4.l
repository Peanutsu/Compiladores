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
    if (argc != 2) {
        printf("Erro: informe o nome do arquivo de entrada como argumento.\n");
        printf("Uso: %s <arquivo>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("Erro: nao foi possivel abrir o arquivo '%s'.\n", argv[1]);
        return 1;
    }

    yylex();

    fclose(yyin);
    return 0;
}

/* contador de estatisticas de texto, estilo Unix wc */
%option noyywrap
%{
#include <stdio.h>
#include <string.h>

int linhas     = 0;
int palavras   = 0;
int caracteres = 0;
int inteiros   = 0;
int floats     = 0;
int pontuacoes = 0;
%}

DIGITO   [0-9]
LETRA    [A-Za-zÀ-ÖØ-öø-ÿ]

%%

{DIGITO}+"."{DIGITO}+       { floats++;     caracteres += strlen(yytext); }
{DIGITO}+                   { inteiros++;   caracteres += strlen(yytext); }
{LETRA}+                    { palavras++;   caracteres += strlen(yytext); }
[.,;:!?]                    { pontuacoes++; caracteres += strlen(yytext); }
\n                          { caracteres++; linhas++; }
.                           { caracteres++; }

%%

int main(int argc, char **argv)
{
    if (argc > 1) {
        if (!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return 1;
        }
    }
    yylex();
    printf("linhas: %d\n",     linhas);
    printf("palavras: %d\n",   palavras);
    printf("caracteres: %d\n", caracteres);
    printf("inteiros: %d\n",   inteiros);
    printf("floats: %d\n",     floats);
    printf("pontuacoes: %d\n", pontuacoes);
    return 0;
}

%{
#include "looplang.tab.h"
#include <string.h>  // Add this line to declare strdup
%}


%%
"while"    { return WHILE; }
"do"       { return DO; }
"{"        { return LBRACE; }
"}"        { return RBRACE; }
"("        { return LPAREN; }
")"        { return RPAREN; }
";"        { return SEMICOLON; }
"="        { return ASSIGN; }
"<"        { return LT; }
"+"        { return PLUS; }
[a-zA-Z][a-zA-Z0-9]*  { yylval.str = strdup(yytext); return IDENT; }
[0-9]+     { yylval.str = strdup(yytext); return NUMBER; }
[ \t\n]    ; // Ignore whitespace
.          { printf("Unexpected character: %s\n", yytext); }
%%

int yywrap() { return 1; }

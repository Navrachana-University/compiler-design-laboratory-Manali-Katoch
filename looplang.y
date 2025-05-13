%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempVarCount = 0, labelCount = 0;

void newLabel(char* lbl) {
    sprintf(lbl, "L%d", labelCount++);
}

void newTemp(char* t) {
    sprintf(t, "t%d", tempVarCount++);
}

int yylex();
void yyerror(const char *s) { printf("Error: %s\n", s); }

%}

%union {
    char* str;
}

%token <str> IDENT NUMBER
%token WHILE DO LBRACE RBRACE LPAREN RPAREN SEMICOLON ASSIGN LT PLUS
%type <str> expr cond stmt stmts

%%

program: stmts
;

stmts:
      /* empty */            { $$ = strdup(""); }
    | stmts stmt             { 
                                char *buf = (char*)malloc(1024);
                                sprintf(buf, "%s%s", $1, $2);
                                $$ = buf;
                              }
;

stmt:
      WHILE LPAREN cond RPAREN LBRACE stmts RBRACE {
          char startLbl[10], endLbl[10];
          newLabel(startLbl); newLabel(endLbl);
          char *buf = (char*)malloc(2048);
          sprintf(buf,
                  "%s:\nif not %s goto %s\n%s"
                  "goto %s\n%s:\n",
                  startLbl, $3, endLbl, $6, startLbl, endLbl);
          $$ = buf;
      }
    | DO LBRACE stmts RBRACE WHILE LPAREN cond RPAREN SEMICOLON {
          char startLbl[10];
          newLabel(startLbl);
          char *buf = (char*)malloc(2048);
          sprintf(buf,
                  "%s:\n%s"
                  "if %s goto %s\n",
                  startLbl, $3, $7, startLbl);
          $$ = buf;
      }
    | IDENT ASSIGN expr SEMICOLON {
          char *buf = (char*)malloc(512);
          sprintf(buf, "%s = %s\n", $1, $3);
          $$ = buf;
      }
;

expr:
      IDENT      { $$ = $1; }
    | NUMBER     { $$ = $1; }
    | expr PLUS expr {
          char t[10];
          newTemp(t);
          printf("%s = %s + %s\n", t, $1, $3);
          $$ = strdup(t);
      }
;

cond:
      expr LT expr {
          char t[10];
          newTemp(t);
          printf("%s = %s < %s\n", t, $1, $3);
          $$ = strdup(t);
      }
;

%%

int main() {
    if (yyparse() == 0) {
        printf("Parsing successful!\n");
    }
    return 0;
}

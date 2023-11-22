%define api.header.include {"../include/cmat.tab.h"}

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

extern int yylex();
extern int yyerror(char *s);
%}

%token IF ELSE WHILE FOR RETURN MAIN INT FLOAT MATRIX VOID ID INT_CONST FLOAT_CONST '+' '-' '*' '/' '=' EQ NEQ LT LE GT GE AND OR '!' ';' ',' '(' ')' '[' ']' '{' '}' '~' STRING '\n' UNDEF FUNCTION_TYPE BY_VALUE BY_REFER

%start liste_id // temporaire

%%
  // peut etre eclaté, genere par ia

  type : INT
       | FLOAT
       | MATRIX

  type_fonction : type
                | VOID

  liste_type : type
              | type ',' liste_type

  liste_parametres : liste_type ID
                   | liste_type ID ',' liste_parametres
                   | %empty

  liste_id : ID
           | ID ',' liste_id

  liste_declarations : declaration
                     | declaration liste_declarations

  declaration : type ID ';'
              | type ID '[' INT_CONST ']' ';'
              | type ID '[' INT_CONST ']' '[' INT_CONST ']' ';'
                          
%%
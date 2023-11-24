%define api.header.include {"../include/cmat.tab.h"}

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

extern int yylex();
extern int yyerror(char *s);
%}

%token IF ELSE WHILE FOR RETURN MAIN INT FLOAT MATRIX VOID ID INT_CONST FLOAT_CONST '+' '-' '*' '/' '=' EQ NEQ LT LE GT GE AND OR '!' ';' ',' '(' ')' '[' ']' '{' '}' '~' STRING '\n' UNDEF FUNCTION_TYPE BY_VALUE BY_REFER

%start liste_instructions // temporaire

%%
  // peut etre eclaté, genere par ia
    liste_instructions : instruction
                       | instruction liste_instructions
                       | instruction '\n' liste_instructions
                       | %empty
                    

    instruction : declaration
                | affectation
                | expression
                | condition
                | iteration
                | return
                | bloc
                | ';'
                | error { yyerrok; }
    
    bloc : '{' liste_declarations liste_instructions '}'
            | '{' liste_declarations '}'
            | '{' liste_instructions '}'
            | '{' '}'

    affectation : ID '=' expression ';'

    condition : IF '(' expression ')' bloc
              | IF '(' expression ')' bloc ELSE instruction %prec BY_VALUE

    iteration : WHILE '(' expression ')' bloc
              | FOR '(' affectation expression ';' affectation ')' bloc   

    return : RETURN expression ';'
           | RETURN ';'
           
    expression : expression '+' expression
               | expression '-' expression
               | expression '*' expression
               | expression '/' expression
               | expression EQ expression
               | expression NEQ expression
               | expression LT expression
               | expression LE expression
               | expression GT expression
               | expression GE expression
               | expression AND expression
               | expression OR expression
               | expression '[' expression ']' // accès à un élément d'un tableau
               | expression '(' liste_expression ')' // appel de fonction
               | '-' expression %prec UNARY
               | '!' expression %prec UNARY
               | '(' expression ')'
               | ID
               | INT_CONST
               | FLOAT_CONST
               | STRING
               | ID '[' expression ']' // accès à un élément d'un tableau
               | ID '(' liste_expression ')' // appel de fonction

    liste_expression : expression
                     | expression ',' liste_expression

    



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

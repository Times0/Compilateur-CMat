%define api.header.include {"../include/cmat.tab.h"}

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

extern int yylex();
extern int yyerror(char *s);
%}

%token IF ELSE WHILE FOR RETURN MAIN INT FLOAT VOID ID INT_CONST FLOAT_CONST '+' '-' '*' '/' '=' EQ NEQ LT LE GT GE AND OR '!' ';' ',' '(' ')' '[' ']' '{' '}' '~' STRING '\n' UNDEF MATRIX FUNCTION_TYPE BY_VALUE BY_REFER

%start liste

%%

  liste : liste instruction '\n'                
        | %empty
        

  instruction : ID '=' expression               
              | ID                              

  expression : operande                         
             | operande operateur2 operande     
             | operateur1 operande              

  operateur2 : OR                           
             | AND                           
             | '~'                            

  operateur1 : EQ                            

  operande : ID                                 
           | ensemble             

  ensemble : '{' '}'                            
           | '{' liste-elements '}'             

  liste-elements : INT_CONST                      
                 | INT_CONST ',' liste-elements 
%%
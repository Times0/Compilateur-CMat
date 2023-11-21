%define api.header.include {"../include/Cmat.tab.h"}

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

extern int yylex();
extern int yyerror(char *s);

// element de la table des symboles
typedef struct table_elem{
  char nom;
  uint32_t value;
}table_elem;

%}

%token UNDEF INT_TYPE FLOAT_TYPE STRING MATRIX_TYPE FUNCTION_TYPE BY_VALUE BY_REFER /*useless tokens*/ID ELEMENT UNION INTER COMP DIFF AFF '{' '}' '\n' ','

%start liste

%%

  liste : liste instruction '\n'                
        | %empty
        

  instruction : ID AFF expression               
              | ID                              

  expression : operande                         
             | operande operateur2 operande     
             | operateur1 operande              

  operateur2 : UNION                           
             | INTER                           
             | DIFF                            

  operateur1 : COMP                            

  operande : ID                                 
           | ensemble             

  ensemble : '{' '}'                            
           | '{' liste-elements '}'             

  liste-elements : ELEMENT                      
                 | ELEMENT ',' liste-elements 
%%
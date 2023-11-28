%define api.header.include {"../include/cmat.tab.h"}

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "../include/symbol_table.h"

extern FILE *yyin;
extern FILE *yyout;
extern int yylex();
extern int yyerror(char *s);

%}

%union {
     int int_val;
     double double_val;
     char *str_val;
     list_t* symbol_table_item;
}

%token INT FLOAT MATRIX VOID FUNCTION STRING
%token IF ELSE WHILE FOR RETURN MAIN LOGIC_TYPE   
%token '+' '-' '*' '/' '%' INCR DECR AND_OP OR_OP EQ_OP NEQ_OP LT_OP LE_OP GT_OP GE_OP '!' '~'
%token '(' ')' '[' ']' '{' '}' ';' ',' DDOT '=' REFER
%token ID INT_CONST FLOAT_CONST UNDEF


%start instruction_list

%left '+' '-'
%left '*' '/'
%left INCR DECR
%left AND_OP OR_OP
%left EQ_OP NEQ_OP LT_OP LE_OP GT_OP GE_OP
%left '!'

%%
instruction_list: instruction instruction_list
                | %empty
     
instruction : declaration
            | declaration_function
            | condition
            | affectation ';'
            | expression ';'
            | loop
            | return ';'
            | array ';'  // surement inutile, autorise les lignes du type : A[1][2];
            | bloc


// Declarations
declaration : type id_or_affectation_list ';'
            | type declaration_matrix_list ';'


// Declarations variables
id_or_affectation_list : id_or_affectation
                       | id_or_affectation ',' id_or_affectation_list

id_or_affectation : ID
                  | ID '=' expression_or_cst_or_array_or_id


// Declaration de matrices
declaration_matrix_list : declaration_matrix
                        | declaration_matrix ',' declaration_matrix_list

declaration_matrix : ID '[' INT_CONST ']' affectation_matrix
                   | ID '[' INT_CONST ']' '[' INT_CONST ']' affectation_matrix


// Declarations fonctions
declaration_function : type function_name '(' parameter_list ')' bloc
                     | VOID function_name '(' parameter_list ')' bloc // On ajoute void car "type" est un type de variable

function_name : ID
              | MAIN

parameter : type ID
          | type ID '[' INT_CONST ']'
          | type ID '[' INT_CONST ']' '[' INT_CONST ']' 

parameter_list : parameter ',' parameter_list
               | parameter
               | %empty


// Return
return : RETURN expression_or_cst_or_array_or_id


// Boucles
loop : WHILE '(' expression_or_cst_or_array_or_id ')' bloc
     | FOR '(' affectation ';' expression_or_cst_or_array_or_id ';' expression_or_cst_or_array_or_id')' bloc
     | FOR '(' declaration expression_or_cst_or_array_or_id ';' expression_or_cst_or_array_or_id ')' bloc


// Conditions
condition : IF '(' expression ')' bloc
          | IF '(' expression ')' bloc ELSE bloc
          | IF '(' expression ')' bloc ELSE condition


// Affectation initiale de matrices
affectation_matrix : '=' '{' array_element_list '}'
                   | %empty

array_element_list : constant_list
                   | '{' constant_list '}'
                   | '{' constant_list '}' ',' array_element_list


// Affectation
affectation : ID '=' expression_or_cst_or_array_or_id
            | array '=' expression_or_cst_or_array_or_id


// Types & signes & constantes
type : INT
     | FLOAT
     | MATRIX

sign : '+'
     | '-'

constant : INT_CONST
         | FLOAT_CONST
                 
constant_list : sign constant
              | constant
              | sign constant ',' constant_list
              | constant ',' constant_list


// Expressions
expression : cst_or_array_or_id '+' expression_or_cst_or_array_or_id
           | cst_or_array_or_id '-' expression_or_cst_or_array_or_id 
           | cst_or_array_or_id '*' expression_or_cst_or_array_or_id
           | cst_or_array_or_id '/' expression_or_cst_or_array_or_id
           | cst_or_array_or_id '%' expression_or_cst_or_array_or_id
           | cst_or_array_or_id OR_OP expression_or_cst_or_array_or_id
           | cst_or_array_or_id AND_OP expression_or_cst_or_array_or_id
           | cst_or_array_or_id EQ_OP expression_or_cst_or_array_or_id
           | cst_or_array_or_id NEQ_OP expression_or_cst_or_array_or_id
           | cst_or_array_or_id LT_OP expression_or_cst_or_array_or_id
           | cst_or_array_or_id LE_OP expression_or_cst_or_array_or_id
           | cst_or_array_or_id GT_OP expression_or_cst_or_array_or_id
           | cst_or_array_or_id GE_OP expression_or_cst_or_array_or_id
           | '(' expression_or_cst_or_array_or_id ')'                       
           | ID INCR                                                        /* incrementation */                                            
           | INCR ID           
           | ID DECR                                                        /* decrementation */         
           | DECR ID
           | '!' expression_or_cst_or_array_or_id                           /* negation logique */
           | '(' type ')' expression_or_cst_or_array_or_id                  /* cast */
           | ID '(' expression_or_cst_or_array_or_id_or_string_list')'      /* appel de fonction */
           | '~' ID
           | sign expression_or_cst_or_array_or_id                           /*negation arithmetique*/


// Slices de matrices
array : ID '[' expression_or_cst_or_array_or_id_or_slice ']'
      | ID '[' expression_or_cst_or_array_or_id_or_slice ']' '[' expression_or_cst_or_array_or_id_or_slice ']'
     
expression_or_cst_or_array_or_id_or_slice : expression_or_cst_or_array_or_idexpression_or_cst_or_array_or_id_or_slice
                                          | expression_or_cst_or_array_or_idexpression_or_cst_or_array_or_id_or_slice ';' expression_or_cst_or_array_or_idexpression_or_cst_or_array_or_id_or_slice

expression_or_cst_or_array_or_idexpression_or_cst_or_array_or_id_or_slice : slice
                                                                          | expression_or_cst_or_array_or_id

slice : '*'
      | expression_or_cst_or_array_or_id DDOT expression_or_cst_or_array_or_id

     
// Misc
bloc : '{' instruction_list '}'     

cst_or_array_or_id : array
                   | ID
                   | constant

expression_or_cst_or_array_or_id : expression
                                 | cst_or_array_or_id

expression_or_cst_or_array_or_id_or_string_list : expression_or_cst_or_array_or_id
                                                | expression_or_cst_or_array_or_id ',' expression_or_cst_or_array_or_id_or_string_list
                                                | STRING
                                                | STRING ',' expression_or_cst_or_array_or_id_or_string_list
                                                | %empty

     
%define api.header.include {"../include/cmat.tab.h"}

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "symbol_table.h"


extern FILE *yyin;
extern FILE *yyout;
extern int yylex();
extern int yyerror(char *s);
%}

<<<<<<< Updated upstream
%union {
     int int_val;
     double double_val;
     char *str_val;
     list_t* symbol_table_item;
}

%token<int_val> INT_TYPE FLOAT_TYPE IF ELSE WHILE FOR VOID_TYPE RETURN MAIN LOGIC_TYPE MATRIX_TYPE
%token<int_val> ADD_OP MUL_OP DIV_OP INCR DECR AND_OP OR_OP EQ_OP NEQ_OP REL_OP NOT_OP TRANSPOSE_OP
%token<int_val> LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE SEMI DOT COMMA ASSIGN REFER
%token<symbol_table_item> ID
%token<int_val> INT_CONST 
%token<double_val> FLOAT_CONST
%token<str_val> STR_TYPE
=======
/* tokens */
%token INT FLOAT MATRIX VOID FUNCTION STRING
%token IF ELSE WHILE FOR RETURN MAIN LOGIC_TYPE   
%token '+' '-' '*' '/' INCR DECR AND_OP OR_OP EQ_OP NEQ_OP LT_OP LE_OP GT_OP GE_OP '!' '~'
%token '(' ')' '[' ']' '{' '}' ';' ',' '=' REFER
%token ID INT_CONST FLOAT_CONST UNDEF
>>>>>>> Stashed changes


%start instruction_list

%%
     instruction_list: instruction instruction_list
                     | %empty
     
     instruction : declaration
                 /* | declaration_fonction */
                 /* | condition */
                 /* | affectation */
                 /* | expression */
                 /* | loop */
                 | return
                 /* | bloc */

<<<<<<< Updated upstream
program
    : declarations statements
    ;

declarations
    : /* empty */
    | declarations declaration
    ;

declaration
    : type names SEMI
    ;

type
    : INT_TYPE
    | FLOAT_TYPE
    | VOID_TYPE
    | MATRIX_TYPE
    ;

names
    : ID
    | names COMMA ID
    ;

constant
    : INT_CONST     { printf("%d\n", yylval.int_val); }
    | FLOAT_CONST   { printf("%.2f\n", yylval.double_val); }
    ;

statements
    : /* empty */
    | statements statement
    ;

statement
    : if_statement
    | for_statement
    | while_statement
    | assignment SEMI
    | RETURN expression SEMI
    | block
    ;

block
    : LBRACE statements RBRACE
    ;

if_statement
    : IF LPAREN expression RPAREN statement %prec LOWER_THAN_ELSE
    | IF LPAREN expression RPAREN statement ELSE statement
    ;

for_statement
    : FOR LPAREN opt_expression SEMI opt_expression SEMI opt_expression RPAREN statement
    ;

while_statement
    : WHILE LPAREN expression RPAREN statement
    ;

assignment
    : variable ASSIGN expression
    | matrix_variable ASSIGN matrix_expression
    ;

variable
    : ID
    ;

matrix_variable
    : ID LBRACKET expression RBRACKET
    | ID LBRACKET expression RBRACKET LBRACKET expression RBRACKET
    ;

expression
    : constant
    | variable
    | matrix_variable
    | LPAREN expression RPAREN
    | expression ADD_OP expression
    | expression MUL_OP expression
    | expression REL_OP expression
    | expression EQ_OP expression
    | expression NEQ_OP expression
    | expression AND_OP expression
    | expression OR_OP expression
    | NOT_OP expression
    | variable INCR %prec INCR
    | variable DECR %prec DECR
    | INCR variable %prec INCR
    | DECR variable %prec DECR
    ;

matrix_expression
    : matrix_variable TRANSPOSE_OP
    | matrix_variable ADD_OP matrix_variable
    | matrix_variable MUL_OP matrix_variable
    | matrix_variable DIV_OP matrix_variable
    ;

opt_expression
    : /* empty */
    | expression
    ;
=======
     // Declarations
     declaration : type ID ';'
                 | type nom_fonction '(' liste_parametres ')' bloc
                 | VOID nom_fonction '(' liste_parametres ')' bloc
                 | type ID '[' INT_CONST ']' ';'
                 | type ID '[' INT_CONST ']' '[' INT_CONST ']' ';'
>>>>>>> Stashed changes

     type: INT
         | FLOAT
         | MATRIX

     /* id_or_affectation_list : id_or_affectation */
                            /* | id_or_affectation ',' id_or_affectation_list */

     id_or_affectation : ID
                       /* | affectation */

     /* affectation : ID '=' sign constant */
                 /* | ID '=' constant */
                 /* | ID '=' expression */

     sign: '+'
         | '-'
     
     constant: INT_CONST
             | FLOAT_CONST

     // Fonctions

     

     

     nom_fonction : ID
                  | MAIN

     liste_parametres : type ID
                      | type ID ',' liste_parametres
                      | %empty

     bloc : '{' instruction_list '}'

     // Return

     return : RETURN expression ';'


/*     // Conditions

     loop : WHILE '(' expression ')' instruction
          | FOR '(' affectation ';' expression ';' expression')' instruction*/

     

     expression: ID '+' expression
               | ID
              /* | expression '-' expression
              | expression '*' expression
              | expression '/' expression
              | INCR expression
              | DECR expression
              | expression INCR
              | expression DECR
              | expression OR_OP expression
              | expression AND_OP expression
              | '!' expression
              | expression EQ_OP expression
              | expression NEQ_OP expression
              | expression LT_OP expression
              | expression LE_OP expression
              | expression GT_OP expression
              | expression GE_OP expression
              | '(' expression ')'
              | ID 
              | sign constant
              | constant
      */

    

    

     /*

     condition : IF '(' expression ')' instruction
               | IF '(' expression ')' instruction ELSE instruction

     

     

     /*
     // Declarations

	declarations: declarations declaration
			  | declaration


    //declaration: type names ';'
     
    variable : ID
             | pointer ID
             | ID array
     
    pointer: pointer '*' 
           | '*'
     
    array: array '[' INT_CONST ']'
         | '[' INT_CONST ']'
     
    statements: statements statement
              | statement
     
     // Conditions

	tail: statement ';' 
	 	| '{' statements '}'

    if_statement: IF '{' expression '}' tail else_if_part else_part

    else_if_part: else_if_part ELSE IF '(' expression ')' tail
                | ELSE IF '(' expression ')' tail
                | empty

    else_part: ELSE tail
             | empty 
     
    for_statement: FOR '(' declaration expression ';' statement ')' tail

    while_statement: WHILE '(' expression ')' tail

     // Expressions

    
     
    statement | '{' statements '}'

    
     
    matrix_op: matrix_variable '+' matrix_variable
             | matrix_variable '*' matrix_variable
             | matrix_variable '/' matrix_variable
             | TRANSPOSE matrix_variable
             | sign matrix_variable
             | matrix_variable '[' INT_CONST '.' '.' INT_CONST ']'
             | matrix_variable '[' INT_CONST '.' '.' INT_CONST ']' '[' INT_CONST '.' '.' INT_CONST ']'
             | constant '*' matrix_variable
             | matrix_variable '*' constant
             | constant '/' matrix_variable
             | matrix_variable '/' constant
             | constant '+' matrix_variable
             | matrix_variable '+' constant
             | INCR matrix_variable
             | DECR matrix_variable
             | matrix_variable INCR
             | matrix_variable DECR
              
     

	

    statement: if_statement 
             | for_statement
             | while_statement
             | RETURN
             
     assignment: reference variable ASSIGN expression ';' 
          
	reference: REFER
             | empty 
	*/
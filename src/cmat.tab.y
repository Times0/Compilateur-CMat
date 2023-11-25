%define api.header.include {"../include/cmat.tab.h"}

%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

extern FILE *yyin;
extern FILE *yyout;
extern int yylex();
extern int yyerror(char *s);
%}

/* tokens */
%token INT_TYPE FLOAT_TYPE MATRIX_TYPE STR_TYPE IF ELSE WHILE FOR  VOID_TYPE RETURN MAIN  LOGIC_TYPE   
%token ADD_OP MUL_OP DIV_OP INCR DECR AND_OP OR_OP EQ_OP NEQ_OP REL_OP NOT_OP TRANSPOSE
%token LPAREN RPAREN LBRACKET RBRACKET LBRACE RBRACE SEMI DOT COMMA ASSIGN REFER
%token ID INT_CONST FLOAT_CONST UNDEF


%start program

%%

     // Program
     program: declarations statements 

     // Declarations

	declarations: declarations declaration
				| declaration


    declaration: type names SEMI
	 

    matrix_variable: ID LBRACKET INT_CONST RBRACKET
                   | ID LBRACKET INT_CONST RBRACKET LBRACKET INT_CONST RBRACKET

    type: INT_TYPE
        | FLOAT_TYPE
        | VOID_TYPE
	    | STR_TYPE
         
    names: ID
         | names COMMA ID
     
    variable : ID
             | pointer ID
             | ID array
     
    pointer: pointer '*' 
           | '*'
     
    array: array LBRACKET INT_CONST RBRACKET
         | LBRACKET INT_CONST RBRACKET
     
    statements: statements statement
              | statement
     
     // Conditions

	tail: statement SEMI 
	 	| LBRACE statements RBRACE

    if_statement: IF LBRACE expression RBRACE tail else_if_part else_part

    else_if_part: else_if_part ELSE IF LPAREN expression RPAREN tail
                | ELSE IF LPAREN expression RPAREN tail
                | /* empty */

    else_part: ELSE tail
             | /* empty */
     
    for_statement: FOR LPAREN declaration expression SEMI statement RPAREN tail

    while_statement: WHILE LPAREN expression RPAREN tail

     // Expressions

    sign: ADD_OP
        | /* empty */
     
    statement | LBRACE statements RBRACE

    expression: expression ADD_OP expression
              | expression MUL_OP expression
              | expression DIV_OP expression
              | INCR expression
              | DECR expression
              | expression INCR
              | expression DECR
              | expression OR_OP expression
              | expression AND_OP expression
              | NOT_OP expression
              | expression EQ_OP expression
              | expression NEQ_OP expression
              | expression REL_OP expression
              | LPAREN expression RPAREN
              | variable 
              | sign constant
     
    matrix_op: matrix_variable ADD_OP matrix_variable
             | matrix_variable MUL_OP matrix_variable
             | matrix_variable DIV_OP matrix_variable
             | TRANSPOSE matrix_variable
             | sign matrix_variable
             | matrix_variable LBRACKET INT_CONST DOT DOT INT_CONST RBRACKET
             | matrix_variable LBRACKET INT_CONST DOT DOT INT_CONST RBRACKET LBRACKET INT_CONST DOT DOT INT_CONST RBRACKET
             | constant MUL_OP matrix_variable
             | matrix_variable MUL_OP constant
             | constant DIV_OP matrix_variable
             | matrix_variable DIV_OP constant
             | constant ADD_OP matrix_variable
             | matrix_variable ADD_OP constant
             | INCR matrix_variable
             | DECR matrix_variable
             | matrix_variable INCR
             | matrix_variable DECR
              
     

	constant: INT_CONST
            | FLOAT_CONST

    statement: if_statement 
             | for_statement
             | while_statement
             | RETURN
             
    assignment: reference variable ASSIGN expression SEMI
          
	reference: REFER
             | /* empty */
	
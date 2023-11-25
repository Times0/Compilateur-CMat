%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "symbol_table.h"


extern int yylex(void);
extern void yyerror(const char *s);

int yywrap() { return 1; }
%}

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

// Define operator precedence (highest to lowest)
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE
%right ASSIGN
%left OR_OP
%left AND_OP
%nonassoc EQ_OP NEQ_OP
%nonassoc REL_OP
%left ADD_OP SUB_OP
%left MUL_OP DIV_OP
%right NOT_OP
%right INCR DECR
%precedence TRANSPOSE_OP

%start program

%%

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

%%


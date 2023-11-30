%define api.header.include {"../include/cmat.tab.h"}
%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "symbol_table.h"
#include "../include/quad.h"

extern FILE *yyin;
extern FILE *yyout;
extern int yylex();
extern int yyerror(char *s);
extern struct code *code;
extern SymbolTable *symbol_table;
extern struct code * code;
%}

%union {
    long int intval;
    char strval[40];
    struct {
        SymbolTableElement * ptr;
    } exprval;
}

%token <intval>INT_CONST
%token FLOAT_CONST

%token RETURN
%token <strval>ID
%token ';' '-' '*' '/' '^' '(' ')'

%token '+' 
// useless
%token MATRIX STRING FLOAT INT VOID MAIN IF ELSE WHILE FOR LOG_OP OR_OP COMP_OP ASSIGN_OP UNARY_OP  GT_OP LE_OP LT_OP NEQ_OP EQ_OP DEC_OP DDOT
%token REl_OP INC_OP GE_OP AND_OP DECR INCR


// priorités
%left '+' '-'
%left '*' '/'
%left '^'
%right UNARY_OP
%left '(' ')'



%type <exprval> expression

%start start
%%
start: instruction_list

instruction_list: instruction instruction_list
                | %empty 

instruction : return ';'
            | assign ';'

return : RETURN expression

assign :  ID '=' expression
          {    
               SymbolTableElement *id = lookup($1);
               if (id->name[0] == '\0')
                   id = insert($1, strlen($1), UNDEF, 0);
               gencode(code,COPY,id,$3.ptr,NULL);
          }

expression :   expression '+' expression     
               { 
                    $$.ptr = newtemp(symbol_table);
                    gencode(code,BOP_PLUS,$$.ptr,$1.ptr,$3.ptr); 
               }
               | expression '-' expression 
               | expression '*' expression 
               | expression '/' expression 
               | INT_CONST
               { 
                    $$.ptr = newtemp(symbol_table);
                    $$.ptr->val.int_val = $1;
               }
          
%%     
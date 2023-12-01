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
extern __uint32_t lineno;
extern __uint32_t current_scope;
%}

%union {
     __uint32_t type_val;
     __uint64_t int_val;
     float float_val;

    char strval[40];
    struct {
        SymbolTableElement * ptr;
    } exprval;
}

%token <int_val> INT_CONST
%token <type_val> INT FLOAT MATRIX 
%token FLOAT_CONST

%token RETURN
%token <strval>ID
%token ';' '-' '*' '/' '^' '(' ')'

%token '+' 
// useless
%token STRING VOID MAIN IF ELSE WHILE FOR LOG_OP OR_OP COMP_OP ASSIGN_OP UNARY_OP  GT_OP LE_OP LT_OP NEQ_OP EQ_OP DEC_OP DDOT
%token REl_OP INC_OP GE_OP AND_OP DECR INCR


// priorités
%left '+' '-'
%left '*' '/'
%left '^'
%right UNARY_OP
%left '(' ')'



%type <exprval> expression
%type <type_val> type

%start start
%%
start: instruction_list

instruction_list: instruction instruction_list
                | %empty 

instruction : declaration ';'
            | return ';'
            | assign ';'

declaration :  type ID
               {
                    insert($2, $1, VARIABLE);
               }

type : INT  
     | FLOAT
     | MATRIX

return : RETURN expression

assign :  ID '=' expression
          {    
               SymbolTableElement *id = lookup_scope($1, current_scope, VARIABLE);
               if(id == NULL)
               {
                    printf("Error variable \"%s\" not declared\n", $1);
                    exit(1);
               }
               gencode(code, COPY, id, $3.ptr, NULL);
          }

expression :   expression '+' expression     
               { 
                    $$.ptr = newtemp(symbol_table);
                    gencode(code, BOP_PLUS, $$.ptr, $1.ptr, $3.ptr); 
               }
               | expression '-' expression 
               | expression '*' expression 
               | expression '/' expression 
               | INT_CONST
               { 
                    Value v;
                    v.int_value = $1;
                    $$.ptr = insert_constant(v, INT);
               }
          
%%     
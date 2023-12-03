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
extern QuadTable *code;
extern SymbolTable *symbol_table;
extern __uint32_t lineno;
extern __uint32_t current_scope;
uint32_t offset = 0;

uint32_t get_float_type(uint32_t type1, uint32_t type2);
%}

%union {
     __uint32_t type_val;
     __uint64_t int_val;
     float float_val;

    char strval[MAXTOKENLEN];
    struct {
        SymbolTableElement * ptr;
    } exprval;
}

%token <int_val> INT_CONST
%token <float_val> FLOAT_CONST
%token <type_val> INT FLOAT MATRIX 

%token RETURN
%token <strval>ID
%token ';' '*' '/' '^' '(' ')'

%token '+' '-' 
// useless
%token STRING VOID MAIN IF ELSE WHILE FOR LOG_OP OR_OP COMP_OP ASSIGN_OP UNARY_OP GT_OP LE_OP LT_OP NEQ_OP EQ_OP DEC_OP DDOT
%token REl_OP INC_OP GE_OP AND_OP DECR INCR


// priorités
%left '+' '-'
%left '*' '/'
%left '%'
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
                    insert(&symbol_table, $2, $1, VARIABLE, -1);
               }

type : INT  
     | FLOAT
     | MATRIX

return : RETURN expression

assign :  ID '=' expression
          {    
               SymbolTableElement *id = lookup_scope(symbol_table, $1, current_scope, VARIABLE);
               if(id == NULL)
               {
                    printf("Error variable \"%s\" not declared\n", $1);
                    exit(1);
               }
               gen_quad(code, COPY, id, $3.ptr, NULL);
          }

expression :   expression '+' expression     
               { 
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), offset);
                    gen_quad(code, BOP_PLUS, $$.ptr, $1.ptr, $3.ptr); 
                    offset++;
               }
               | expression '-' expression 
               {
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), offset);
                    gen_quad(code, BOP_MINUS, $$.ptr, $1.ptr, $3.ptr); 
                    offset++;
               }
               | expression '*' expression
               {
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), offset);
                    gen_quad(code, BOP_MULT, $$.ptr, $1.ptr, $3.ptr); 
                    offset++;
               }
               | expression '/' expression
               {
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), offset);
                    gen_quad(code, BOP_DIV, $$.ptr, $1.ptr, $3.ptr); 
                    offset++;
               }
               | expression '%' expression
               {
                    if($1.ptr->type != INT || $3.ptr->type != INT)
                    {
                         printf("Error at line %d : modulo operator can only be applied to integers\n", lineno);
                         exit(1);
                    }
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), offset);
                    gen_quad(code, BOP_MOD, $$.ptr, $1.ptr, $3.ptr); 
                    offset++;
               }
               | '-' expression %prec UNARY_OP
               {
                    $$.ptr = newtemp(symbol_table, get_float_type($2.ptr->type, INT), offset);
                    gen_quad(code, UOP_MINUS, $$.ptr, $2.ptr, NULL);
               }
               | '(' expression ')'
               {
                    $$.ptr = $2.ptr;
               }
               | ID
               {
                    $$.ptr = lookup_scope(symbol_table, $1, current_scope, VARIABLE);
                    if($$.ptr == NULL)
                    {
                         printf("Error at line %d : variable \"%s\" not declared\n", lineno, $1);
                         exit(1);
                    }
               }
               | INT_CONST
               { 
                    Constant v;
                    v.int_value = $1;
                    v.float_value = (float)$1;
                    $$.ptr = insert_constant(&symbol_table, v, INT);
               }
               | FLOAT_CONST
               { 
                    Constant v;
                    v.float_value = $1;
                    v.int_value = (int)$1;
                    $$.ptr = insert_constant(&symbol_table, v, FLOAT);
               }
          
%%     

uint32_t get_float_type(uint32_t type1, uint32_t type2)
{
     return (type1 == FLOAT || type2 == FLOAT)? FLOAT : INT;
}
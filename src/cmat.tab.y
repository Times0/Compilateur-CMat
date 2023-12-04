%define api.header.include {"../include/cmat.tab.h"}
%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
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
void semantic_error(const char *format, ...);
void semantic_warning(const char *format, ...);
%}

%union
{
     __uint32_t type_val;
     __uint32_t int_val;
     float float_val;

     char str_val[MAXTOKENLEN];
     char string_val[MAXSTRLEN];
    
     struct
     {
          SymbolTableElement * ptr;
          SymbolTableElement ** ptr_list;
          __uint32_t size;
          __uint32_t capacity;
     }expr;
}

%token <int_val> INT_CONST
%token <float_val> FLOAT_CONST
%token <type_val> INT FLOAT MATRIX 
%token <string_val> STRING
%token <str_val>ID
%token RETURN

%token ';' '*' '/' '^' '(' ')'

%token '+' '-' 
// useless
%token VOID MAIN IF ELSE WHILE FOR LOG_OP OR_OP COMP_OP ASSIGN_OP UNARY_OP GT_OP LE_OP LT_OP NEQ_OP EQ_OP DDOT
%token REl_OP GE_OP AND_OP DECR INCR


// priorités
%left '+' '-' '*' '/' '%'
%left EQ_OP NEQ_OP OR_OP AND_OP LT_OP GT_OP LE_OP GE_OP
%right UNARY_OP
%left '(' ')'



%type <expr> expression
%type <expr> expression_list
%type <type_val> type

%start start
%%
start: instruction_list

instruction_list: instruction instruction_list
                | %empty 

instruction : declaration ';'
            | call ';'
            | return ';'
            | assign ';'
            | expression ';'

declaration :  type ID
               {
                    insert_variable(&symbol_table, $2, $1, VARIABLE, -1);
               }

type : INT  
     | FLOAT
     | MATRIX

call : ID '(' expression_list ')'
     {
          SymbolTableElement *id = lookup_function(symbol_table, $1);
          if(strcmp($1, "print") == 0)
          {
               if($3.size != id->attribute.function.nb_parameters)
               {
                    semantic_error("print take one argument");
               }
               if($3.ptr_list[0]->type != INT && $3.ptr_list[0]->type != FLOAT)
               {
                    semantic_error("print only takes int or float as argument");
               }
               gen_quad_function(code, CALL_PRINT, NULL, id, $3.ptr_list, $3.size); // changer le null
          }
          else if(strcmp($1, "printf") == 0)
          {
               if($3.size != id->attribute.function.nb_parameters)
               {
                    semantic_error("printf take one argument");
               }
               if($3.ptr_list[0]->type != STRING)
               {
                    semantic_error("printf only takes string as argument");
               }
               gen_quad_function(code, CALL_PRINTF, NULL, id, $3.ptr_list, $3.size); // changer le null
          }
          else
          {
               if(id == NULL)
               {
                    semantic_error("function \"%s\" not declared", $1);
               }
          }
     }

expression_list : expression ',' expression_list
               {
                    if($3.size == $3.capacity)
                    {
                         $3.capacity *= 2;
                         $3.ptr_list = realloc($3.ptr_list, $3.capacity*sizeof(SymbolTableElement *));
                         if($3.ptr_list == NULL)
                         {
                              printf("realloc failed\n");
                              exit(1);
                         }
                    }
                    $3.ptr_list[$3.size] = $1.ptr;
                    $3.size++;
                    $$.ptr_list = $3.ptr_list;
                    $$.size = $3.size;
                    $$.capacity = $3.capacity;
               }
               | expression
               {     
                    $$.capacity = 4;
                    $$.ptr_list = malloc($$.capacity*sizeof(SymbolTableElement *));
                    if($$.ptr_list == NULL)
                    {
                         printf("malloc failed\n");
                         exit(1);
                    }
                    $$.ptr_list[0] = $1.ptr;
                    $$.size = 1;
               }
               | %empty
               {
                    $$.size = 0;
               }


return : RETURN expression

assign :  ID '=' expression
          {    
               SymbolTableElement *id = lookup_variable(symbol_table, $1, current_scope, VARIABLE);
               if(id == NULL)
               {
                    semantic_error("variable \"%s\" not declared", $1);
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
                         semantic_error("modulo operator can only be applied to integers");
                    }
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), offset);
                    gen_quad(code, BOP_MOD, $$.ptr, $1.ptr, $3.ptr); 
                    offset++;
               }
               | expression OR_OP expression
               {
                    if($1.ptr->type != INT || $3.ptr->type != INT)
                    {
                         semantic_error("\"||\" can only be applied to int");
                    }
                    
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), offset);
                    gen_quad(code, BOP_OR, $$.ptr, $1.ptr, $3.ptr); 
                    offset++;
               }
               | expression AND_OP expression
               {
                    if($1.ptr->type != INT || $3.ptr->type != INT)
                    {
                         semantic_error("\"||\" can only be applied to int");
                    }
                    
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), offset);
                    gen_quad(code, BOP_AND, $$.ptr, $1.ptr, $3.ptr); 
                    offset++;
               }
               | expression EQ_OP expression
               {
                    if($1.ptr->type != $3.ptr->type)
                    {
                         semantic_error("\"==\" can only be applied to operands of the same type");
                    }
                    if(get_float_type($1.ptr->type, $3.ptr->type) == FLOAT)
                    {
                         semantic_warning("\"==\" applied to floating point numbers");
                    }
                    $$.ptr = newtemp(symbol_table, INT, offset);
                    gen_quad(code, BOP_EQ, $$.ptr, $1.ptr, $3.ptr); 
                    offset++;
               }
               | expression NEQ_OP expression
               {
                    if($1.ptr->type != $3.ptr->type)
                    {
                         semantic_error("comparison operator can only be applied to operands of the same type");
                    }
                    $$.ptr = newtemp(symbol_table, INT, offset);
                    gen_quad(code, BOP_NEQ, $$.ptr, $1.ptr, $3.ptr); 
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
               | ID INCR
               {
                    SymbolTableElement *id = lookup_variable(symbol_table, $1, current_scope, VARIABLE);
                    if(id == NULL)
                    {
                         semantic_error("variable \"%s\" not declared", $1);
                    }
                    Constant c;
                    c.int_value = 1;
                    c.float_value = (float)1;
                    SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);
                    
                    $$.ptr = newtemp(symbol_table, id->type, offset);
                    gen_quad(code, BOP_PLUS, id, id, n1); 
                    offset++;
               }
               | INCR ID
               {
                    SymbolTableElement *id = lookup_variable(symbol_table, $2, current_scope, VARIABLE);
                    if(id == NULL)
                    {
                         semantic_error("variable \"%s\" not declared", $2);
                    }
                    Constant c;
                    c.int_value = 1;
                    c.float_value = (float)1;
                    SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);
                    
                    $$.ptr = newtemp(symbol_table, id->type, offset);
                    gen_quad(code, BOP_PLUS, id, id, n1); 
                    offset++;
               }
               | ID DECR
               {
                    SymbolTableElement *id = lookup_variable(symbol_table, $1, current_scope, VARIABLE);
                    if(id == NULL)
                    {
                         semantic_error("variable \"%s\" not declared", $1);
                    }
                    Constant c;
                    c.int_value = 1;
                    c.float_value = (float)1;
                    SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);
                    
                    $$.ptr = newtemp(symbol_table, id->type, offset);
                    gen_quad(code, BOP_MINUS, id, id, n1); 
                    offset++;
               }
               | DECR ID
               {
                    SymbolTableElement *id = lookup_variable(symbol_table, $2, current_scope, VARIABLE);
                    if(id == NULL)
                    {
                         semantic_error("variable \"%s\" not declared", $2);
                    }
                    Constant c;
                    c.int_value = 1;
                    c.float_value = (float)1;
                    SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);
                    
                    $$.ptr = newtemp(symbol_table, id->type, offset);
                    gen_quad(code, BOP_MINUS, id, id, n1); 
                    offset++;
               }
               | ID
               {
                    $$.ptr = lookup_variable(symbol_table, $1, current_scope, VARIABLE);
                    if($$.ptr == NULL)
                    {
                         semantic_error("variable \"%s\" not declared", $1);
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
               | STRING
               {
                    $$.ptr = insert_string(&symbol_table, $1);
                    $$.ptr->attribute.string.offset = offset+1;
               }
          
%%     

uint32_t get_float_type(uint32_t type1, uint32_t type2)
{
     return (type1 == FLOAT || type2 == FLOAT)? FLOAT : INT;
}

void semantic_error(const char *format, ...)
{
    printf("Error at line %d : ", lineno);
    fflush(stdout);
    
    va_list args;
    va_start(args, format);
    vfprintf(stderr, format, args);
    va_end(args);

    fprintf(stderr, "\n");
    exit(1);
}

void semantic_warning(const char *format, ...)
{
    printf("Warning at line %d : ", lineno);
    fflush(stdout);

    va_list args;
    va_start(args, format);
    vfprintf(stderr, format, args);
    va_end(args);

    fprintf(stderr, "\n");
}
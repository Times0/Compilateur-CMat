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
 __uint32_t current_scope = 0;
 __uint32_t max_scope = 0;
 SymbolTable *next_symbol_table = NULL;
 __uint32_t lineno = 1;
__uint32_t frame_pointer = 0;
__uint32_t logical_expression_flag = 0;

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
          __uint32_t size_ptr_list;
          __uint32_t capacity_ptr_list;
          __uint32_t *true_list;        // liste des indices quads à compléter pour le vrai
          __uint32_t *false_list;       // liste des indices quads à compléter pour le faux
          __uint32_t *next_list;        // liste des indices quads à compléter pour le suivant ?
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
%type <expr> parameter
%type <expr> parameter_list
%type <expr> statement
%type <expr> block
%type <expr> instruction
%type <expr> instruction_list
%type <expr> call
%type <expr> assign
%type <expr> declaration
%type <type_val> type
%type <int_val> M

%start start
%%
start: instruction_list

instruction_list: instruction_list M instruction   { complete_list($1.next_list, $2); $$.next_list = $3.next_list; }
                | instruction                      { $$.next_list = $1.next_list; }


instruction : declaration ';'    { $$.next_list = create_list(-1); }
            | declaration_function
            | call ';'           { $$.next_list = create_list(-1); }
            | assign ';'         { $$.next_list = create_list(-1); }
            | expression ';'      { $$.next_list = create_list(-1); }
            | statement            //{ $$.next_list = $1.next_list; }
            | block                //{ $$.next_list = $1.next_list; }


M : %empty { $$ = code->nextquad; }

statement : IF '(' {logical_expression_flag++;} expression ')' {logical_expression_flag--;} M block
          {
               complete_list($4.true_list, $7);
               $$.next_list = concat_list($4.false_list, $8.next_list);
               $$.next_list = concat_list($$.next_list, create_list(code->nextquad));
               gen_quad_goto(code, K_GOTO, NULL, NULL, NULL);
          }

declaration_function : type MAIN '(' ')' block

declaration :  type ID
               {
                    SymbolTableElement *l = lookup_variable(symbol_table, $2, current_scope, VARIABLE, 1);
                    if(l != NULL)
                    {
                         semantic_error("variable \"%s\" already declared in this scope", $2);
                    }
                    if(current_scope == 0)
                         insert_variable(symbol_table, $2, $1, VARIABLE, -1, current_scope);
                    else
                    {
                         insert_variable(symbol_table, $2, $1, VARIABLE, frame_pointer, current_scope);
                         frame_pointer++;
                    }     
               }

type : INT  
     | FLOAT
     | MATRIX

call : ID '(' parameter_list ')'
     {
          SymbolTableElement *id = lookup_function(symbol_table, $1);

          if(strcmp($1, "print") == 0)
          {
               if($3.size_ptr_list != id->attribute.function.nb_parameters)
               {
                    semantic_error("print take one argument");
               }
               if($3.ptr_list[0]->type != INT && $3.ptr_list[0]->type != FLOAT)
               {
                    semantic_error("print only takes int or float as argument");
               }
               gen_quad_function(code, K_CALL_PRINT, NULL, id, $3.ptr_list, $3.size_ptr_list); // changer le null
          }
          else if(strcmp($1, "printf") == 0)
          {
               if($3.size_ptr_list != id->attribute.function.nb_parameters)
               {
                    semantic_error("printf takes one argument");
               }
               if($3.ptr_list[0]->type != STRING)
               {
                    semantic_error("printf only takes string as argument");
               }
               gen_quad_function(code, K_CALL_PRINTF, NULL, id, $3.ptr_list, $3.size_ptr_list); // changer le null
          }
          else
          {
               if(id == NULL)
               {
                    semantic_error("function \"%s\" not declared", $1);
               }
          }
     }

parameter : expression
          {
               $$.ptr = $1.ptr;
          }
          | STRING
          {
               $$.ptr = insert_string(&symbol_table, $1, frame_pointer);
          }

parameter_list : parameter ',' parameter_list
               {
                    if($3.size_ptr_list == $3.capacity_ptr_list)
                    {
                         $3.capacity_ptr_list *= 2;
                         $3.ptr_list = realloc($3.ptr_list, $3.capacity_ptr_list*sizeof(SymbolTableElement *));
                         if($3.ptr_list == NULL)
                         {
                              printf("realloc failed\n");
                              exit(1);
                         }
                    }
                    $3.ptr_list[$3.size_ptr_list] = $1.ptr;
                    $3.size_ptr_list++;
                    $$.ptr_list = $3.ptr_list;
                    $$.size_ptr_list = $3.size_ptr_list;
                    $$.capacity_ptr_list = $3.capacity_ptr_list;
               }
               | parameter
               {     
                    $$.capacity_ptr_list = 4;
                    $$.ptr_list = malloc($$.capacity_ptr_list*sizeof(SymbolTableElement *));
                    if($$.ptr_list == NULL)
                    {
                         printf("malloc failed\n");
                         exit(1);
                    }
                    $$.ptr_list[0] = $1.ptr;
                    $$.size_ptr_list = 1;
               }
               | %empty
               {
                    $$.size_ptr_list = 0;
               }



/* return : RETURN expression */

assign :  ID '=' expression
          {    
               SymbolTableElement *id = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 0);
               if(id == NULL)
               {
                    semantic_error("variable \"%s\" not declared", $1);
               }
               gen_quad(code, K_COPY, id, $3.ptr, NULL);
          }

block : '{'                   {
                                   __uint32_t t = current_scope;
                                   max_scope++; current_scope = max_scope;
                                   add_next_symbol_table(&symbol_table, current_scope, t);
                              } 
        instruction_list      
        '}'                   {
                                   $$.next_list = $3.next_list;
                                   complete_list($3.next_list, code->nextquad);
                                   
                                   frame_pointer -= get_symbol_table_by_scope(symbol_table, current_scope)->size; // il faut plus que ca pour string et matrice
                                   current_scope = get_symbol_table_by_scope(symbol_table, current_scope)->previous->scope; 
                              }
     /* | instruction */ // tres smart 



expression :   expression '+' expression     
               { 
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), frame_pointer);
                    gen_quad(code, BOP_PLUS, $$.ptr, $1.ptr, $3.ptr); 
                    frame_pointer++;
               }
               | expression '-' expression 
               {
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), frame_pointer);
                    gen_quad(code, BOP_MINUS, $$.ptr, $1.ptr, $3.ptr); 
                    frame_pointer++;
               }
               | expression '*' expression
               {
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), frame_pointer);
                    gen_quad(code, BOP_MULT, $$.ptr, $1.ptr, $3.ptr); 
                    frame_pointer++;
               }
               | expression '/' expression
               {
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), frame_pointer);
                    gen_quad(code, BOP_DIV, $$.ptr, $1.ptr, $3.ptr); 
                    frame_pointer++;
               }
               | expression '%' expression
               {
                    if($1.ptr->type != INT || $3.ptr->type != INT)
                    {
                         semantic_error("modulo operator can only be applied to integers");
                    }
                    $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $3.ptr->type), frame_pointer);
                    gen_quad(code, BOP_MOD, $$.ptr, $1.ptr, $3.ptr); 
                    frame_pointer++;
               }
               | expression OR_OP M expression
               {
                    if(logical_expression_flag == 1)
                    {
                         complete_list($1.false_list, $3);
                         $$.false_list = $4.false_list;
                         $$.true_list = concat_list($1.true_list, $4.true_list);
                    }
                    else // supprimer dans mips
                    {
                         semantic_warning("\"||\" used outside of a condition");
                         $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $4.ptr->type), frame_pointer);
                         gen_quad(code, BOP_OR, $$.ptr, $1.ptr, $4.ptr); 
                         frame_pointer++;
                    }
               }
               | expression AND_OP M expression
               {
                    if(logical_expression_flag == 1)
                    {
                         complete_list($1.true_list, $3);
                         $$.true_list = $4.true_list;
                         $$.false_list = concat_list($1.false_list, $4.false_list);
                    }
                    else
                    {
                         $$.ptr = newtemp(symbol_table, get_float_type($1.ptr->type, $4.ptr->type), frame_pointer);
                         gen_quad(code, BOP_AND, $$.ptr, $1.ptr, $4.ptr); 
                         frame_pointer++;
                    }
               }
               | '!' expression %prec UNARY_OP
               {
                    if(logical_expression_flag == 1)
                    {
                         $$.true_list = $2.false_list;
                         $$.false_list = $2.true_list;
                    }
                    else
                    {
                         $$.ptr = newtemp(symbol_table, $2.ptr->type, frame_pointer);
                         gen_quad(code, UOP_NOT, $$.ptr, $2.ptr, NULL); 
                         frame_pointer++;
                    }
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
                    $$.ptr = newtemp(symbol_table, INT, frame_pointer);
                    gen_quad(code, BOP_EQ, $$.ptr, $1.ptr, $3.ptr); 
                    frame_pointer++;
               }
               | expression NEQ_OP expression
               {
                    if($1.ptr->type != $3.ptr->type)
                    {
                         semantic_error("comparison operator can only be applied to operands of the same type");
                    }
                    $$.ptr = newtemp(symbol_table, INT, frame_pointer);
                    gen_quad(code, BOP_NEQ, $$.ptr, $1.ptr, $3.ptr); 
                    frame_pointer++;
               }
               | '-' expression %prec UNARY_OP
               {
                    $$.ptr = newtemp(symbol_table, $2.ptr->type, frame_pointer);
                    gen_quad(code, UOP_MINUS, $$.ptr, $2.ptr, NULL);
               }
               | '(' expression ')'
               {
                    if(logical_expression_flag == 1)
                    {
                         $$.true_list = $2.true_list;
                         $$.false_list = $2.false_list;
                    }
                    else
                    {
                         $$.ptr = $2.ptr;
                    }
               }
               | ID INCR
               {
                    SymbolTableElement *id = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 0);
                    if(id == NULL)
                    {
                         semantic_error("variable \"%s\" not declared", $1);
                    }
                    Constant c;
                    c.int_value = 1;
                    c.float_value = (float)1;
                    SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);
                    
                    $$.ptr = newtemp(symbol_table, id->type, frame_pointer);
                    gen_quad(code, BOP_PLUS, id, id, n1); 
                    frame_pointer++;
               }
               | INCR ID
               {
                    SymbolTableElement *id = lookup_variable(symbol_table, $2, current_scope, VARIABLE, 0);
                    if(id == NULL)
                    {
                         semantic_error("variable \"%s\" not declared", $2);
                    }
                    Constant c;
                    c.int_value = 1;
                    c.float_value = (float)1;
                    SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);
                    
                    $$.ptr = newtemp(symbol_table, id->type, frame_pointer);
                    gen_quad(code, BOP_PLUS, id, id, n1); 
                    frame_pointer++;
               }
               | ID DECR
               {
                    SymbolTableElement *id = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 0);
                    if(id == NULL)
                    {
                         semantic_error("variable \"%s\" not declared", $1);
                    }
                    Constant c;
                    c.int_value = 1;
                    c.float_value = (float)1;
                    SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);
                    
                    $$.ptr = newtemp(symbol_table, id->type, frame_pointer);
                    gen_quad(code, BOP_MINUS, id, id, n1); 
                    frame_pointer++;
               }
               | DECR ID
               {
                    SymbolTableElement *id = lookup_variable(symbol_table, $2, current_scope, VARIABLE, 0);
                    if(id == NULL)
                    {
                         semantic_error("variable \"%s\" not declared", $2);
                    }
                    Constant c;
                    c.int_value = 1;
                    c.float_value = (float)1;
                    SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);
                    
                    $$.ptr = newtemp(symbol_table, id->type, frame_pointer);
                    gen_quad(code, BOP_MINUS, id, id, n1); 
                    frame_pointer++;
               }
               | ID
               {
                    $$.ptr = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 0);
                    if($$.ptr == NULL)
                    {
                         semantic_error("variable \"%s\" not declared", $1);
                    }

                    if(logical_expression_flag == 1)
                    {
                         $$.true_list = create_list(code->nextquad);
                         $$.false_list = create_list(code->nextquad+1);
                         gen_quad_goto(code, K_IF, $$.ptr, NULL, NULL);
                         gen_quad_goto(code, K_GOTO, NULL, NULL, NULL);
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
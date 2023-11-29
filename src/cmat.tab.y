%define api.header.include {"../include/cmat.tab.h"}
%{
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "symbol_table.h"
#include "ast.h"


extern FILE *yyin;
extern FILE *yyout;
extern int yylex();
extern int yyerror(char *s);
extern tree_t *root;

%}

%union {
     int int_val;
     float float_val;
     list_t* symbol_table_item;
     char char_val;
     struct tree* tree_type;
}

%token <int_val> INT_CONST

%token RETURN
%token ID
%token ';' '-' '*' '/' '^' '(' ')'

%token <char_val> '+' 
// useless
%token MATRIX STRING FLOAT INT VOID MAIN IF ELSE WHILE FOR LOG_OP OR_OP COMP_OP ASSIGN_OP UNARY_OP  GT_OP LE_OP LT_OP NEQ_OP EQ_OP DEC_OP DDOT
%token REl_OP INC_OP GE_OP AND_OP DECR INCR UNDEF

%type <tree_type> expression
%type <tree_type> instruction
%type <tree_type> instruction_list
%type <tree_type> assign
%type <tree_type> return
%type <tree_type> start


// priorités
%left '+' '-'
%left '*' '/'
%left '^'
%right UNARY_OP
%left '(' ')'


%start start
%%
start: instruction_list {root = $1;}

instruction_list: instruction instruction_list {$$ = $1;} // todo 
                | %empty 

instruction : return ';' {$$=$1;}
            | assign ';'

return : RETURN expression {tree_t *t = create_tree(); t->name="return"; t->type="keyword"; t->left=$2; $$=t;}

assign : ID '=' expression

expression : expression '+' expression  {tree_t *t = create_tree(); t->name="+"; t->type="operation"; t->left=$1; t->right=$3; $$=t;}
               | expression '-' expression  {tree_t *t = create_tree(); t->name="-"; t->type="operation"; t->left=$1; t->right=$3; $$=t;}
               | expression '*' expression  {tree_t *t = create_tree(); t->name="*"; t->type="operation"; t->left=$1; t->right=$3; $$=t;}
               | expression '/' expression  {tree_t *t = create_tree(); t->name="/"; t->type="operation"; t->left=$1; t->right=$3; $$=t;}
           | INT_CONST {tree_t *t = create_tree(); t->value = $1; t->name="int"; t->type="int"; $$=t;}
          
%%     




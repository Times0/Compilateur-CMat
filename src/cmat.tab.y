%define api.header.include {"../include/cmat.tab.h"}
/* %glr-parser */
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
extern int yyerror(const char *s);
extern QuadTable *code;
extern SymbolTable *symbol_table;
 __uint32_t current_scope = 0;
 __uint32_t max_scope = 0;
 SymbolTable *next_symbol_table = NULL;
 __uint32_t lineno = 1;
__uint32_t adress = 0;                  // donne la prochaine adresse dans la stack
__uint32_t logical_expression_flag = 0; // permet d'indiquer si on se situe dans une expression logique

uint32_t get_float_type(uint32_t type1, uint32_t type2);
SymbolTableElement *generate_address_quads(SymbolTableElement *id, SymbolTableElement *add, SymbolTableElement *add2);
SymbolTableElement *matrix_operation(SymbolTableElement *a1, SymbolTableElement *a2, __uint32_t op);
SymbolTableElement *matrix_operation_constant(SymbolTableElement *a1, SymbolTableElement *a2, __uint32_t op);
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

          SymbolTableElement ** ptr_list;    // liste de pointeurs vers des elements de la table des symboles, pour les parametres de fonctions ou slice des tableaux
          __uint32_t size_ptr_list;          // taille de la liste, dans le cas des slice cela correspond au nombre de slice de la 1ere dimension
          __uint32_t size_ptr_list2;         // 2eme dimension
          __uint32_t capacity_ptr_list;      
          
          __uint32_t *by_address_list;       // liste de 0, FLOAT, INT pour savoir si on passe par adresse ou non et si oui quel est le type de l'objet pointé
          __uint32_t by_address;             // de meme pour un seul element
          
          
          __int32_t *true_list;        // liste des indices quads à compléter pour le vrai
          __int32_t *false_list;       // liste des indices quads à compléter pour le faux
          __int32_t *next_list;        // liste des indices quads à compléter pour le suivant ?
          __uint32_t quad;
          __uint32_t size[2];
     }expr;
}

%token <int_val> INT_CONST
%token <float_val> FLOAT_CONST
%token <type_val> INT FLOAT MATRIX 
%token <string_val> STRING
%token <str_val>ID
%token <int_val> GT_OP GE_OP LT_OP LE_OP EQ_OP NEQ_OP


%token ';' '*' '/' '^' '(' ')'
%token '+' '-' 
// useless
%token VOID MAIN IF ELSE WHILE FOR UNARY_OP DDOT
%token DECR INCR
%token RETURN


// priorités
%left '+' '-' '*' '/' '%'
%left EQ_OP NEQ_OP LT_OP GT_OP LE_OP GE_OP '!'
%right UNARY_OP
%left '(' ')' OR_OP AND_OP


%type <expr> expression
%type <expr> primary_expression
%type <expr> multiplicative_expresssion
%type <expr> additive_expression
%type <expr> logical_expression
%type <expr> parameter
%type <expr> parameter_list
%type <expr> statement
%type <expr> statement_if
%type <expr> statement_else
%type <expr> statement_while
%type <expr> statement_for
%type <expr> block
%type <expr> instruction
%type <expr> instruction_list
%type <expr> declaration_function
%type <expr> declaration_affectation
%type <expr> call
%type <expr> assign
%type <expr> declaration
%type <expr> declaration_or_assign
%type <int_val> declaration_array
%type <expr> slice_array
%type <expr> expression_slice
%type <expr> expression_slice_list
%type <type_val> type
%type <expr> M
%type <expr> N

%start start
%%
start: instruction_list
     | %empty

instruction_list: instruction_list M instruction   { complete_list($1.next_list, $2.quad); $$.next_list = $3.next_list; }
                | instruction                      { $$.next_list = $1.next_list; }


instruction : declaration ';'           { $$.next_list = create_list(-1);}
            | declaration_function
            | call ';'                  { $$.next_list = create_list(-1);}
            | assign ';'                { $$.next_list = create_list(-1);}
            | expression ';'            { $$.next_list = create_list(-1);}
            | statement                 
            | block                


M : %empty { $$.quad = code->nextquad; }

N : %empty { $$.next_list = create_list(code->nextquad); gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){0, 0}); $$.quad = code->nextquad; }

statement : statement_if
          | statement_while
          | statement_for

statement_if : IF '(' {logical_expression_flag++;} expression ')' {logical_expression_flag--;} M block statement_else
             {
                    // si pas de else
                    if($9.ptr == NULL)
                    {
                         complete_list($4.true_list, $7.quad);
                         $$.next_list = concat_list($4.false_list, $8.next_list);
                         $$.next_list = concat_list($$.next_list, create_list(code->nextquad));
                         gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){0, 0});
                    }
                    else
                    {
                         complete_list($4.true_list, $7.quad);
                         complete_list($4.false_list, $9.quad);
                         $$.next_list = concat_list($8.next_list, $9.next_list);
                         $$.next_list = concat_list($$.next_list, create_list(code->nextquad));
                         gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){0, 0});
                    }
             }

statement_else : ELSE N statement_if
               {
                    $$.next_list = concat_list($2.next_list, $3.next_list);
                    $$.quad = $2.quad;
               }
               | ELSE N block
               {
                    $$.next_list = concat_list($2.next_list, $3.next_list);
                    $$.quad = $2.quad;
               }
               | %empty
               {
                    $$.ptr = NULL;
               }

statement_while : WHILE M '(' {logical_expression_flag++;} expression ')' {logical_expression_flag--;} M block
                {
                    complete_list($5.true_list, $8.quad);
                    gen_quad_goto(code, K_GOTO, NULL, NULL, $2.quad, (__uint32_t[]){0, 0});
                    
                    // on ajoute un label pour le while, on regenere un label (meme si inutile) pour faciliter le free 
                    code->quads[$2.quad].label = $2.quad;

                    complete_list($9.next_list, $2.quad);
                    $$.next_list = $5.false_list;   
                }

statement_for : FOR M '(' {logical_expression_flag++;} declaration_or_assign ';' expression ';' M expression ')' {logical_expression_flag--;} M block
               {
                    // NULL
                    /*complete_list($7.true_list, $13.quad);
                    gen_quad_goto(code, K_GOTO, NULL, NULL, $2.quad+1);  // +1 pour l'initialisation
                    
                    // on ajoute un label pour le for, on regenere un label (meme si inutile) pour faciliter le free 
                    code->quads[$2.quad].label = $2.quad;

                    complete_list($14.next_list, $2.quad);
                    $$.next_list = $7.false_list;

                    Quad *q = malloc(sizeof(Quad)*($9.quad-$2.quad-1));
                    if(q == NULL)
                    {
                         printf("malloc failed in for\n");
                         exit(1);
                    }
                    // on copie les quads de la condition
                    for(int i = $2.quad+1; i < $9.quad; i++)
                    {
                         q[i-$2.quad-1] = code->quads[i];
                         printf("%d\t%d\n", q[i-$2.quad-1].label, q[i-$2.quad-1].branch_label);

                         /*if(q[i-$2.quad-1].label != -1 && q[i-$2.quad-1].kind != K_GOTO)
                         {
                              q[i-$2.quad-1].label += $13.quad-$9.quad;
                         }
                         if(q[i-$2.quad-1].branch_label != -1 && q[i-$2.quad-1].kind != K_GOTO)
                         {
                              q[i-$2.quad-1].branch_label += $13.quad-$9.quad;
                         }
     
                    }
                    // on les remplace par les quads de l'expression finale
                    for(int i = $9.quad; i < $13.quad; i++)
                    {
                         code->quads[i+$2.quad-$9.quad+1] = code->quads[i];
                    }
                    // on reecrit les quads de la condition
                    for(int i = $2.quad+1+($13.quad-$9.quad); i < $13.quad; i++)
                    {
                         code->quads[i] = q[i-$2.quad-1-($13.quad-$9.quad)];
                    }
                    // 13 20 17 20 11 */
               }

declaration_or_assign : declaration
                      | assign

declaration_function : type MAIN '(' ')' block {$$.ptr = NULL;}

// impossible de factoriser, on ne peut pas remplacer par "type assign" car la variable n'existe pas
declaration :  type ID declaration_affectation
               {
                    SymbolTableElement *l = lookup_variable(symbol_table, $2, current_scope, VARIABLE, 1);
                    if(l != NULL)
                    {
                         semantic_error("variable \"%s\" already declared in this scope", $2);
                    }
                    else if($1 == MATRIX)
                    {
                         semantic_error("can't declare matrix without bounds");
                    }

                    if(current_scope == 0)
                         insert_variable(symbol_table, $2, $1, VARIABLE, (__uint32_t[]){1, 1}, -1, current_scope);
                    else
                    {
                         insert_variable(symbol_table, $2, $1, VARIABLE, (__uint32_t[]){1, 1},adress, current_scope);
                         adress++;
                    }
                    // set a la valeur par initiale
                    if($3.ptr != NULL)
                    {
                         gen_quad(code, K_COPY, lookup_variable(symbol_table, $2, current_scope, VARIABLE, 0), $3.ptr, NULL, (__uint32_t[]){0, 0, 0});
                    }
               }
               | type ID declaration_array declaration_affectation
               {
                    SymbolTableElement *l = lookup_variable(symbol_table, $2, current_scope, VARIABLE, 1);
                    if(l != NULL)
                    {
                         semantic_error("variable \"%s\" already declared in this scope", $2);
                    }
                    if(current_scope == 0)
                         insert_variable(symbol_table, $2, $1, ARRAY, (__uint32_t[]){$3, 0}, -1, current_scope);
                    else
                    {
                         insert_variable(symbol_table, $2, $1, ARRAY, (__uint32_t[]){$3, 0}, adress, current_scope);
                         adress += $3*1;
                    }
               }
               | type ID declaration_array declaration_array declaration_affectation
               {
                    SymbolTableElement *l = lookup_variable(symbol_table, $2, current_scope, VARIABLE, 1);
                    if(l != NULL)
                    {
                         semantic_error("variable \"%s\" already declared in this scope", $2);
                    }
                    if(current_scope == 0)
                         insert_variable(symbol_table, $2, $1, ARRAY, (__uint32_t[]){$3, $4}, -1, current_scope);
                    else
                    {
                         insert_variable(symbol_table, $2, $1, ARRAY, (__uint32_t[]){$3, $4},adress, current_scope);
                         adress += $3*$4;
                    }
               }

declaration_array : '[' INT_CONST ']'   { $$ = $2;}

// il manque * generer les quad pour tous les slices
slice_array : '[' expression_slice_list ']'
            {
               $$.ptr_list = $2.ptr_list;
               $$.size_ptr_list = $2.size_ptr_list;

               for(int i=0; i< $2.size_ptr_list;i++)
                    printf("%d\n", $2.ptr_list[i]->attribute.constant.int_value);

            }

expression_slice : INT_CONST DDOT INT_CONST
                 {
                    if($3 <= $1)
                    {
                         semantic_error("invalid slice");
                    }
                    $$.size_ptr_list = $3-$1+1;
                    $$.ptr_list = malloc(($$.size_ptr_list)*sizeof(SymbolTableElement*));
                    if($$.ptr_list == NULL)
                    {
                         printf("Error malloc in expression_slice");
                         exit(1);
                    }
                    for(__uint32_t i = $1; i <= $3;i++)
                    {
                         SymbolTableElement *c = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i}, INT);
                         $$.ptr_list[i-$1] = c;
                    }
                 }
                 | additive_expression
                 {
                    $$.ptr_list = malloc(sizeof(SymbolTableElement *));
                    if($$.ptr_list == NULL)
                    {
                         printf("Error malloc in expression_slice\n");
                         exit(1);
                    }
                    if($1.ptr->class == ARRAY)
                    {
                         semantic_error("can't slice array with an array");
                    }
                    if($1.ptr->type == FLOAT)
                    {
                         semantic_error("can't slice array with a float");
                    }
                    $$.ptr_list[0] = $1.ptr;
                    $$.size_ptr_list = 1;
                 }
                 | '*'

expression_slice_list : expression_slice ';' expression_slice_list // merge les listes
                      {
                         $$.ptr_list = realloc($1.ptr_list, ($1.size_ptr_list+$3.size_ptr_list)*sizeof(SymbolTableElement*));
                         if($$.ptr_list == NULL)
                         {
                              printf("Error malloc in expression_slice_list");
                              exit(1);
                         }
                         for(__uint32_t i = 0; i<$3.size_ptr_list; i++)
                         {
                              $$.ptr_list[i+$1.size_ptr_list] = $3.ptr_list[i];
                         }
                         $$.size_ptr_list = $1.size_ptr_list+$3.size_ptr_list;
                      }
                      | expression_slice
                      {
                         $$.ptr_list = $1.ptr_list;
                         $$.size_ptr_list = $1.size_ptr_list;
                      }


declaration_affectation : '=' additive_expression
                        {
                              $$.ptr = $2.ptr;
                              if($2.ptr->class == ARRAY)
                              {
                                   semantic_error("can't affect array to variable");
                              }
                        }
                        | %empty
                        {
                              $$.ptr = NULL;
                        }

type : INT     {$$ = $1;}
     | FLOAT   {$$ = $1;}
     | MATRIX  {$$ = $1;}

call : ID '(' parameter_list ')'
     {
          SymbolTableElement *id = lookup_function(symbol_table, $1);
          if(strcmp($1, "print") == 0)
          {
               if($3.size_ptr_list != id->attribute.function.nb_parameters)
               {
                    semantic_error("print take one argument");
               }
               if($3.ptr_list[0]->class == ARRAY || $3.ptr_list[0]->class == STRING)
               {
                    semantic_error("print only takes int or float as argument");
               }
               gen_quad_function(code, K_CALL_PRINT, NULL, id, $3.ptr_list, $3.size_ptr_list, $3.by_address_list);
          }
          else if(strcmp($1, "printf") == 0)
          {
               if($3.size_ptr_list != id->attribute.function.nb_parameters)
               {
                    semantic_error("printf takes one argument");
               }
               if($3.ptr_list[0]->type != STRING)
               {
                    semantic_error("printf only takes one string as argument");
               }
               gen_quad_function(code, K_CALL_PRINTF, NULL, id, $3.ptr_list, $3.size_ptr_list, $3.by_address_list);
          }
          else if(strcmp($1, "printmat") == 0)
          {
               if($3.size_ptr_list != id->attribute.function.nb_parameters)
               {
                    semantic_error("printf takes one argument");
               }
               if($3.ptr_list[0]->type != MATRIX)
               {
                    semantic_error("printmat only takes one matrix as argument");
               }
               
               __uint32_t size = $3.ptr_list[0]->attribute.array.size[1];
               if(size == 0)
                    size++;

               SymbolTableElement *printff = lookup_function(symbol_table, "printf");
               SymbolTableElement *print = lookup_function(symbol_table, "print");
               SymbolTableElement **n = malloc(sizeof(SymbolTableElement*));
               SymbolTableElement **t = malloc(sizeof(SymbolTableElement*));
               if(n == NULL || t == NULL)
               {
                    printf("Error malloc in printmat\n");
                    exit(1);
               }
               n[0]  = insert_string(symbol_table, "\"\\n\"", adress);
               adress++;
               t[0]  = insert_string(symbol_table, "\"\\t\"", adress);
               adress++;

               
               for(int i=0;i<$3.ptr_list[0]->attribute.array.size[0];i++)
               {
                    for(int j=0;j<size;j++)
                    {
                         SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
                         SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
                         SymbolTableElement *e;
                         
                         // si 1 dimension
                         if(size == 1)
                              e = generate_address_quads($3.ptr_list[0], add1, NULL);
                         else
                              e = generate_address_quads($3.ptr_list[0], add1, add2);

                         // pas adress++ car on ne stocke pas les addresses
                         SymbolTableElement **list = malloc(sizeof(SymbolTableElement*));
                         __uint32_t *by_address_list = malloc(sizeof(__uint32_t));
                         if(list == NULL || by_address_list == NULL)
                         {
                              printf("Error malloc in call printmat");
                              exit(1);
                         }

                         list[0] = e;
                         by_address_list[0] = FLOAT;
                         gen_quad_function(code, K_CALL_PRINT, NULL, print, list, 1, by_address_list);
                         
                         // \t
                         gen_quad_function(code, K_CALL_PRINTF, NULL, printff, (SymbolTableElement **){t}, 1, (__uint32_t[]){0});
                    }
                    // \n
                    gen_quad_function(code, K_CALL_PRINTF, NULL, printff, (SymbolTableElement **){n}, 1, (__uint32_t[]){0});
               }
               adress-=2;
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
               $$.by_address = $1.by_address;

               // inutile
               if($1.by_address == MATRIX)
                    $$.by_address = FLOAT;
          }
          | STRING
          {
               $$.ptr = insert_string(symbol_table, $1, adress);
               // on ne modifie pas adress car on ne stocke pas les strings dans la pile
          }

parameter_list : parameter ',' parameter_list
               {
                    /*if($3.size_ptr_list == $3.capacity_ptr_list)
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
                    $$.capacity_ptr_list = $3.capacity_ptr_list;*/
               }
               | parameter
               {     
                    $$.capacity_ptr_list = 4;
                    $$.ptr_list = malloc($$.capacity_ptr_list*sizeof(SymbolTableElement *));
                    $$.by_address_list = malloc($$.capacity_ptr_list*sizeof(__uint32_t));
                    if($$.ptr_list == NULL || $$.by_address_list == NULL)
                    {
                         printf("malloc failed\n");
                         exit(1);
                    }
                    $$.ptr_list[0] = $1.ptr;
                    $$.by_address_list[0] = $1.by_address;
                    $$.size_ptr_list = 1;
               }
               | %empty
               {
                    $$.size_ptr_list = 0;
               }


assign :  ID '=' expression
          {    
               $$.ptr = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 0);
               if($$.ptr == NULL)
               {
                    semantic_error("variable \"%s\" not declared", $1);
               }
               
               if($$.ptr->class != ARRAY && $3.ptr->class != ARRAY)
                    gen_quad(code, K_COPY, $$.ptr, $3.ptr, NULL, (__uint32_t[]){0, 0, 0});
               else if($$.ptr->type == MATRIX && $3.ptr->type == MATRIX) // copie de matrice
               {    
                    if($$.ptr->attribute.array.size[0] != $3.ptr->attribute.array.size[0] || $$.ptr->attribute.array.size[1] != $3.ptr->attribute.array.size[1])
                         semantic_error("arrays size must be consistent for affectation");

                    __uint32_t size = $3.ptr->attribute.array.size[1];
                    if(size == 0)
                         size++;

                    // on ne stocke pas les variables temporaires contenat les adresses
                    for(int i=0;i<$3.ptr->attribute.array.size[0];i++)
                    {
                         for(int j=0;j<size;j++)
                         {
                              SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
                              SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
                              SymbolTableElement *e1, *e2;

                              if(size == 1)
                              {
                                   e1 = generate_address_quads($$.ptr, add1, NULL);
                                   adress++;
                                   e2 = generate_address_quads($3.ptr, add1, NULL);
                              }
                              else
                              {
                                   e1 = generate_address_quads($$.ptr, add1, add2);
                                   adress++;
                                   e2 = generate_address_quads($3.ptr, add1, add2);
                              }
                              
                              gen_quad(code, K_COPY, e1, e2, NULL, (__uint32_t[]){FLOAT, FLOAT, 0});
                              adress--;
                         }
                    }
                    
               }
               else
               {
                    semantic_error("\"=\" not permitted on list use matrix instead");
               }
          }
          | ID slice_array '=' expression    // bloquer les reference 1 pour matrice 2
          {
               SymbolTableElement *e = lookup_variable(symbol_table, $1, current_scope, ARRAY, 0);
               if(e == NULL)
               {
                    semantic_error("variable \"%s\" not declared", $1);
               }
               if($4.ptr->class == ARRAY)
               {
                    semantic_error("can't affect array to %s", e->type == INT?"INT":"FLOAT");
               }
                    
               SymbolTableElement *t = generate_address_quads(e, $2.ptr_list[0], NULL);
               __uint32_t type = e->type;
               if(e->type == MATRIX)
                    type = FLOAT;
               gen_quad(code, K_COPY, t, $4.ptr, NULL, (__uint32_t[]){type, $4.by_address, 0});
               adress++;
          }
          | ID slice_array slice_array '=' expression
          {
               SymbolTableElement *e = lookup_variable(symbol_table, $1, current_scope, ARRAY, 0);
               if(e == NULL)
               {
                    semantic_error("variable \"%s\" not declared", $1);
               }
               if($5.ptr->class == ARRAY)
               {
                    semantic_error("can't affect array to %s", e->type == INT?"INT":"FLOAT");
               }
               printf("%d %d\n", $2.size_ptr_list, $3.size_ptr_list);
               if($2.size_ptr_list > 1 || $3.size_ptr_list > 1)
               {
                    semantic_error("affectation of sliced matrix is impossible");
               }
               SymbolTableElement *t = generate_address_quads(e, $2.ptr_list[0], $3.ptr_list[0]);
               __uint32_t type = e->type;
               if(e->type == MATRIX)
                    type = FLOAT;
               gen_quad(code, K_COPY, t, $5.ptr, NULL, (__uint32_t[]){type, $5.by_address, 0});
               adress++;
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
                                   
                                   adress -= get_symbol_table_by_scope(symbol_table, current_scope)->nb_variable; // il faut plus que ca pour matrice
                                   current_scope = get_symbol_table_by_scope(symbol_table, current_scope)->previous->scope; 
                              }
     | '{' '}' {$$.ptr = NULL;}
     /* | instruction */ // tres smart 


additive_expression : multiplicative_expresssion
                    {
                         $$.ptr = $1.ptr;
                         $$.by_address = $1.by_address;

                         if(logical_expression_flag == 1)
                         {
                              $$.true_list = $1.true_list;
                              $$.false_list = $1.false_list;
                         }
                    }
                    | additive_expression '+' multiplicative_expresssion
                    { 
                         if($1.ptr->class != ARRAY && $3.ptr->class != ARRAY)
                         {
                              $$.ptr = newtemp(symbol_table, VARIABLE, get_float_type(get_float_type($1.ptr->type, $3.ptr->type), get_float_type($1.by_address, $3.by_address)), adress, (__uint32_t[]) {0, 0});
                              gen_quad(code, BOP_PLUS, $$.ptr, $1.ptr, $3.ptr, (__uint32_t[]){0, $1.by_address, $3.by_address}); 
                              $$.by_address = 0;
                              adress++;
                         }
                         else if($1.ptr->type == MATRIX && $3.ptr->type == MATRIX)
                         {
                              if($1.ptr->attribute.array.size[0] != $3.ptr->attribute.array.size[0] || $1.ptr->attribute.array.size[1] != $3.ptr->attribute.array.size[1])
                              {
                                   semantic_error("matrices should have the same dimension for \"+\"");
                              }

                              $$.ptr = matrix_operation($1.ptr, $3.ptr, '+');
                         }
                         else if(($1.ptr->type == MATRIX || $3.ptr->type == MATRIX) && ($1.ptr->class == CONSTANT || $3.ptr->class == CONSTANT))// matrices
                         {
                              $$.ptr = matrix_operation_constant($1.ptr, $3.ptr, '+');
                         }
                         else
                         {
                              semantic_error("operation not permitted on list use matrix instead");
                         }
                    }
                    | additive_expression '-' multiplicative_expresssion
                    {
                         if($1.ptr->class != ARRAY && $3.ptr->class != ARRAY)
                         {
                              $$.ptr = newtemp(symbol_table, VARIABLE, get_float_type(get_float_type($1.ptr->type, $3.ptr->type), get_float_type($1.by_address, $3.by_address)), adress, (__uint32_t[]) {0, 0});
                              gen_quad(code, BOP_MINUS, $$.ptr, $1.ptr, $3.ptr, (__uint32_t[]){0, $1.by_address, $3.by_address}); 
                              $$.by_address = 0;
                              adress++;
                         }
                         else if($1.ptr->type != MATRIX || $3.ptr->type != MATRIX)// matrices
                         {
                              semantic_error("operation not permitted on list use matrix instead");
                         }
                         else
                         {
                              if($1.ptr->attribute.array.size[0] != $3.ptr->attribute.array.size[0] || $1.ptr->attribute.array.size[1] != $3.ptr->attribute.array.size[1])
                              {
                                   semantic_error("matrices should have the same dimension for \"+\"");
                              }

                              $$.ptr = matrix_operation($1.ptr, $3.ptr, '-');
                         }
                    }
                    

multiplicative_expresssion : multiplicative_expresssion '*' primary_expression
                           {
                              if($1.ptr->class != ARRAY && $3.ptr->class != ARRAY)
                              {
                                   $$.ptr = newtemp(symbol_table, VARIABLE, get_float_type(get_float_type($1.ptr->type, $3.ptr->type), get_float_type($1.by_address, $3.by_address)), adress, (__uint32_t[]) {0, 0});
                                   gen_quad(code, BOP_MULT, $$.ptr, $1.ptr, $3.ptr, (__uint32_t[]){0, $1.by_address, $3.by_address}); 
                                   $$.by_address = 0;
                                   adress++;
                              }
                           }
                           | multiplicative_expresssion '/' primary_expression
                           {
                              if($1.ptr->class != ARRAY && $3.ptr->class != ARRAY)
                              {
                                   $$.ptr = newtemp(symbol_table, VARIABLE, get_float_type(get_float_type($1.ptr->type, $3.ptr->type), get_float_type($1.by_address, $3.by_address)), adress, (__uint32_t[]) {0, 0});
                                   gen_quad(code, BOP_DIV, $$.ptr, $1.ptr, $3.ptr, (__uint32_t[]){0, $1.by_address, $3.by_address}); 
                                   $$.by_address = 0;
                                   adress++;
                              }
                           }
                           | multiplicative_expresssion '%' primary_expression
                           {
                              if($1.ptr->type != INT || $3.ptr->type != INT || ($1.by_address != INT && $1.by_address != 0) || ($3.by_address != INT && $3.by_address != 0))
                              {
                                   semantic_error("modulo operator can only be applied to integers");
                              }
                              if($1.ptr->class != ARRAY && $3.ptr->class != ARRAY)
                              {
                                   $$.ptr = newtemp(symbol_table, VARIABLE, get_float_type(get_float_type($1.ptr->type, $3.ptr->type), get_float_type($1.by_address, $3.by_address)), adress, (__uint32_t[]) {0, 0});
                                   gen_quad(code, BOP_MOD, $$.ptr, $1.ptr, $3.ptr, (__uint32_t[]){0, $1.by_address, $3.by_address}); 
                                   $$.by_address = 0;
                                   adress++;
                              }
                           }
                           | primary_expression {$$.ptr = $1.ptr; $$.by_address = $1.by_address;}


primary_expression : ID
                    {
                         $$.ptr = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 0);
                         if($$.ptr == NULL)
                         {
                              semantic_error("variable \"%s\" not declared", $1);
                         }
                         $$.by_address = 0;
                         
                         if(logical_expression_flag)
                         {
                              $$.true_list = NULL;
                              $$.false_list = NULL;
                         }
                    }
                    | ID slice_array
                    {
                         SymbolTableElement *e = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 0);
                         if(e == NULL)
                         {
                              semantic_error("variable \"%s\" not declared", $1);
                         }
                         if(e->class != ARRAY)
                         {
                              semantic_error("variable \"%s\" is not an array", $1);
                         }
                         if(e->attribute.array.size[1] != 0)
                         {
                              semantic_error("variable \"%s\" have two dimensions", $1);
                         }
                         if($2.size_ptr_list == 1)
                         {
                              if(e->type == MATRIX)
                              {
                                   SymbolTableElement *t = generate_address_quads(e, $2.ptr_list[0], NULL);
                                   adress++;
                                   $$.ptr = t;
                                   $$.by_address = FLOAT;
                              }
                              // cas des tableaux
                              else
                              {

                                   SymbolTableElement *t = generate_address_quads(e, $2.ptr_list[0], NULL);
                                   adress++;
                                   $$.ptr = t;
                                   $$.by_address = e->type;         
                              }
                         }
                    }
                    | ID slice_array slice_array
                    {
                         SymbolTableElement *e = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 0);
                         if(e == NULL)
                         {
                              semantic_error("variable \"%s\" not declared", $1);
                         }
                         if(e->class != ARRAY)
                         {
                              semantic_error("variable \"%s\" is not an array", $1);
                         }
                         if(e->attribute.array.size[1] == 0)
                         {
                              semantic_error("variable \"%s\" have one dimension", $1);
                         }
                         if($2.size_ptr_list == 1 && $3.size_ptr_list == 1)
                         {
                              if(e->type == MATRIX)
                              {
                                   SymbolTableElement *add = insert_constant(&symbol_table, (Constant){.int_value = e->attribute.array.size[0], .float_value = (float)e->attribute.array.size[0]}, INT);
                                   SymbolTableElement *temp = newtemp(symbol_table, VARIABLE, INT, adress, (__uint32_t[]) {0, 0});
                                   adress++;
                                   gen_quad(code, BOP_MULT, temp, temp, $2.ptr_list[0], (__uint32_t[]){0, 0, 0});
                                   gen_quad(code, BOP_PLUS, temp, temp, $3.ptr_list[0], (__uint32_t[]){0, 0, 0});

                                   SymbolTableElement *t = generate_address_quads(e, temp, NULL);
                                   adress++;
                                   $$.ptr = t;
                                   $$.by_address = FLOAT;
                              }
                              // cas des tableaux
                              else
                              {

                                   SymbolTableElement *t = generate_address_quads(e, $2.ptr_list[0], NULL); // NUL
                                   adress++;
                                   $$.ptr = t;
                                   $$.by_address = e->type;         
                              }
                         }
                    }
                    | INT_CONST
                    {
                         Constant v;
                         v.int_value = $1;
                         v.float_value = (float)$1;
                         $$.ptr = insert_constant(&symbol_table, v, INT);
                         $$.by_address = 0;   
                    }
                    | FLOAT_CONST
                    { 
                         Constant v;
                         v.float_value = $1;
                         v.int_value = (int)$1;
                         $$.ptr = insert_constant(&symbol_table, v, FLOAT);
                         $$.by_address = 0;
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

                         gen_quad(code, BOP_PLUS, id, id, n1, (__uint32_t[]){0, 0, 0});
                         $$.by_address = 0;
                         $$.ptr = id;
                         
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

                         gen_quad(code, BOP_PLUS, id, id, n1, (__uint32_t[]){0, 0, 0});
                         $$.by_address = 0;
                         $$.ptr = id;
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

                         gen_quad(code, BOP_MINUS, id, id, n1, (__uint32_t[]){0, 0, 0});
                         $$.by_address = 0;
                         $$.ptr = id;
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

                         gen_quad(code, BOP_MINUS, id, id, n1, (__uint32_t[]){0, 0, 0});
                         $$.by_address = 0;
                         $$.ptr = id;
                    }
                    | '-' primary_expression %prec UNARY_OP
                    {
                         $$.ptr = newtemp(symbol_table, VARIABLE, get_float_type($2.ptr->type, $2.by_address), adress, (__uint32_t[]){0, 0});
                         adress++;
                         gen_quad(code, UOP_MINUS, $$.ptr, $2.ptr, NULL, (__uint32_t[]){0, $2.by_address, 0});
                         $$.by_address = 0;
                    }                    
                    | '!' primary_expression %prec UNARY_OP
                    {    
                         if($2.ptr->class == ARRAY)
                         {
                              semantic_error("\"!\" can't be applied to matrices");
                         }
                         if(logical_expression_flag == 0)
                         {
                             semantic_error("\"!\" can only be applied to logical expressions");
                         }
                         $$.true_list = $2.false_list;
                         $$.false_list = $2.true_list;
                         $$.ptr = $2.ptr;
                         $$.by_address = $2.by_address;
                    }
                    | '(' expression ')'
                    {
                         if(logical_expression_flag == 1)
                         {
                              $$.true_list = $2.true_list;
                              $$.false_list = $2.false_list;
                         }
                         $$.ptr = $2.ptr;
                         $$.by_address = $2.by_address;
                    }
                    

// priorité maximale
logical_expression  : additive_expression    // si on prend cette regle c'est qu'il n'y pas de comparaison et donc on a seulement une constante ou un id
                    {
                         $$.ptr = $1.ptr;
                         $$.by_address = $1.by_address;

                         if(logical_expression_flag == 1)
                         {
                              if($1.ptr->class == ARRAY)
                              {
                                   semantic_error("arrays are not allowed in logical expressions");
                              }
                              if($1.true_list == NULL && $1.false_list == NULL)
                              {
                                   $$.true_list = create_list(code->nextquad);
                                   $$.false_list = create_list(code->nextquad+1);
                              }
                              gen_quad_goto(code, K_IFNOT, $$.ptr, lookup_constant(symbol_table, (Constant){.int_value = 0}, INT), -1, (__uint32_t[]){$1.by_address, 0});
                              gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){0, 0});
                         }
                    }
                    | additive_expression EQ_OP additive_expression 
                    {
                       if(logical_expression_flag == 0)
                       {
                            semantic_error("\"==\" can only be applied to logical expressions");
                       }
                       if($1.ptr->class == ARRAY || $3.ptr->class == ARRAY)
                       {
                              semantic_error("\"==\" can't be applied to arrays");
                       }
                       $$.true_list = create_list(code->nextquad);
                       $$.false_list = create_list(code->nextquad+1);
                       gen_quad_goto(code, K_IF, $1.ptr, $3.ptr, -1, (__uint32_t[]){$1.by_address, $3.by_address});
                       gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){0, 0});
                    }  
                    | additive_expression NEQ_OP additive_expression
                    {
                         if(logical_expression_flag == 0)
                         {
                              semantic_error("comparison operator can only be applied to logical expressions");
                         }
                         if($1.ptr->class == ARRAY || $3.ptr->class == ARRAY)
                         {
                              semantic_error("\"!=\" can't be applied to arrays");
                         }
                         $$.true_list = create_list(code->nextquad);
                         $$.false_list = create_list(code->nextquad+1);
                         gen_quad_goto(code, K_IFNOT, $1.ptr, $3.ptr, -1, (__uint32_t[]){$1.by_address, $3.by_address});
                         gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){$1.by_address, $3.by_address});
                    }
                    | additive_expression LT_OP additive_expression
                    {
                         if(logical_expression_flag == 0)
                         {
                              semantic_error("comparison operator can only be applied to logical expressions");
                         }
                         if($1.ptr->class == ARRAY || $3.ptr->class == ARRAY)
                         {
                              semantic_error("\"<\" can't be applied to arrays");
                         }
                         $$.true_list = create_list(code->nextquad);
                         $$.false_list = create_list(code->nextquad+1);
                         gen_quad_goto(code, K_IFLT, $1.ptr, $3.ptr, -1, (__uint32_t[]){$1.by_address, $3.by_address});
                         gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){$1.by_address, $3.by_address});
                    }
                    | additive_expression GT_OP additive_expression
                    {
                         if(logical_expression_flag == 0)
                         {
                              semantic_error("comparison operator can only be applied to logical expressions");
                         }
                         if($1.ptr->class == ARRAY || $3.ptr->class == ARRAY)
                         {
                              semantic_error("\">\" can't be applied to arrays");
                         }
                         $$.true_list = create_list(code->nextquad);
                         $$.false_list = create_list(code->nextquad+1);
                         printf("Gen op_gt %p with %d\n", $$.true_list, $$.true_list[0]);
                         gen_quad_goto(code, K_IFGT, $1.ptr, $3.ptr, -1, (__uint32_t[]){$1.by_address, $3.by_address});
                         gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){$1.by_address, $3.by_address});
                    }
                    | additive_expression LE_OP additive_expression
                    {
                         if(logical_expression_flag == 0)
                         {
                              semantic_error("comparison operator can only be applied to logical expressions");
                         }
                         if($1.ptr->class == ARRAY || $3.ptr->class == ARRAY)
                         {
                              semantic_error("\"<=\" can't be applied to arrays");
                         }
                         $$.true_list = create_list(code->nextquad);
                         $$.false_list = create_list(code->nextquad+1);
                         gen_quad_goto(code, K_IFLE, $1.ptr, $3.ptr, -1, (__uint32_t[]){$1.by_address, $3.by_address});
                         gen_quad_goto(code, K_GOTO, NULL, NULL, -1,(__uint32_t[]){$1.by_address, $3.by_address});
                    }
                    | additive_expression GE_OP additive_expression
                    {
                         if(logical_expression_flag == 0)
                         {
                              semantic_error("comparison operator can only be applied to logical expressions");
                         }
                         if($1.ptr->class == ARRAY || $3.ptr->class == ARRAY)
                         {
                              semantic_error("\">=\" can't be applied to arrays");
                         }
                         $$.true_list = create_list(code->nextquad);
                         $$.false_list = create_list(code->nextquad+1);
                         gen_quad_goto(code, K_IFGE, $1.ptr, $3.ptr, -1, (__uint32_t[]){$1.by_address, $3.by_address});
                         gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){$1.by_address, $3.by_address});
                    }

expression : logical_expression
          {
               $$.ptr = $1.ptr;
               $$.by_address = $1.by_address;
          }
          | expression AND_OP M logical_expression
          { 
               if(logical_expression_flag == 0)
               {
                    semantic_error("\"&&\" can only be applied to logical expressions");
               }
               complete_list($1.true_list, $3.quad);
               $$.true_list = $4.true_list;
               $$.false_list = concat_list($1.false_list, $4.false_list);
          }
          | expression OR_OP M logical_expression
          {
               if(logical_expression_flag == 0)
               {
                    semantic_error("\"||\" can only be applied to logical expressions");
               }
               complete_list($1.false_list, $3.quad);
               $$.false_list = $4.false_list;
               $$.true_list = concat_list($1.true_list, $4.true_list);
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

// Prend en paramètre la variable dont il faut calculer l'addresse et une reference vers la variable qui contient l'indice
// Renvoi une variable temporaire contenant l'adresse de la variable
SymbolTableElement *generate_address_quads(SymbolTableElement *id, SymbolTableElement *add1, SymbolTableElement *add2)
{
     SymbolTableElement *four = lookup_constant(symbol_table, (Constant){.int_value = 4}, INT);
     SymbolTableElement *fp = lookup_variable(symbol_table, "$fp", current_scope, VARIABLE, 0);
     SymbolTableElement *add = insert_constant(&symbol_table, (Constant){.int_value = id->attribute.array.adress, .float_value = (float)id->attribute.array.adress}, INT);
     SymbolTableElement *t = newtemp(symbol_table, VARIABLE, INT, adress, (__uint32_t[]) {0, 0});
     
     // 2 dimensions
     if(add2 != NULL)
     {
          SymbolTableElement *size = insert_constant(&symbol_table, (Constant){.int_value = id->attribute.array.size[0], .float_value = (float)id->attribute.array.size[0]}, INT);
          SymbolTableElement *s = newtemp(symbol_table, VARIABLE, INT, adress, (__uint32_t[]) {0, 0});
          adress++;
          gen_quad(code, BOP_MULT, s, size, add1, (__uint32_t[]){0, 0, 0});
          gen_quad(code, BOP_PLUS, s, s, add2, (__uint32_t[]){0, 0, 0});

          gen_quad(code, BOP_PLUS, t, add, s, (__uint32_t[]){0, 0, 0});
          gen_quad(code, BOP_MULT, t, t, four, (__uint32_t[]){0, 0, 0});
          gen_quad(code, BOP_PLUS, t, t, fp, (__uint32_t[]){0, 0, 0});
     }
     // 1 dimension
     else
     {
          gen_quad(code, BOP_PLUS, t, add, add1, (__uint32_t[]){0, 0, 0});
          gen_quad(code, BOP_MULT, t, t, four, (__uint32_t[]){0, 0, 0});
          gen_quad(code, BOP_PLUS, t, t, fp, (__uint32_t[]){0, 0, 0});
     }
     return t;
}

SymbolTableElement *matrix_operation(SymbolTableElement *a1, SymbolTableElement *a2, __uint32_t op)
{
     __uint32_t size = a2->attribute.array.size[1];
     if(size == 0)
          size++;

     SymbolTableElement *r = newtemp(symbol_table, ARRAY, MATRIX, adress, (__uint32_t[]){a2->attribute.array.size[0], a2->attribute.array.size[1]});
     adress += a2->attribute.array.size[0]*size;

     for(int i=0;i<a2->attribute.array.size[0];i++)
     {
          for(int j=0;j<size;j++)
          {
               SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
               SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
               SymbolTableElement *e1, *e2, *e3;

               if(size == 1)
               {
                    e1 = generate_address_quads(r, add1, NULL);
                    adress++;
                    e2 = generate_address_quads(a1, add1, NULL);
                    adress++;
                    e3 = generate_address_quads(a2, add1, NULL);
               }
               else
               {
                    e1 = generate_address_quads(r, add1, add2);
                    adress++;
                    e2 = generate_address_quads(a1, add1, add2);
                    adress++;
                    e3 = generate_address_quads(a2, add1, add2);
               }

               switch(op)
               {
                    case '+':
                         gen_quad(code, BOP_PLUS, e1, e2, e3, (__uint32_t[]){FLOAT, FLOAT, FLOAT});
                    break;
                    case '-':
                         gen_quad(code, BOP_MINUS, e1, e2, e3, (__uint32_t[]){FLOAT, FLOAT, FLOAT});
                    break;
               }
                              
               
               adress-=2;
          }
     }
     return r;
}

SymbolTableElement *matrix_operation_constant(SymbolTableElement *a1, SymbolTableElement *a2, __uint32_t op)
{
     SymbolTableElement *constant;
     SymbolTableElement *array;
     if(a1->class == CONSTANT)
     {
          constant = a1;
          array = a2;
     }
     else
     {
          constant = a2;
          array = a1;
     }
     
     __uint32_t size = array->attribute.array.size[1];
     if(size == 0)
          size++;

     // varaiable temporaire pour le resultat
     SymbolTableElement *r = newtemp(symbol_table, ARRAY, MATRIX, adress, (__uint32_t[]){array->attribute.array.size[0], array->attribute.array.size[1]});
     adress += array->attribute.array.size[0]*size;

     for(int i=0;i<array->attribute.array.size[0];i++)
     {
          for(int j=0;j<size;j++)
          {
               SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
               SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
               SymbolTableElement *e1, *e2;

               if(size == 1)
               {
                    e1 = generate_address_quads(r, add1, NULL);
                    adress++;
                    e2 = generate_address_quads(array, add1, NULL);
               }
               else
               {
                    e1 = generate_address_quads(r, add1, add2);
                    adress++;
                    e2 = generate_address_quads(array, add1, add2);
               }

               switch(op)
               {
                    case '+':
                         gen_quad(code, BOP_PLUS, e1, e2, constant, (__uint32_t[]){FLOAT, FLOAT, 0});
                    break;
                    case '-':
                         gen_quad(code, BOP_MINUS, e1, e2, constant, (__uint32_t[]){FLOAT, FLOAT, 0});
                    break;
               }
               
               adress-=2;
          }
     }
     return r;
}
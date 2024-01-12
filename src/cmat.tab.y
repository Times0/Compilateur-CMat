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
__uint32_t function_adress = 0;         // donne le numero de parametre
__uint32_t logical_expression_flag = 0; // permet d'indiquer si on se situe dans une expression logique
__uint32_t logical_id_flag = 0;

uint32_t get_float_type(uint32_t type1, uint32_t type2);
SymbolTableElement *generate_address_quads(SymbolTableElement *id, SymbolTableElement *add, SymbolTableElement *add2);
SymbolTableElement *matrix_operation_add(SymbolTableElement *a1, SymbolTableElement *a2, __uint32_t op);
SymbolTableElement *matrix_operation_mult(SymbolTableElement *a1, SymbolTableElement *a2, __uint32_t op);
SymbolTableElement *matrix_binary_operation_constant(SymbolTableElement *a1, SymbolTableElement *a2, __uint32_t op);
SymbolTableElement *matrix_unary_operation_constant(SymbolTableElement *a1, __uint32_t op);
SymbolTableElement *matrix_slice(SymbolTableElement **ptr_list1, SymbolTableElement **ptr_list2, __uint32_t size_ptr_list1, __uint32_t size_ptr_list2, SymbolTableElement *mat);
void complete_matrix_slice(__uint32_t asize, SymbolTableElement ***ptr_list, __uint32_t *size_ptr_list);
void semantic_error(const char *format, ...);
void semantic_warning(const char *format, ...);
void open_scope();
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

     struct{
          size_t size;
          char *elements[100];
          int sum;
     }list_ids;
}

%token <int_val> INT_CONST
%token <float_val> FLOAT_CONST
%token <type_val> INT FLOAT MATRIX VOID
%token <string_val> STRING
%token <str_val>ID
%token <int_val> GT_OP GE_OP LT_OP LE_OP EQ_OP NEQ_OP


%token ';' '*' '/' '^' '(' ')'
%token '+' '-' 
// useless
%token IF ELSE WHILE FOR UNARY_OP DDOT
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
%type <expr> declaration_affectation_matrix
%type <expr> declaration_matrix_constant_list
%type <expr> declaration_element
%type <expr> declaration_list
%type <expr> declaration_parameter
%type <expr> declaration_parameter_list
%type <expr> call
%type <expr> assign
%type <expr> declaration
%type <expr> declaration_or_assign
%type <expr> additive_expression_list
%type <int_val> declaration_array
%type <expr> slice_array
%type <expr> expression_slice
%type <expr> expression_slice_list
%type <type_val> type
%type <type_val> type_function
%type <expr> M
%type <expr> N

%start start
%%
start: instruction_list
     | %empty

instruction_list: instruction_list M instruction   { complete_list($1.next_list, $2.quad); $$.next_list = $3.next_list; }
                | instruction                      { $$.next_list = $1.next_list; }


instruction : declaration ';'           { $$.next_list = create_list(-1);}      // declaration variable
            | declaration_function
            | assign ';'                { $$.next_list = create_list(-1);}
            | expression ';'            { $$.next_list = create_list(-1);}
            | statement
            | return ';'                { $$.next_list = create_list(-1);}

M : %empty { $$.quad = code->nextquad; }

N : %empty { $$.next_list = create_list(code->nextquad); gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){0, 0}); $$.quad = code->nextquad; }

statement : statement_if
          | statement_while
          | statement_for

statement_if : IF {open_scope();} '(' {logical_expression_flag++; logical_id_flag=1;} expression ')' {logical_expression_flag--; logical_id_flag=0;} M block statement_else
             {
                    // si pas de else
                    if($10.next_list == NULL)
                    {
                         complete_list($5.true_list, $8.quad);
                         $$.next_list = concat_list($5.false_list, $9.next_list);
                         $$.next_list = concat_list($$.next_list, create_list(code->nextquad));
                         gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){0, 0});
                    }
                    else
                    {
                         complete_list($5.true_list, $8.quad);
                         complete_list($5.false_list, $10.quad);

                         $$.next_list = concat_list($9.next_list, $10.next_list);
                         
                         // $$.next_list = concat_list($$.next_list, create_list(code->nextquad));
                         // gen_quad_goto(code, K_GOTO, NULL, NULL, -1, (__uint32_t[]){0, 0});
                    }
             }

statement_else : ELSE N statement_if
               {
                    $$.next_list = concat_list($2.next_list, $3.next_list);
                    $$.quad = $2.quad;
               }
               | ELSE {open_scope();} N block
               {
                    $$.next_list = concat_list($3.next_list, $4.next_list);
                    $$.quad = $3.quad;
               }
               | %empty
               {
                    $$.next_list = NULL;
               }

statement_while : WHILE {open_scope();} M '(' {logical_expression_flag++; logical_id_flag++;} expression ')' {logical_expression_flag--; logical_id_flag=0;} M block
                {
                    complete_list($6.true_list, $9.quad);
                    gen_quad_goto(code, K_GOTO, NULL, NULL, $3.quad, (__uint32_t[]){0, 0});
                    
                    // on ajoute un label pour le while, on regenere un label (meme si inutile) pour faciliter le free 
                    code->quads[$3.quad].label = $3.quad;

                    complete_list($10.next_list, $3.quad);
                    $$.next_list = $6.false_list;   
                }

statement_for : FOR {open_scope();} M '(' declaration_or_assign ';' {logical_expression_flag=1; logical_id_flag=1;} expression {logical_expression_flag=0; logical_id_flag=0;} ';' M assign_or_expression ')' M block
               {                   
                    gen_quad_goto(code, K_GOTO, NULL, NULL, $3.quad+1, (__uint32_t[]){0, 0, 0});  // +1 pour l'initialisation

                    Quad *q = malloc(sizeof(Quad)*($14.quad-$11.quad));
                    if(q == NULL)
                    {
                         printf("malloc failed in for\n");
                         exit(1);
                    }

                    // on copie les quads du ++
                    for(int i = $11.quad; i < $14.quad; i++)
                    {
                         q[i-$11.quad] = code->quads[i];
                    }
                    // on decale les quads juste apres la condition                     
                    for(int i = $14.quad; i < code->nextquad-1; i++)
                    {
                         code->quads[i-$14.quad+$11.quad] = code->quads[i];
                    }
                    // on reecrit les quads du ++ apres le block et avant le goto de la boucle
                    for(int i = code->nextquad-1+$11.quad-$14.quad; i < code->nextquad-1; i++)
                    {
                         code->quads[i] = q[i-code->nextquad+1-$11.quad+$14.quad];
                    }
                    free(q);

                    complete_list($8.true_list, $14.quad-1); // pas sur
                    // on ajoute un label pour le for, on regenere un label (meme si inutile) pour faciliter le free 
                    code->quads[$3.quad+1].label = $3.quad+1;

                    complete_list($15.next_list, $3.quad);
                    $$.next_list = $8.false_list;
               }

declaration_or_assign : declaration
                      | assign

declaration_function : type ID 
                     {
                         if(current_scope != 0)
                              semantic_error("can't declare function inside a block");
                         open_scope();
                     } 
                     '(' declaration_parameter_list ')' M
                     {
                         // doit etre ici pour mettre la recursivité
                         SymbolTableElement *fun = lookup_function(symbol_table, "main");
                         if(fun != NULL)
                         {
                              semantic_error("function is already declared");
                         }

                         fun = insert_function(&symbol_table, $2, $1, $5.size_ptr_list, $5.ptr_list, $7.quad, current_scope);

                         gen_quad_function(code, K_BEGIN_FUNCTION, NULL, fun, $5.ptr_list, $5.size_ptr_list, $5.by_address_list, 0);
                         function_adress=0;
                     } 
                     block
                     {
                         SymbolTableElement *fun = lookup_function(symbol_table, "main");
                         if(!strcmp($2, "main"))
                         {
                              if(fun->type != INT)
                              {
                                   semantic_error("main should have int type");
                              }
                              if($5.size_ptr_list != 0)
                              {
                                   semantic_error("main should have 0 parameter");
                              }

                              code->mainquad = $7.quad;
                         }
                         code->quads[$7.quad].label = $7.quad;

                         // permet de savoir que l'on fini une fonction 
                         // pas pour main
                         if(strcmp($2, "main"))
                              gen_quad_function(code, K_END_FUNCTION, NULL, NULL, NULL, 0, NULL, 0);

                         $$.ptr = NULL;
                     }
return : RETURN expression
       {
          gen_quad_function(code, K_RETURN, $2.ptr, NULL, NULL, 0, NULL, 0);
          code->quads[code->nextquad-1].by_adress[0] = $2.by_address;
       }

// redondance de code  + a faire
declaration_parameter : type ID
                      {
                         SymbolTableElement *l = lookup_variable(symbol_table, $2, current_scope, VARIABLE, 1);
                         if(l != NULL)
                         {
                              semantic_error("variable \"%s\" already declared in this scope", $2);
                         }

                         $$.ptr = insert_variable(symbol_table, $2, $1, VARIABLE, (__uint32_t[]){1, 1}, -(function_adress+1), current_scope);
                         
                         // les parametres ne sont pas des variables locales
                         get_symbol_table_by_scope(symbol_table, current_scope)->nb_variable--;
                         function_adress++;

                      }
                      | type ID declaration_array
                      | type ID declaration_array declaration_array

declaration_parameter_list : declaration_parameter
                           {
                                   $$.capacity_ptr_list = 1;
                                   $$.ptr_list = malloc($$.capacity_ptr_list*sizeof(SymbolTableElement*));
                                   if($$.ptr_list == NULL)
                                   {
                                        printf("Error malloc in declaration_parameter_list\n");
                                        exit(1);
                                   }
                                   $$.ptr_list[0] = $1.ptr;
                                   $$.size_ptr_list = 1;          
                           }
                           | declaration_parameter_list ',' declaration_parameter
                           {
                              if($1.size_ptr_list + 1 >= $1.capacity_ptr_list)
                              {
                                   $$.capacity_ptr_list = $1.capacity_ptr_list*2;
                                   $$.ptr_list = realloc($1.ptr_list, $$.capacity_ptr_list*sizeof(SymbolTableElement*));
                                   if($$.ptr_list == NULL)
                                   {
                                        printf("Error realloc in declaration_list\n");
                                        exit(1);
                                   }
                              }
                              else
                              {
                                   $$.capacity_ptr_list = $1.capacity_ptr_list;
                                   $$.ptr_list = $1.ptr_list;
                              }
                              $$.ptr_list[$1.size_ptr_list] = $3.ptr;
                              $$.size_ptr_list = $1.size_ptr_list+1;

                              free($3.ptr_list);
                           }
                           | %empty
                           {
                              $$.size_ptr_list = 0;
                           }

declaration_element : ID declaration_affectation
                    {  
                         SymbolTableElement *l = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 1);
                         if(l != NULL)
                         {
                              semantic_error("variable \"%s\" already declared in this scope", $2);
                         }

                         // on met un type arbitraire quil faut changer apres
                         if(current_scope == 0)
                         {
                              // $$.ptr = insert_variable(symbol_table, $1, INT, VARIABLE, (__uint32_t[]){1, 1}, -1, current_scope);
                              semantic_error("global variables not allowed");
                         }
                         else
                         {
                              $$.ptr = insert_variable(symbol_table, $1, INT, VARIABLE, (__uint32_t[]){1, 1}, adress, current_scope);
                              adress++;
                         }
                    
                         // set a la valeur par initiale
                         if($2.ptr != NULL)
                         {
                              if($2.ptr->class != ARRAY)
                                   gen_quad(code, K_COPY, lookup_variable(symbol_table, $1, current_scope, VARIABLE, 0), $2.ptr, NULL, (__uint32_t[]){0, $2.by_address, 0});
                              else
                              {
                                   //affectation d'une matrice 1*1 à une variable
                                   // verification de la taille faite a letape precedente
                                   SymbolTableElement *zero = insert_constant(&symbol_table, (Constant){.int_value = 0, .float_value = (float)0}, INT);
                                   gen_quad(code, K_COPY, $$.ptr, generate_address_quads($2.ptr, zero, zero), NULL, (__uint32_t[]){0, FLOAT, 0});
                              }
                         }

                         $$.ptr->attribute.array.size[0] = 0;
                    }
                    | ID declaration_array declaration_affectation_matrix
                    {
                         SymbolTableElement *l = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 1);
                         if(l != NULL)
                         {
                              semantic_error("variable \"%s\" already declared in this scope", $1);
                         }

                         if(current_scope == 0)
                              // type arbitraire, on le change apres
                              // $$.ptr = insert_variable(symbol_table, $1, INT, ARRAY, (__uint32_t[]){$2, 1}, -1, current_scope);
                              semantic_error("global variables not allowed");
                         else
                         {
                              $$.ptr = insert_variable(symbol_table, $1, INT, ARRAY, (__uint32_t[]){$2, 1}, adress, current_scope);
                              adress += $2*1;
                         }  

                         // set a la valeur par initiale
                         if($3.ptr_list != NULL)
                         {
                              if($$.ptr->attribute.array.size[0] != $3.size_ptr_list)
                              {
                                   semantic_error("sizes not consistent");
                              }
                              
                              for(int i=0; i<$3.size_ptr_list;i++)
                              {
                                   SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
                                   SymbolTableElement *zero = insert_constant(&symbol_table, (Constant){.int_value = 0, .float_value = (float)0} ,INT);
                                   SymbolTableElement *e1;

                                   e1 = generate_address_quads($$.ptr, add1, zero);
                              
                                   gen_quad(code, K_COPY, e1, $3.ptr_list[i], NULL, (__uint32_t[]){FLOAT, $3.by_address_list[i], 0});
                              }
                              free($3.ptr_list);
                              free($3.by_address_list);
                         }
                         
                    }
                    | ID declaration_array declaration_array declaration_affectation_matrix
                    {
                         SymbolTableElement *l = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 1);
                         if(l != NULL)
                         {
                              semantic_error("variable \"%s\" already declared in this scope", $1);
                         }

                         if(current_scope == 0)
                              // type arbitraire, on le change apres
                              // $$.ptr = insert_variable(symbol_table, $1, INT, ARRAY, (__uint32_t[]){$2, $3}, -1, current_scope);
                              semantic_error("global variables not allowed");
                         else
                         {
                              $$.ptr = insert_variable(symbol_table, $1, INT, ARRAY, (__uint32_t[]){$2, $3}, adress, current_scope);
                              adress += $2*$3;
                         }  

                         // set a la valeur par initiale
                         if($4.ptr_list != NULL)
                         {
                              if($$.ptr->attribute.array.size[0] != $4.size[0] || $$.ptr->attribute.array.size[1] != $4.size[1])
                              {
                                   semantic_error("sizes not consistent");
                              }
                              
                              for(int i=0; i<$4.size[0];i++)
                              {
                                   for(int j=0; j<$4.size[1];j++)
                                   {
                                        SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
                                        SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
                                        SymbolTableElement *e1;

                                        e1 = generate_address_quads($$.ptr, add1, add2);
                              
                                        gen_quad(code, K_COPY, e1, $4.ptr_list[i*$4.size[1]+j], NULL, (__uint32_t[]){FLOAT, $4.by_address_list[i*$4.size[1]+j], 0});
                                   }
                              }
                              free($4.ptr_list);
                              free($4.by_address_list);
                         }
                         else if($4.ptr != NULL) // affectation a une variable simple
                         {
                              if($4.ptr->type == MATRIX)
                              {
                                   if($$.ptr->attribute.array.size[0] != $4.ptr->attribute.array.size[0] || $$.ptr->attribute.array.size[1] != $4.ptr->attribute.array.size[1])
                                        semantic_error("arrays size must be consistent for affectation");

                                   // on ne stocke pas les variables temporaires contenat les adresses
                                   for(int i=0;i<$4.ptr->attribute.array.size[0];i++)
                                   {
                                        for(int j=0;j<$4.ptr->attribute.array.size[1];j++)
                                        {
                                             SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
                                             SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
                                             SymbolTableElement *e1, *e2;

                                             e1 = generate_address_quads($$.ptr, add1, add2);
                                             adress++;
                                             e2 = generate_address_quads($4.ptr, add1, add2);
                              
                                             gen_quad(code, K_COPY, e1, e2, NULL, (__uint32_t[]){FLOAT, FLOAT, 0});
                                             adress--;
                                        }
                                   }
                              }
                         }
                    }

declaration_list : declaration_element
                 {
                    $$.capacity_ptr_list = 1;
                    $$.ptr_list = malloc($$.capacity_ptr_list*sizeof(SymbolTableElement *));
                    if($$.ptr_list == NULL)
                    {
                         printf("Error malloc in declaration_list\n");
                         exit(1);
                    }
                    $$.ptr_list[0] = $1.ptr;
                    $$.size_ptr_list = 1;
                 }
                 | declaration_list ',' declaration_element
                 {
                    if($1.size_ptr_list + 1 >= $1.capacity_ptr_list)
                    {
                         $$.capacity_ptr_list = $1.capacity_ptr_list*2;
                         $$.ptr_list = realloc($1.ptr_list, $$.capacity_ptr_list*sizeof(SymbolTableElement*));
                         if($$.ptr_list == NULL)
                         {
                              printf("Error realloc in declaration_list\n");
                              exit(1);
                         }
                    }
                    else
                    {
                         $$.capacity_ptr_list = $1.capacity_ptr_list;
                         $$.ptr_list = $1.ptr_list;
                    }
                    $$.ptr_list[$1.size_ptr_list] = $3.ptr;
                    $$.size_ptr_list = $1.size_ptr_list+1;

                    free($3.ptr_list);
                 }

declaration :  type declaration_list
               {
                    for(int i=0;i<$2.size_ptr_list;i++)
                    {
                         if($1 == MATRIX)
                         {
                              if($2.ptr_list[i]->attribute.array.size[0] == 0)
                              {
                                   semantic_error("cannot declare matrix without bounds");
                              }
                         }
                         // changement de type
                         $2.ptr_list[i]->type = $1;
                    }

                    free($2.ptr_list);
               }

declaration_array : '[' INT_CONST ']'   { $$ = $2; if($$ == 0){semantic_error("can't declare a matrix with 0 as dimension");}}
assign_or_expression : expression
                     | assign
slice_array : '[' expression_slice_list ']'
            {
               $$.ptr_list = $2.ptr_list;
               $$.size_ptr_list = $2.size_ptr_list;
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
                 {
                    // on met NULL qu'on remplace plus tard
                    $$.ptr_list = malloc(sizeof(SymbolTableElement *));
                    if($$.ptr_list == NULL)
                    {
                         printf("Error malloc in expression_slice\n");
                         exit(1);
                    }
                    $$.ptr_list[0] = NULL;
                    $$.size_ptr_list = 1;
                 }

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
                              $$.by_address = $2.by_address;

                              if($2.ptr->class == ARRAY)
                              {
                                   if($2.ptr->attribute.array.size[0] != 1 || $2.ptr->attribute.array.size[1] != 1)
                                        semantic_error("can't affect array to variable");
                              }
                        }
                        | %empty{$$.ptr = NULL;}

declaration_affectation_matrix : '=' '{' declaration_matrix_constant_list '}' {$$.ptr_list = $3.ptr_list; $$.by_address_list = $3.by_address_list; $$.size_ptr_list = $3.size_ptr_list; $$.size[0] = $3.size[0]; $$.size[1] = $3.size[1];}
                               | '=' additive_expression {$$.ptr = $2.ptr; $$.by_address = $2.by_address;}
                               | %empty {$$.ptr = NULL;}

declaration_matrix_constant_list : additive_expression_list
                                 {
                                        $$.ptr_list = $1.ptr_list;
                                        $$.by_address_list = $1.by_address_list;
                                        $$.size_ptr_list = $1.size_ptr_list;
                                 }
                                 | '{' additive_expression_list '}'
                                 {
                                        $$.ptr_list = $2.ptr_list;
                                        $$.by_address_list = $2.by_address_list;
                                        $$.size_ptr_list = $2.size_ptr_list;
                                        $$.size[0] = 1;                    // ligne
                                        $$.size[1] = $2.size_ptr_list;     // colonne
                                 }
                                 | '{' additive_expression_list '}' ',' declaration_matrix_constant_list
                                 {
                                        if($2.size_ptr_list != $5.size[1])
                                             semantic_error("sizes not consistent");
                                        $$.size[1] = $5.size[1];
                                        $$.size[0] = $5.size[0]+1;

                                        $$.size_ptr_list = $2.size_ptr_list + $5.size_ptr_list;

                                        $$.ptr_list = malloc(($$.size_ptr_list)*sizeof(SymbolTableElement*));
                                        $$.by_address_list = malloc(($$.size_ptr_list)*sizeof(__uint32_t));
                                        if($$.ptr_list == NULL || $$.by_address_list == NULL)
                                        {
                                             printf("Error malloc in declaration_matrix_constant_list\n");
                                             exit(1);
                                        }

                                        for(int i=0;i<$2.size_ptr_list;i++)
                                        {
                                             $$.ptr_list[i] = $2.ptr_list[i];
                                             $$.by_address_list[i] = $2.by_address_list[i];
                                        }
                                        for(int i=0;i<$5.size_ptr_list;i++)
                                        {
                                             $$.ptr_list[$2.size_ptr_list+i] = $5.ptr_list[i];
                                             $$.by_address_list[$2.size_ptr_list+i] = $5.by_address_list[i];
                                        }

                                        free($2.ptr_list);
                                        free($2.by_address_list);
                                        free($5.ptr_list);
                                        free($5.by_address_list);
                                 }


additive_expression_list : additive_expression
                         {
                              $$.capacity_ptr_list = 1;
                              $$.ptr_list = malloc($$.capacity_ptr_list*sizeof(SymbolTableElement*));
                              $$.by_address_list = malloc($$.capacity_ptr_list*sizeof(__uint32_t));
                              if($$.ptr_list == NULL || $$.by_address_list == NULL)
                              {
                                   printf("Error malloc in declaration_list\n");
                                   exit(1);
                              }
                              $$.ptr_list[0] = $1.ptr;
                              $$.by_address_list[0] = $1.by_address;
                              $$.size_ptr_list = 1;
                         }
                         | additive_expression_list ',' additive_expression
                         {
                              if($1.size_ptr_list + 1 >= $1.capacity_ptr_list)
                              {
                                   $$.capacity_ptr_list = $1.capacity_ptr_list*2;
                                   $$.ptr_list = realloc($1.ptr_list, $$.capacity_ptr_list*sizeof(SymbolTableElement*));
                                   $$.by_address_list = realloc($1.by_address_list, $$.capacity_ptr_list*sizeof(__uint32_t));
                                   if($$.ptr_list == NULL || $$.by_address_list == NULL)
                                   {
                                        printf("Error realloc in declaration_list\n");
                                        exit(1);
                                   }
                              }
                              else
                              {
                                   $$.capacity_ptr_list = $1.capacity_ptr_list;
                                   $$.ptr_list = $1.ptr_list;
                                   $$.by_address_list = $1.by_address_list;
                              }
                              $$.ptr_list[$1.size_ptr_list] = $3.ptr;
                              $$.by_address_list[$1.size_ptr_list] = $3.by_address;
                              $$.size_ptr_list = $1.size_ptr_list+1;

                              free($3.ptr_list);
                         }

type : INT     {$$ = $1;}
     | FLOAT   {$$ = $1;}
     | MATRIX  {$$ = $1;}

/* type_function : type {$$ = $1;} */
              /* | VOID {$$ = $1;} */

// faire result et cant call main
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
               gen_quad_function(code, K_CALL_PRINT, NULL, id, $3.ptr_list, $3.size_ptr_list, $3.by_address_list, 0);
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
               gen_quad_function(code, K_CALL_PRINTF, NULL, id, $3.ptr_list, $3.size_ptr_list, $3.by_address_list, 0);
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
                         gen_quad_function(code, K_CALL_PRINT, NULL, print, list, 1, by_address_list, 0);
                         
                         // \t
                         gen_quad_function(code, K_CALL_PRINTF, NULL, printff, (SymbolTableElement **){t}, 1, (__uint32_t[]){0}, 0);
                    }
                    // \n
                    gen_quad_function(code, K_CALL_PRINTF, NULL, printff, (SymbolTableElement **){n}, 1, (__uint32_t[]){0}, 0);
               }
               adress-=2;
          }
          else
          {
               if(id == NULL)
               {
                    semantic_error("function \"%s\" not declared", $1);
               }

               if(id->attribute.function.nb_parameters != $3.size_ptr_list)
               {
                    semantic_error("number of parameters not matching");
               }

               for(int i=0;i<$3.size_ptr_list;i++)
               {
                    // verification de la validité des parametres
                    if(id->attribute.function.parameters[i]->class != $3.ptr_list[i]->class)
                    {
                         // on peut avoir des constante dans l'appel
                         if(!((id->attribute.function.parameters[i]->class == CONSTANT && $3.ptr_list[i]->class == VARIABLE) || (id->attribute.function.parameters[i]->class == VARIABLE && $3.ptr_list[i]->class == CONSTANT)))
                              semantic_error("parameter %d not matching", i);
                    }
                    if(id->attribute.function.parameters[i]->type != $3.ptr_list[i]->type)
                    {
                         semantic_error("parameter %d type not matching", i);
                    }
                    // gen_quad(code, K_COPY, id->attribute.function.parameters[i], $3.ptr_list[i], NULL, (__uint32_t[3]){0, 0, 0});
               }

               if(id->type != VOID)
               {
                    $$.ptr = newtemp(symbol_table, VARIABLE, id->type, adress, (__uint32_t[2]){0, 0});
                    gen_quad_function(code, K_CALL, $$.ptr, id, $3.ptr_list, $3.size_ptr_list, $3.by_address_list, get_symbol_table_by_scope(symbol_table, current_scope)->nb_variable);
                    adress++;
               }
               else
                    gen_quad_function(code, K_CALL, NULL, id, $3.ptr_list, $3.size_ptr_list, $3.by_address_list, get_symbol_table_by_scope(symbol_table, current_scope)->nb_variable);

          }
     }

parameter : expression
          {
               $$.ptr = $1.ptr;
               $$.by_address = $1.by_address;
          }
          | STRING
          {
               $$.ptr = insert_string(symbol_table, $1, adress);
               // on ne modifie pas adress car on ne stocke pas les strings dans la pile
          }

parameter_list : parameter_list ',' parameter
               {
                    if($1.size_ptr_list + 1 >= $1.capacity_ptr_list)
                    {
                         $$.capacity_ptr_list = $1.capacity_ptr_list*2;
                         $$.ptr_list = realloc($1.ptr_list, $$.capacity_ptr_list*sizeof(SymbolTableElement*));
                         $$.by_address_list = realloc($1.by_address_list, $$.capacity_ptr_list*sizeof(__uint32_t));
                         if($$.ptr_list == NULL || $$.by_address_list == NULL)
                         {
                              printf("Error realloc in parameter_list\n");
                              exit(1);
                         }
                    }
                    else
                    {
                         $$.capacity_ptr_list = $1.capacity_ptr_list;
                         $$.ptr_list = $1.ptr_list;
                         $$.by_address_list = $1.by_address_list;
                    }
                    $$.ptr_list[$1.size_ptr_list] = $3.ptr;
                    $$.by_address_list[$1.size_ptr_list] = $3.by_address;
                    $$.size_ptr_list = $1.size_ptr_list+1;
               }
               | parameter
               {     
                    $$.capacity_ptr_list = 1;
                    $$.ptr_list = malloc($$.capacity_ptr_list*sizeof(SymbolTableElement *));
                    $$.by_address_list = malloc($$.capacity_ptr_list*sizeof(__uint32_t));
                    if($$.ptr_list == NULL || $$.by_address_list == NULL)
                    {
                         printf("Error malloc in parameter_list\n");
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
               {
                    gen_quad(code, K_COPY, $$.ptr, $3.ptr, NULL, (__uint32_t[]){0, $3.by_address, 0});
               }
               else if($$.ptr->class == VARIABLE && $3.ptr->class == ARRAY)
               {
                    // copie matrice 1*1 dans une variable
                    if($3.ptr->attribute.array.size[0] == 1 && $3.ptr->attribute.array.size[1] == 1)
                    {
                         SymbolTableElement *zero = insert_constant(&symbol_table, (Constant){.int_value = 0, .float_value = (float)0}, INT);
                         gen_quad(code, K_COPY, $$.ptr, generate_address_quads($3.ptr, zero, zero), NULL, (__uint32_t[]){0, FLOAT, 0});    
                    }
                    else
                    {
                         semantic_error("can't affect array to variable");
                    }
               }
               else if($$.ptr->type == MATRIX && $3.ptr->type == MATRIX) // copie de matrice
               {    
                    if($$.ptr->attribute.array.size[0] != $3.ptr->attribute.array.size[0] || $$.ptr->attribute.array.size[1] != $3.ptr->attribute.array.size[1])
                         semantic_error("arrays size must be consistent for affectation");

                    // on ne stocke pas les variables temporaires contenat les adresses
                    for(int i=0;i<$3.ptr->attribute.array.size[0];i++)
                    {
                         for(int j=0;j<$3.ptr->attribute.array.size[1];j++)
                         {
                              SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
                              SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
                              SymbolTableElement *e1, *e2;

                              e1 = generate_address_quads($$.ptr, add1, add2);
                              adress++;
                              e2 = generate_address_quads($3.ptr, add1, add2);
                              
                              gen_quad(code, K_COPY, e1, e2, NULL, (__uint32_t[]){FLOAT, FLOAT, 0});
                              adress--;
                         }
                    }
               }
               else if($$.ptr->class == ARRAY && $3.ptr->class == VARIABLE)
               {
                    semantic_error("can't affect a variable to an array");
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
               if($2.size_ptr_list != 1)
               {
                    semantic_error("invalid slice");
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
               if($2.size_ptr_list != 1 || $3.size_ptr_list != 1)
               {
                    semantic_error("invalid slice");
               }

               SymbolTableElement *t = generate_address_quads(e, $2.ptr_list[0], $3.ptr_list[0]);
               __uint32_t type = e->type;
               if(e->type == MATRIX)
                    type = FLOAT;
               gen_quad(code, K_COPY, t, $5.ptr, NULL, (__uint32_t[]){type, $5.by_address, 0});
               adress++;
          }

block : '{' instruction_list      
        '}'                   {
                                   $$.next_list = $2.next_list;
                                   complete_list($2.next_list, code->nextquad);
                                   
                                   adress -= get_symbol_table_by_scope(symbol_table, current_scope)->nb_variable;
                                   current_scope = get_symbol_table_by_scope(symbol_table, current_scope)->previous->scope; 
                              }
     | '{' '}' { $$.ptr = NULL; current_scope = get_symbol_table_by_scope(symbol_table, current_scope)->previous->scope; }
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

                              $$.ptr = matrix_operation_add($1.ptr, $3.ptr, '+');
                         }
                         else if(($1.ptr->type == MATRIX || $3.ptr->type == MATRIX) && ($1.ptr->class == VARIABLE || $3.ptr->class == VARIABLE || $1.ptr->class == CONSTANT || $3.ptr->class == CONSTANT))// matrices
                         {
                              $$.ptr = matrix_binary_operation_constant($1.ptr, $3.ptr, '+');
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
                         else if($1.ptr->type == MATRIX && $3.ptr->type == MATRIX)// matrices
                         {
                              if($1.ptr->attribute.array.size[0] != $3.ptr->attribute.array.size[0] || $1.ptr->attribute.array.size[1] != $3.ptr->attribute.array.size[1])
                              {
                                   semantic_error("matrices should have the same dimension for \"-\"");
                              }

                              $$.ptr = matrix_operation_add($1.ptr, $3.ptr, '-');
                         }
                         else if(($1.ptr->type == MATRIX || $3.ptr->type == MATRIX) && ($1.ptr->class == VARIABLE || $3.ptr->class == VARIABLE || $1.ptr->class == CONSTANT || $3.ptr->class == CONSTANT))// matrices
                         {
                              $$.ptr = matrix_binary_operation_constant($1.ptr, $3.ptr, '-');
                         }
                         else
                         {
                              semantic_error("operation not permitted on list use matrix instead");
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
                              else if($1.ptr->type == MATRIX && $3.ptr->type == MATRIX)
                              {
                                   if($1.ptr->attribute.array.size[1] != $3.ptr->attribute.array.size[0])
                                   {
                                        semantic_error("matrices should have compatible dimensions for \"*\"");
                                   }

                                   $$.ptr = matrix_operation_mult($1.ptr, $3.ptr, '*');
                              }
                              else if(($1.ptr->type == MATRIX || $3.ptr->type == MATRIX) && ($1.ptr->class == VARIABLE || $3.ptr->class == VARIABLE || $1.ptr->class == CONSTANT || $3.ptr->class == CONSTANT))// matrices
                              {
                                   $$.ptr = matrix_binary_operation_constant($1.ptr, $3.ptr, '*');
                              }
                              else
                              {
                                   semantic_error("operation not permitted on list use matrix instead");
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
                              else if($1.ptr->type == MATRIX && $3.ptr->type == MATRIX)
                              {
                                   if($1.ptr->attribute.array.size[1] != $3.ptr->attribute.array.size[0])
                                   {
                                        semantic_error("matrices should have compatible dimensions for \"/\"");
                                   }

                                   $$.ptr = matrix_operation_mult($1.ptr, $3.ptr, '/');
                              }
                              else if(($1.ptr->type == MATRIX || $3.ptr->type == MATRIX) && ($1.ptr->class == VARIABLE || $3.ptr->class == VARIABLE || $1.ptr->class == CONSTANT || $3.ptr->class == CONSTANT))// matrices
                              {
                                   $$.ptr = matrix_binary_operation_constant($1.ptr, $3.ptr, '/');
                              }
                              else
                              {
                                   semantic_error("operation not permitted on list use matrix instead");
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
                              else
                              {
                                   semantic_error("operation not permitted on list use matrix instead");
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
                         if(e->attribute.array.size[1] != 1)
                         {
                              semantic_error("variable \"%s\" have two dimensions", $1);
                         }

                         // si le slice est renvoie un element seul
                         if($2.size_ptr_list == 1 && $2.ptr_list[0] != NULL)
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
                         else
                         {
                              complete_matrix_slice(e->attribute.array.size[0], &$2.ptr_list, &$2.size_ptr_list);
                              $$.ptr = matrix_slice($2.ptr_list, NULL, $2.size_ptr_list, 0, e);
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
                         if(e->attribute.array.size[1] == 1)
                         {
                              semantic_error("variable \"%s\" have one dimension", $1);
                         }
                         // il faut verifier le cas simple a part car on renvoie une variable et non une matrice
                         if($2.size_ptr_list == 1 && $3.size_ptr_list == 1 && $2.ptr_list[0] != NULL && $3.ptr_list[0] != NULL)
                         {
                              if(e->type == MATRIX)
                              {
                                   SymbolTableElement *t = generate_address_quads(e, $2.ptr_list[0], $3.ptr_list[0]);
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
                         else
                         {
                              complete_matrix_slice(e->attribute.array.size[0], &$2.ptr_list, &$2.size_ptr_list);
                              complete_matrix_slice(e->attribute.array.size[1], &$3.ptr_list, &$3.size_ptr_list);
                              $$.ptr = matrix_slice($2.ptr_list, $3.ptr_list, $2.size_ptr_list, $3.size_ptr_list, e);
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
                         if(id->class != ARRAY)
                         {
                              Constant c;
                              c.int_value = 1;
                              c.float_value = (float)1;
                              SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);

                              gen_quad(code, BOP_PLUS, id, id, n1, (__uint32_t[]){0, 0, 0});
                              $$.by_address = 0;
                              $$.ptr = id;
                         }
                         else
                         {
                              $$.ptr = matrix_unary_operation_constant(id, INCR);
                              $$.by_address = 0;
                         }
                         
                    }
                    | INCR ID
                    {
                         SymbolTableElement *id = lookup_variable(symbol_table, $2, current_scope, VARIABLE, 0);
                         if(id == NULL)
                         {
                              semantic_error("variable \"%s\" not declared", $2);
                         }
                         if(id->class != ARRAY)
                         {
                              Constant c;
                              c.int_value = 1;
                              c.float_value = (float)1;
                              SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);
     
                              gen_quad(code, BOP_PLUS, id, id, n1, (__uint32_t[]){0, 0, 0});
                              $$.by_address = 0;
                              $$.ptr = id;
                         }
                         else
                         {
                              $$.ptr = matrix_unary_operation_constant(id, INCR);
                              $$.by_address = 0;
                         }
                    }
                    | ID DECR
                    {
                         SymbolTableElement *id = lookup_variable(symbol_table, $1, current_scope, VARIABLE, 0);
                         if(id == NULL)
                         {
                              semantic_error("variable \"%s\" not declared", $1);
                         }
                         if(id->class != ARRAY)
                         {
                              Constant c;
                              c.int_value = 1;
                              c.float_value = (float)1;
                              SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);

                              gen_quad(code, BOP_MINUS, id, id, n1, (__uint32_t[]){0, 0, 0});
                              $$.by_address = 0;
                              $$.ptr = id;
                         }
                         else
                         {
                              $$.ptr = matrix_unary_operation_constant(id, DECR);
                              $$.by_address = 0;
                         }
                    }
                    | DECR ID
                    {
                         SymbolTableElement *id = lookup_variable(symbol_table, $2, current_scope, VARIABLE, 0);
                         if(id == NULL)
                         {
                              semantic_error("variable \"%s\" not declared", $2);
                         }
                         if(id->class != ARRAY)
                         {
                              Constant c;
                              c.int_value = 1;
                              c.float_value = (float)1;
                              SymbolTableElement *n1 = insert_constant(&symbol_table, c, INT);

                              gen_quad(code, BOP_MINUS, id, id, n1, (__uint32_t[]){0, 0, 0});
                              $$.by_address = 0;
                              $$.ptr = id;
                         }
                         else
                         {
                              $$.ptr = matrix_unary_operation_constant(id, DECR);
                              $$.by_address = 0;
                         }
                    }
                    | '-' primary_expression %prec UNARY_OP
                    {
                         if($2.ptr->class != ARRAY)
                         {
                              $$.ptr = newtemp(symbol_table, VARIABLE, get_float_type($2.ptr->type, $2.by_address), adress, (__uint32_t[]){0, 0});
                              adress++;
                              gen_quad(code, UOP_MINUS, $$.ptr, $2.ptr, NULL, (__uint32_t[]){0, $2.by_address, 0});
                              $$.by_address = 0;
                         }
                         else
                         {
                              $$.ptr = matrix_unary_operation_constant($2.ptr, '-');
                              $$.by_address = 0;
                         }
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
                    | '~' primary_expression %prec UNARY_OP
                    {
                         if($2.ptr->class != ARRAY && $2.ptr->type != MATRIX)
                         {
                              semantic_error("\"~\" can only be applied on matrices");
                         }
                         $$.ptr = matrix_unary_operation_constant($2.ptr, '~');
                         $$.by_address = 0;
                    }
                    | '(' expression ')'
                    {
                         if(logical_expression_flag == 1)
                         {
                              $$.true_list = $2.true_list;
                              $$.false_list = $2.false_list;
                              logical_id_flag=0;
                         }
                         $$.ptr = $2.ptr;
                         $$.by_address = $2.by_address;
                    }
                    | call
                    {
                         $$.ptr = $1.ptr;
                         $$.by_address = 0;
                    }
                    

// priorité maximale
logical_expression  : additive_expression    // si on prend cette regle c'est qu'il n'y pas de comparaison et donc on a seulement une constante ou un id
                    {
                         $$.ptr = $1.ptr;
                         $$.by_address = $1.by_address;

                         if(logical_expression_flag == 1 && logical_id_flag)
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
                         else
                              logical_id_flag++;
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
          SymbolTableElement *size = insert_constant(&symbol_table, (Constant){.int_value = id->attribute.array.size[1], .float_value = (float)id->attribute.array.size[1]}, INT);
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

SymbolTableElement *matrix_operation_mult(SymbolTableElement *a1, SymbolTableElement *a2, __uint32_t op)
{
     SymbolTableElement *zero = insert_constant(&symbol_table, (Constant){.int_value = 0, .float_value = (float)0} ,INT);

     SymbolTableElement *r = newtemp(symbol_table, ARRAY, MATRIX, adress, (__uint32_t[]){a1->attribute.array.size[0], a2->attribute.array.size[1]});
     adress += a1->attribute.array.size[0]*a2->attribute.array.size[1];

     for(int i=0;i<a1->attribute.array.size[0];i++)
     {
          for(int j=0;j<a2->attribute.array.size[1];j++)
          {
               SymbolTableElement *sum = newtemp(symbol_table, VARIABLE, FLOAT, adress, (__uint32_t[]){0, 0});
               adress++;
               gen_quad(code, K_COPY, sum, zero, NULL, (__uint32_t[]){0, 0, 0});

               SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
               SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);

               for(int k=0;k<a1->attribute.array.size[1]; k++)
               {
                    SymbolTableElement *add3 = insert_constant(&symbol_table, (Constant){.int_value = k, .float_value = (float)k} ,INT);
                    SymbolTableElement *e2, *e3;

                    e2 = generate_address_quads(a1, add1, add3);
                    adress++;
                    e3 = generate_address_quads(a2, add3, add2);
                    adress++;

                    SymbolTableElement *t = newtemp(symbol_table, VARIABLE, FLOAT, adress, (__uint32_t[]){0, 0});
                    switch(op)
                    {
                         case '*':
                              gen_quad(code, BOP_MULT, t, e2, e3, (__uint32_t[]){0, FLOAT, FLOAT});
                         break;
                         case '/':
                              gen_quad(code, BOP_DIV, t, e2, e3, (__uint32_t[]){0, FLOAT, FLOAT});
                         break;
                    }
                    gen_quad(code, BOP_PLUS, sum, sum, t, (__uint32_t[]){0, 0, 0});

                    adress-=2;
               }
               // copie de la somme dans r
               gen_quad(code, K_COPY, generate_address_quads(r, add1, add2), sum, NULL, (__uint32_t[]){FLOAT, 0, 0});
          }
     }
     return r;
}

SymbolTableElement *matrix_operation_add(SymbolTableElement *a1, SymbolTableElement *a2, __uint32_t op)
{
     SymbolTableElement *r = newtemp(symbol_table, ARRAY, MATRIX, adress, (__uint32_t[]){a2->attribute.array.size[0], a2->attribute.array.size[1]});
     adress += a2->attribute.array.size[0]*a2->attribute.array.size[1];

     for(int i=0;i<a2->attribute.array.size[0];i++)
     {
          for(int j=0;j<a2->attribute.array.size[1];j++)
          {
               SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
               SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
               SymbolTableElement *e1, *e2, *e3;

               e1 = generate_address_quads(r, add1, add2);
               adress++;
               e2 = generate_address_quads(a1, add1, add2);
               adress++;
               e3 = generate_address_quads(a2, add1, add2);

               // la variable temporaire est évitable mais cela oblige a changer le mips.c à cause des libérations attives des registres
               SymbolTableElement *t = newtemp(symbol_table, VARIABLE, FLOAT, adress, (__uint32_t[]){0, 0});
               switch(op)
               {
                    case '+':
                         gen_quad(code, BOP_PLUS, t, e2, e3, (__uint32_t[]){0, FLOAT, FLOAT});
                    break;
                    case '-':
                         gen_quad(code, BOP_MINUS, t, e2, e3, (__uint32_t[]){0, FLOAT, FLOAT});
                    break;
               }
               gen_quad(code , K_COPY, e1, t, NULL, (__uint32_t[]){FLOAT, 0, 0});              
               
               adress-=2;
          }
     }
     return r;
}

// opération binaires constante/matrice
SymbolTableElement *matrix_binary_operation_constant(SymbolTableElement *a1, SymbolTableElement *a2, __uint32_t op)
{
     SymbolTableElement *constant;
     SymbolTableElement *array;
     if(a1->class == CONSTANT || a1->class == VARIABLE)
     {
          constant = a1;
          array = a2;
     }
     else
     {
          constant = a2;
          array = a1;
     }

     // varaiable temporaire pour le resultat
     SymbolTableElement *r = newtemp(symbol_table, ARRAY, MATRIX, adress, (__uint32_t[]){array->attribute.array.size[0], array->attribute.array.size[1]});
     adress += array->attribute.array.size[0]*array->attribute.array.size[1];

     for(int i=0;i<array->attribute.array.size[0];i++)
     {
          for(int j=0;j<array->attribute.array.size[1];j++)
          {
               SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
               SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
               SymbolTableElement *e1, *e2;

               e1 = generate_address_quads(r, add1, add2);
               adress++;
               e2 = generate_address_quads(array, add1, add2);

               // la variable temporaire est évitable mais cela oblige a changer le mips.c à cause des libérations attives des registres
               SymbolTableElement *t = newtemp(symbol_table, VARIABLE, FLOAT, adress, (__uint32_t[]){0, 0});
               switch(op)
               {
                    case '+':                         
                         gen_quad(code, BOP_PLUS, t, e2, constant, (__uint32_t[]){0, FLOAT, 0});
                    break;
                    case '-':
                         if(a1->class == CONSTANT || a1->class == VARIABLE)          // pour assurer la commutativité
                              gen_quad(code, BOP_MINUS, t, constant, e2, (__uint32_t[]){0, 0, FLOAT});
                         else
                              gen_quad(code, BOP_MINUS, t, e2, constant, (__uint32_t[]){0, FLOAT, 0});
                    break;
                    case '*':
                         gen_quad(code, BOP_MULT, t, e2, constant, (__uint32_t[]){0, FLOAT, 0});
                    break;
                    case '/':
                         if(a1->class == CONSTANT || a1->class == VARIABLE)
                              gen_quad(code, BOP_DIV, t, constant, e2, (__uint32_t[]){0, 0, FLOAT});
                         else
                              gen_quad(code, BOP_DIV, t, e2, constant, (__uint32_t[]){0, FLOAT, 0});
                    break;
               }
               gen_quad(code , K_COPY, e1, t, NULL, (__uint32_t[]){FLOAT, 0, 0});
               
               adress--;
          }
     }
     return r;
}

// opération unaires constante/matrice
SymbolTableElement *matrix_unary_operation_constant(SymbolTableElement *a1, __uint32_t op)
{     
     SymbolTableElement *r = a1;
     __uint32_t size = r->attribute.array.size[1];

     if(op == '-')
     {
          r = newtemp(symbol_table, ARRAY, MATRIX, adress, (__uint32_t[]){a1->attribute.array.size[0], a1->attribute.array.size[1]});
          adress += a1->attribute.array.size[0]*size;
     }
     else if(op == '~')
     {
          r = newtemp(symbol_table, ARRAY, MATRIX, adress, (__uint32_t[]){size, a1->attribute.array.size[0]});
          adress += a1->attribute.array.size[0]*size;

          size = a1->attribute.array.size[0]; //jamais = 0
     }

     for(int i=0;i<r->attribute.array.size[0];i++)
     {
          for(int j=0;j<size;j++)
          {
               SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
               SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
               SymbolTableElement *e1 = generate_address_quads(r, add1, add2);

               SymbolTableElement *un = insert_constant(&symbol_table, (Constant){.int_value = 1, .float_value =(float)1}, INT);
               SymbolTableElement *t = newtemp(symbol_table, VARIABLE, FLOAT, adress, (__uint32_t[]){0, 0});
               switch(op)
               {
                    case INCR:
                         gen_quad(code, BOP_PLUS, t, e1, un, (__uint32_t[]){0, FLOAT, 0});
                         gen_quad(code , K_COPY, e1, t, NULL, (__uint32_t[]){FLOAT, 0, 0});
                    break;
                    case DECR:
                         gen_quad(code, BOP_MINUS, t, e1, un, (__uint32_t[]){0, FLOAT, 0});
                         gen_quad(code , K_COPY, e1, t, NULL, (__uint32_t[]){FLOAT, 0, 0});
                    break;
                    case '-':
                         gen_quad(code, UOP_MINUS, t, generate_address_quads(a1, add1, add2), NULL,  (__uint32_t[]){0, FLOAT, 0});
                         gen_quad(code , K_COPY, e1, t, NULL, (__uint32_t[]){FLOAT, 0, 0});
                    break;
                    case '~':
                         if(r->attribute.array.size[0] == 1)
                              gen_quad(code, K_COPY, e1, generate_address_quads(a1, add1, add2), NULL, (__uint32_t[]){FLOAT, FLOAT, 0});
                         else
                              gen_quad(code, K_COPY, e1, generate_address_quads(a1, add2, add1), NULL, (__uint32_t[]){FLOAT, FLOAT, 0});
                    break;
               }
          }
     }
     return r;
}

SymbolTableElement *matrix_slice(SymbolTableElement **ptr_list1, SymbolTableElement **ptr_list2, __uint32_t size_ptr_list1, __uint32_t size_ptr_list2, SymbolTableElement *mat)
{
     __uint32_t f=0;
     if(!size_ptr_list2)
          size_ptr_list2=1;
     else
          f=1;

     SymbolTableElement *zero = insert_constant(&symbol_table, (Constant){.int_value = 0, .float_value = (float)0} ,INT);

     SymbolTableElement *r = newtemp(symbol_table, ARRAY, MATRIX, adress, (__uint32_t[]){size_ptr_list1, size_ptr_list2});
     adress += size_ptr_list1*size_ptr_list2;

     for(int i=0;i<size_ptr_list1;i++)
     {
          for(int j=0;j<size_ptr_list2;j++)
          {
               SymbolTableElement *e1, *e2;
               SymbolTableElement *add1 = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
               
               if(f)
               {
                    SymbolTableElement *add2 = insert_constant(&symbol_table, (Constant){.int_value = j, .float_value = (float)j} ,INT);
                    e1 = generate_address_quads(r, add1, add2);
                    adress++;
                    e2 = generate_address_quads(mat, ptr_list1[i], ptr_list2[j]);
               }
               else
               {
                    e1 = generate_address_quads(r, add1, zero);
                    adress++;
                    e2 = generate_address_quads(mat, ptr_list1[i], zero);
               }                   
               
               gen_quad(code , K_COPY, e1, e2, NULL, (__uint32_t[]){FLOAT, FLOAT, 0});              
               
               adress--;
          }
     }
     return r;
}

// remplace les NULL (*) par une lsite de tous les nombres entre 0 et asize
void complete_matrix_slice(__uint32_t asize, SymbolTableElement ***ptr_list, __uint32_t *size_ptr_list)
{
     __uint32_t size = *size_ptr_list;
     SymbolTableElement **list = malloc(size*sizeof(SymbolTableElement*));
     if(list == NULL)
     {
          printf("Error malloc in complete_matrix_slice\n");
          exit(1);
     }

     __uint32_t index=0;
     for(int i=0;i<size;i++)
     {
          if((*ptr_list)[i] == NULL)
          {
               *size_ptr_list += asize-1; // car NULL est deja dans la liste
               list = realloc(list, *size_ptr_list*sizeof(SymbolTableElement*));
               if(list == NULL)
               {
                    printf("Error realloc in complete_matrix_slice\n");
                    exit(1);  
               }
               
               for(int i=0;i<asize;i++)
               {
                    list[index] = insert_constant(&symbol_table, (Constant){.int_value = i, .float_value = (float)i} ,INT);
                    index++;
               }
          }
          else
          {
               list[index] = (*ptr_list)[i];
               index++;
          }          
     }

     free(*ptr_list);
     *ptr_list = list;
}

void open_scope()
{
     __uint32_t t = current_scope;
     max_scope++; 
     current_scope = max_scope;
     add_next_symbol_table(&symbol_table, current_scope, t);
}
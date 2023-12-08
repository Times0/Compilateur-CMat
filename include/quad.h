#ifndef QUAD_H
#define QUAD_H
#include "../include/symbol_table.h"

/* QUADRUPLETS ET CODE */

typedef struct Quad {
  enum quad_kind {BOP_PLUS, BOP_MINUS, BOP_MULT, BOP_DIV, BOP_MOD, UOP_MINUS, K_COPY, 
                  K_CALL_PRINT, K_CALL_PRINTF, K_CALL_PRINTMAT, K_CALL, K_GOTO, K_IF, K_IFNOT, K_IFLT, K_IFGT, K_IFLE, K_IFGE} kind;
  SymbolTableElement *sym1; // result
  SymbolTableElement *sym2; // operand 1 or function 
  SymbolTableElement *sym3; // operand 2 or NULL
  SymbolTableElement **function_parameters;
  __uint32_t nb_parameters;

  __int32_t branch_label;
  __int32_t label;      // tell if the quad is preceded by a label, we store a number to facilitate the generation of the label
  
}Quad;

typedef struct QuadTable{
    __uint32_t main_quad;
    __uint32_t capacity;
    __uint32_t nextquad;
    Quad * quads;
}QuadTable;

QuadTable *code_new();

void gen_quad(QuadTable * c, enum quad_kind k, SymbolTableElement * s1, SymbolTableElement * s2, SymbolTableElement * s3);
void gen_quad_function(QuadTable *c, enum quad_kind k, SymbolTableElement * result, SymbolTableElement * function, SymbolTableElement ** parameters, __uint32_t nb_parameters);
void gen_quad_goto(QuadTable *c, enum quad_kind k, SymbolTableElement * s1, SymbolTableElement * s2, __int32_t label);

char* generate_label();
char *generate_label_with_nb(__uint32_t nb);

__int32_t *create_list(__int32_t i);
__int32_t *concat_list(__int32_t *l1, __int32_t *l2);
void complete_list(__int32_t *l, __int32_t i);

void code_dump(QuadTable * c);

void code_free(QuadTable * c);


#endif
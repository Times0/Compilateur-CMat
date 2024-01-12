#ifndef QUAD_H
#define QUAD_H
#include "../include/symbol_table.h"

/* QUADRUPLETS ET CODE */

typedef struct Quad {
  enum quad_kind {BOP_PLUS, BOP_MINUS, BOP_MULT, BOP_DIV, BOP_MOD, UOP_MINUS, K_COPY, K_BEGIN_FUNCTION, K_END_FUNCTION,
                  K_CALL_PRINT, K_CALL_PRINTF, K_CALL, K_GOTO, K_IF, K_IFNOT, K_IFLT, K_IFGT, K_IFLE, K_IFGE} kind;
  SymbolTableElement *sym1; // result
  SymbolTableElement *sym2; // operand 1 or function 
  SymbolTableElement *sym3; // operand 2 or NULL

  __uint32_t by_adress[3]; //used for arrays to tell if the value is store by adress, one for each operand
                           // we store type

  SymbolTableElement **function_parameters;
  __uint32_t nb_parameters;
  __uint32_t *by_address_list;   //used for functions to tell if the parameter is passed by adress

  __int32_t branch_label;
  __int32_t label;              // tell if the quad is preceded by a label, we store a number to facilitate the generation of the label
  
}Quad;

typedef struct QuadTable{
    __uint32_t capacity;
    __uint32_t nextquad;
    __uint32_t mainquad;
    Quad * quads;
}QuadTable;

QuadTable *code_new();

void gen_quad(QuadTable *c, enum quad_kind k, SymbolTableElement * s1, SymbolTableElement * s2, SymbolTableElement * s3, __uint32_t by_adress[3]);
void gen_quad_function(QuadTable *c, enum quad_kind k, SymbolTableElement * result, SymbolTableElement * function, SymbolTableElement ** parameters, __uint32_t nb_parameters, __uint32_t *by_address);
void gen_quad_goto(QuadTable *c, enum quad_kind k, SymbolTableElement * s1, SymbolTableElement * s2, __int32_t label, __uint32_t by_adress[2]);

char* generate_label();
char *generate_label_with_nb(__uint32_t nb);

__int32_t *create_list(__int32_t i);
__int32_t *concat_list(__int32_t *l1, __int32_t *l2);
void complete_list(__int32_t *l, __int32_t i);

void code_dump(QuadTable * c);
void quad_dump(Quad *q);

void code_free(QuadTable * c);


#endif
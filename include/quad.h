#ifndef QUAD_H
#define QUAD_H
#include "../include/symbol_table.h"

/* QUADRUPLETS ET CODE */

typedef struct Quad {
  enum quad_kind { BOP_PLUS, BOP_MINUS, BOP_MULT, BOP_DIV, BOP_MOD, UOP_MINUS, COPY, CALL_PRINT } kind;
  SymbolTableElement * sym1; // result
  SymbolTableElement * sym2; // operand 1
  SymbolTableElement * sym3; // operand 2
}Quad;

typedef struct QuadTable{
    __uint32_t main_quad;
    __uint32_t capacity;
    __uint32_t nextquad;
    Quad * quads;
}QuadTable;

QuadTable *code_new();

void gen_quad(QuadTable * c, enum quad_kind k, SymbolTableElement * s1, SymbolTableElement * s2, SymbolTableElement * s3);

SymbolTableElement *newtemp(SymbolTable * t, __uint32_t type, __int32_t offset);

void code_dump(QuadTable * c);

void code_free(QuadTable * c);


#endif
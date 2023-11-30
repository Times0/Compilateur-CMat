#ifndef QUAD_H
#define QUAD_H
#include "../include/symbol_table.h"

/* QUADRUPLETS ET CODE */

struct quad {
  enum quad_kind { BOP_PLUS, BOP_MINUS, BOP_MULT, UOP_MINUS, COPY, CALL_PRINT } kind;
  SymbolTableElement * sym1;
  SymbolTableElement * sym2;
  SymbolTableElement * sym3;
};

struct code {
    unsigned int capacity;
    unsigned int nextquad;
    struct quad * quads;
};

struct code * code_new();

void gencode(struct code * c,
              enum quad_kind k,
              SymbolTableElement * s1,
              SymbolTableElement * s2,
              SymbolTableElement * s3);

SymbolTableElement *newtemp(SymbolTable * t);

void code_dump(struct code * c);

void code_free(struct code * c);


#endif
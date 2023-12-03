#ifndef MIPS_H
#define MIPS_H
#include <stdio.h>
#include "../include/quad.h"

#define MAXFPSIZE 1024

void gencode_mips_global_variable(FILE * f, SymbolTable * s);
void gencode_mips(QuadTable *code, FILE * f);
void gencode_mips_quad(FILE * f, Quad * quad);
void gencode_arith_binary_op (FILE * f, Quad *quad);
void gencode_arith_unary_op (FILE * f, Quad *quad);
void gencode_affect (FILE * f, Quad *quad);
void load_operator(FILE * f, SymbolTableElement *elem);
void store_result (FILE * f, SymbolTableElement *res, __uint32_t offset_res);
__uint32_t convert_int_to_float(SymbolTableElement *s);
__uint32_t convert_float_to_int(SymbolTableElement *s);


#endif
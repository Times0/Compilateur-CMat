#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define UNDEF 0

#define SYMBOLTABLE_INITIIAL_SIZE 4096
/* maximum size of tokens-identifiers */
#define MAXTOKENLEN 40

typedef struct Constant
{
    __uint32_t int_value;
    float float_value;   
}Constant;

typedef struct Variable
{
    __int32_t offset;
    char name[MAXTOKENLEN];
    __uint32_t scope;
}Variable;

typedef struct Function
{
    char name[MAXTOKENLEN];
    __uint32_t nb_parameters;
    __uint32_t *parameters_type;
}Function;

// struct that represents a list node
typedef struct SymbolTableElement
{
    enum {VARIABLE, CONSTANT, FUNCTION} class;
    __uint32_t type;

    union Attribute{
        Variable variable;
        Constant constant;
        Function function;
        /*union array
        {
            __uint32_t size1;
            __uint32_t size2;
        };*/
    }attribute;

}SymbolTableElement;
 
typedef struct SymbolTable {
    unsigned int capacity;
    unsigned int temporary;
    unsigned int size;
    SymbolTableElement *symbols;
}SymbolTable;
 
// function declarations
void init_symbol_table(SymbolTable **s);
void grow_symbol_table(SymbolTable **s);

SymbolTableElement* insert_variable(SymbolTable **s, char *name, __uint32_t type, __uint32_t class, __int32_t offset);
SymbolTableElement *insert_function(SymbolTable **s, char *name, __uint32_t type, __uint32_t class, __uint32_t nb_paramaters, __uint32_t *parameters_type);
SymbolTableElement* insert_constant(SymbolTable **s, Constant constant, __uint32_t type);

SymbolTableElement *lookup_variable(SymbolTable *s, char *name, __uint32_t scope, __uint32_t class);
SymbolTableElement *lookup_function(SymbolTable *s, char *name);
SymbolTableElement *lookup_constant(SymbolTable *s, Constant  constant, __uint32_t type);


void decr_scope(SymbolTable *s);
void incr_scope(SymbolTable *s);

void symbol_dump(SymbolTableElement *);
void symbol_table_dump(SymbolTable *s, FILE *of);
void free_symbol_table(SymbolTable *s);

#endif
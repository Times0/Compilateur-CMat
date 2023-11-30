#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define UNDEF 0

/* maximum size of hash table */
#define SYMBOLTABLE_SIZE 4096
/* maximum size of tokens-identifiers */
#define MAXTOKENLEN 40

/* parameter struct */
typedef struct Param
{
    __uint32_t param_type;
    char param_name[MAXTOKENLEN];
    __uint32_t param_value;
}Param;

typedef union Value
{
    __uint64_t int_value;
    float float_value;   
}Value;


// struct that represents a list node
typedef struct SymbolTableElement
{
    enum {VARIABLE, CONSTANT, FUNCTION} class;
    __uint32_t type;
    __uint32_t scope;

    union Attribute{
        char name[MAXTOKENLEN];
        Value val;
        /*union array
        {
            __uint32_t size1;
            __uint32_t size2;
        };
        union function
        {
            __uint32_t nb_param;
            __uint32_t return_type;
            Param *parameters;
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
void init_symbol_table();                                                       // initialize hash table
SymbolTableElement* insert(char *name, __uint32_t type, __uint32_t class);    // insert entry
SymbolTableElement* insert_constant(Value value, __uint32_t type);    // insert entry
SymbolTableElement* lookup_constant(Value value, __uint32_t type);
SymbolTableElement* lookup_scope(char *name, __uint32_t scope, __uint32_t class);                 // search for entry in scope
void decr_scope();                                                              // hide the current scope
void incr_scope();                                                              // go to next scope
void symbol_dump(SymbolTableElement *);                                        // dump entry
void symbol_table_dump(FILE *of);                                               // dump file
void free_symbol_table();                                                       // free memory

#endif
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
 
union value
{
    __int32_t int_val;
    float float_val;
    char *string_val;
};

/* parameter struct */
typedef struct Param
{
    __uint32_t param_type;
    char param_name[MAXTOKENLEN];
    union value param_value;
}Param;
 
/* a linked list of references (lineno's) for each variable */
typedef struct LineList
{ 
    __uint32_t lineno;
    struct LineList *next;
}LineList;
 
typedef struct ScopeList
{ 
    __uint32_t scope;
    struct ScopeList *next;
}ScopeList;

// struct that represents a list node
typedef struct SymbolTableElement
{
    __uint32_t type;
    char name[MAXTOKENLEN];
    union value val;
    ScopeList *scopes;
    LineList *lines;
    
    // __uint32_t inf_type;
    // __uint32_t *i_vals; float *f_vals; char **s_vals;
    // __uint32_t array_size;
    Param *parameters;
    __uint32_t nb_param;

}SymbolTableElement;
 
typedef struct SymbolTable {
    unsigned int capacity;
    unsigned int temporary;
    unsigned int size;
    SymbolTableElement * symbols;
}SymbolTable;
 
// function declarations
void init_symbol_table();                                                       // initialize hash table
__uint32_t hash(char *key);                                                     // hash function 
SymbolTableElement* insert(char *name, __uint32_t len, __uint32_t type, __uint32_t lineno);    // insert entry
SymbolTableElement* lookup(char *name);                                         // search for entry
SymbolTableElement* lookup_scope(char *name, __uint32_t scope);                 // search for entry in scope
void decr_scope();                                                              // hide the current scope
void incr_scope();                                                              // go to next scope
void add_type(char *name, __uint32_t type);                                     // add type to entry
void add_scope(char *name, __uint32_t scope);                                   // add scope to the entry
void symbol_dump(SymbolTableElement *);                                        // dump entry
void symbol_table_dump(FILE *of);                                               // dump file
void free_symbol_table();                                                       // free memory

#endif
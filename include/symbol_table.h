#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Token types */
#define UNDEF 0

/* maximum size of hash table */
#define SIZE 4096
 
/* maximum size of tokens-identifiers */
#define MAXTOKENLEN 40
 
/* parameter struct */
typedef struct Param
{
    __uint32_t par_type;
    char param_name[MAXTOKENLEN];
    // to store value
    __int32_t ival; float fval; char *st_sval;
}Param;
 
/* a linked list of references (lineno's) for each variable */
typedef struct RefList
{ 
    __uint32_t lineno;
    struct RefList *next;
    __uint32_t type;
}RefList;
 
// struct that represents a list node
typedef struct list_t
{
    char st_name[MAXTOKENLEN];
    __uint32_t st_size;
    __uint32_t scope;
    RefList *lines;
    // to store value and sometimes more information
    __uint32_t st_ival; float st_fval; char *st_sval;
    // type
    __uint32_t st_type;
    __uint32_t inf_type; // for arrays (info type) and functions (return type)
    // array stuff
    __uint32_t *i_vals; float *f_vals; char **s_vals;
    __uint32_t array_size;
    // function parameters
    Param *parameters;
    __uint32_t num_of_pars;
    // pointer to next item in the list
    struct list_t *next;
} list_t;
 
/* the hash table */
static list_t **hash_table;
 
// function declarations
void init_hash_table();                                     // initialize hash table
__uint32_t hash(char *key);                               // hash function 
void insert(char *name, __uint32_t len, __uint32_t type, __uint32_t lineno);     // insert entry
list_t *lookup(char *name);                                 // search for entry
list_t *lookup_scope(char *name, __uint32_t scope);                // search for entry in scope
void decr_scope();                                          // hide the current scope
void incr_scope();                                          // go to next scope
void add_type(char *name, __uint32_t type);                        // add type to entry
void symtab_dump(FILE *of);                                 // dump file

#endif
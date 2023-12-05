#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define UNDEF 0

#define SYMBOLTABLE_INITIIAL_SIZE 32
/* maximum size of tokens-identifiers */
#define MAXTOKENLEN 40
#define MAXSTRLEN 100

// La table des symboles est représentée par un tableau de List_SymbolTableElement
// Chaque élément contient un pointeur vers un élément de la table des symboles
// et un pointeur vers le prochain element de meme nom mais de portée inférieure

typedef struct Constant
{
    __uint32_t int_value;
    float float_value;   
}Constant;

typedef struct Variable
{
    __int32_t frame_pointer;
    char name[MAXTOKENLEN];
}Variable;

typedef struct Function
{
    char name[MAXTOKENLEN];
    __uint32_t nb_parameters;
    __uint32_t *parameters_type;
}Function;

typedef struct String
{
    char string[MAXSTRLEN];
    __uint32_t frame_pointer;
}String;

// struct that represents a list node
typedef struct SymbolTableElement
{
    enum {VARIABLE, CONSTANT, FUNCTION, STR} class;
    __uint32_t type;

    union Attribute{
        Variable variable;
        Constant constant;
        Function function;
        String string;
        /*union array
        {
            __uint32_t size1;
            __uint32_t size2;
        };*/
    }attribute;

}SymbolTableElement;
 
typedef struct SymbolTable
{
    __uint32_t capacity;  // capacity of the table
    __uint32_t temporary; // number of temporary variable to create label
    __uint32_t size;      // number of elements in the table  
    __uint32_t scope;     // scope of the table
    SymbolTableElement *symbols;

    struct SymbolTable *next;
    struct SymbolTable *previous;
}SymbolTable;
 
// function declarations
void init_symbol_table(SymbolTable **s, __uint32_t scope);
void grow_symbol_table(SymbolTable **s);
void remove_last_symbol_table(SymbolTable *s);
SymbolTable *get_last_symbol_table(SymbolTable *s);
SymbolTable *get_symbol_table_by_scope(SymbolTable *s, __uint32_t scope);
void push_predefined_functions(SymbolTable **s);
SymbolTable* add_next_symbol_table(SymbolTable **s, __uint32_t scope, __uint32_t parent_symbol_table_scope);

SymbolTableElement *insert_variable(SymbolTable **s, char *name, __uint32_t type, __uint32_t class, __int32_t frame_pointer, __uint32_t scope);
SymbolTableElement *insert_function(SymbolTable **s, char *name, __uint32_t type, __uint32_t class, __uint32_t nb_paramaters, __uint32_t *parameters_type);
SymbolTableElement* insert_constant(SymbolTable **s, Constant constant, __uint32_t type);
SymbolTableElement *insert_string(SymbolTable **s, char *string);

SymbolTableElement *lookup_variable(SymbolTable *s, char *name, __uint32_t scope, __uint32_t class, __uint32_t exact_scope);
SymbolTableElement *lookup_function(SymbolTable *s, char *name);
SymbolTableElement *lookup_constant(SymbolTable *s, Constant  constant, __uint32_t type);
SymbolTableElement *lookup_string(SymbolTable *s, char *string);

void decr_scope(SymbolTable *s);
void incr_scope(SymbolTable *s);

void symbol_dump(SymbolTableElement *);
void symbol_table_dump(SymbolTable *s, FILE *of);
void free_symbol_table(SymbolTable *s);

#endif
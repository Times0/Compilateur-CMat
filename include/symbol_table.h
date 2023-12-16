#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define UNDEF 0

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
    __int32_t adress;
    char name[MAXTOKENLEN];
}Variable;

typedef struct Function
{
    char name[MAXTOKENLEN];
    __uint32_t nb_parameters;
    __uint32_t *parameters_type;
    __uint32_t *by_adress;
}Function;

typedef struct String
{
    char string[MAXSTRLEN];
    __uint32_t adress;
}String;

typedef struct Array
{
    __int32_t adress;
    char name[MAXTOKENLEN];
    __uint32_t size[2];
}Array;

// struct that represents a list node
typedef struct SymbolTableElement
{
    enum {VARIABLE, ARRAY, CONSTANT, FUNCTION, STR} class;
    __uint32_t type;

    union Attribute{
        Variable variable;
        Constant constant;
        Function function;
        String string;
        Array array;

    }attribute;
    struct SymbolTableElement *next;

}SymbolTableElement;
 
typedef struct SymbolTable
{
    __uint32_t temporary; // number of temporary variable to create label
    __uint32_t size;      // number of elements in the table  
    __uint32_t scope;     // scope of the table
    __uint32_t nb_variable;   // Number of frame pointer in the table
    SymbolTableElement *first_symbol;  

    struct SymbolTable *next;       // liste chainée des tables de symboles
    struct SymbolTable *previous;   // permet de remonter dans la table des symboles en respectant les scopes
}SymbolTable;
 
// function declarations
void init_symbol_table(SymbolTable **s, __uint32_t scope);
SymbolTable *get_last_symbol_table(SymbolTable *s);
SymbolTable *get_symbol_table_by_scope(SymbolTable *s, __uint32_t scope);
void push_predefined_functions(SymbolTable **s);
SymbolTable* add_next_symbol_table(SymbolTable **s, __uint32_t scope, __uint32_t parent_symbol_table_scope);
SymbolTableElement *get_symbol(SymbolTable *s, __uint32_t i);

SymbolTableElement *insert_variable(SymbolTable *s, const char *name, __uint32_t type, __uint32_t class, __uint32_t size[2], __int32_t adress, __uint32_t scope);
SymbolTableElement *insert_function(SymbolTable **s, const char *name, __uint32_t type, __uint32_t class, __uint32_t nb_paramaters, __uint32_t *parameters_type);
SymbolTableElement *insert_constant(SymbolTable **s, Constant constant, __uint32_t type);
SymbolTableElement *insert_string(SymbolTable *s, const char *string, __uint32_t adress);

SymbolTableElement *lookup_variable(SymbolTable *s, const char *name, __uint32_t scope, __uint32_t class, __uint32_t exact_scope);
SymbolTableElement *lookup_function(SymbolTable *s, const char *name);
SymbolTableElement *lookup_constant(SymbolTable *s, Constant  constant, __uint32_t type);
SymbolTableElement *lookup_string(SymbolTable *s, char *string);

SymbolTableElement *newtemp(SymbolTable * t, __uint32_t class, __uint32_t type, __int32_t offset, __uint32_t size[2]);

void symbol_dump(SymbolTableElement *e, __uint32_t by_adress);
void symbol_table_dump(SymbolTable *s, FILE *of);
void free_symbol_table(SymbolTable *s);

#endif
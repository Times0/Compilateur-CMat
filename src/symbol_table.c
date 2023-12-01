#include "../include/symbol_table.h"
#include <stdio.h>
#include <stdlib.h>
#include "../include/cmat.tab.h"

__uint32_t current_scope = 0;
__uint32_t lineno = 1;

SymbolTable *symbol_table;
struct code *code;

void init_symbol_table()
{
	symbol_table = malloc(sizeof(SymbolTable));
	if (symbol_table == NULL)
	{
		perror("Error malloc in init_symbol_table\n");
		exit(1);
	}
	symbol_table->symbols = malloc(SYMBOLTABLE_SIZE * sizeof(SymbolTableElement));
	symbol_table->temporary = 0;
	symbol_table->size = 0;
	symbol_table->capacity = SYMBOLTABLE_SIZE;
	if (symbol_table->symbols == NULL)
	{
		perror("Error malloc in init_symbol_table\n");
		exit(1);
	}
}

void grow_symbol_table()
{
	symbol_table->capacity += 1024;
	symbol_table->symbols = realloc(symbol_table->symbols, symbol_table->capacity * sizeof(SymbolTableElement));
	if (symbol_table->symbols == NULL)
	{
		fprintf(stderr, "Error attempting to grow symbol table (actual size is %d)\n", symbol_table->size);
		exit(1);
	}
}

SymbolTableElement *insert(char *name, __uint32_t type, __uint32_t class)
{
	printf("insert %s\n", name);
	if (class == VARIABLE)
	{
		SymbolTableElement *l = lookup_scope(name, current_scope, VARIABLE);

		/* if variable not yet exists in the table insert it */
		if (l == NULL)
		{
			if (symbol_table->size >= symbol_table->capacity)
			{
				grow_symbol_table();
			}
			l = &(symbol_table->symbols[symbol_table->size]);
			strcpy(l->attribute.name, name);
			l->class = VARIABLE;
			l->type = type;
			l->scope = current_scope;
			symbol_table->size++;
		}
		return l;
	}
}

SymbolTableElement *insert_constant(Value value, __uint32_t type)
{
	SymbolTableElement *l = lookup_constant(value, type);
	if (l == NULL)
	{
		if (symbol_table->size == symbol_table->capacity)
			grow_symbol_table();

		l = &(symbol_table->symbols[symbol_table->size]);
		if (type == INT)
			l->attribute.val.int_value = value.int_value;
		else if (type == FLOAT)
			l->attribute.val.float_value = value.float_value;

		l->class = CONSTANT;
		l->type = type;
		l->scope = current_scope;
		++(symbol_table->size);
	}
	return l;
}

/* return symbol if found or NULL if not found */
SymbolTableElement *lookup_constant(Value value, __uint32_t type)
{
	if (type == INT)
	{
		__uint32_t i;
		for (i = 0; i < symbol_table->size; i++)
		{
			if (symbol_table->symbols[i].class == CONSTANT)
				if (symbol_table->symbols[i].attribute.val.int_value == value.int_value)
					break;
		}
		// printf("%d %d\n", i, symbol_table->size);
		if (i < symbol_table->size)
			return &(symbol_table->symbols[i]);
		return NULL;
	}
}

/* return symbol if found or NULL if not found */
SymbolTableElement *lookup_scope(char *name, __uint32_t scope, __uint32_t class)
{
	if (class == VARIABLE)
	{
		__uint32_t i;
		for (i = 0; i < symbol_table->size && strcmp(symbol_table->symbols[i].attribute.name, name) != 0; i++)
			;
		if (i < symbol_table->size)
			return &(symbol_table->symbols[i]);
		return NULL;
	}
}

void decr_scope()
{
	if (current_scope > 0)
		current_scope--;
}

void incr_scope()
{
	current_scope++;
}

/* print to stdout by default */
void symbol_table_dump(FILE *of)
{
	__uint32_t i;
	fprintf(of, "------------ ------- -------\n");
	fprintf(of, "Name         Type    Scope  \n");
	fprintf(of, "------------ ------- -------\n");
	for (i = 0; i < symbol_table->size; ++i)
	{
		// if(symbol_table->symbols[i].attribute.name[0] == '\0')
		// 	continue;
		SymbolTableElement elem = symbol_table->symbols[i];

		if (elem.class == CONSTANT)
			continue;

		printf("Showing symbol %s\n", elem.attribute.name);
		const char *typeStr = "";
		switch (elem.type)
		{
		case INT:
			typeStr = "int";
			break;
		case FLOAT:
			typeStr = "float";
			break;
		case STRING:
			typeStr = "string";
			break;
		case MATRIX:
			typeStr = "matrix";
			break;
		case VOID:
			typeStr = "void";
			break;
		default:
			typeStr = "undef";
			break;
		}
		fprintf(of, "%-12s %-7s ", elem.attribute.name, typeStr);
		fprintf(of, "%-4d ", elem.scope);
		fprintf(of, "\n");
	}
}

void symbol_dump(SymbolTableElement *e)
{
	if (e->class == VARIABLE)
		printf("%s", e->attribute.name);
	else if (e->class == CONSTANT)
	{
		if (e->type == INT)
			printf("%ld", e->attribute.val.int_value);
		else if (e->type == FLOAT)
			printf("%f", e->attribute.val.float_value);
	}
}

void free_symbol_table()
{
	free(symbol_table->symbols);
	free(symbol_table);
}
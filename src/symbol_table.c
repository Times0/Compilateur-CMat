#include "../include/symbol_table.h"
#include <stdio.h>
#include <stdlib.h>
#include "../include/cmat.tab.h"

__uint32_t current_scope = 0;
__uint32_t lineno = 1;

SymbolTable *symbol_table;
struct code *code;

void init_symbol_table(SymbolTable **s)
{
	*s = malloc(sizeof(SymbolTable));
	if (*s == NULL)
	{
		perror("Error malloc in init_symbol_table\n");
		exit(1);
	}
	(*s)->symbols = malloc(SYMBOLTABLE_SIZE * sizeof(SymbolTableElement));
	(*s)->temporary = 0;
	(*s)->size = 0;
	(*s)->capacity = SYMBOLTABLE_SIZE;
	if ((*s)->symbols == NULL)
	{
		perror("Error malloc in init_symbol_table\n");
		exit(1);
	}
}

void grow_symbol_table(SymbolTable **s)
{
	(*s)->capacity += 1024;
	(*s)->symbols = realloc((*s)->symbols, (*s)->capacity * sizeof(SymbolTableElement));
	if ((*s)->symbols == NULL)
	{
		fprintf(stderr, "Error attempting to grow symbol table (actual size is %d)\n", (*s)->size);
		exit(1);
	}
}

SymbolTableElement *insert(SymbolTable **s, char *name, __uint32_t type, __uint32_t class, __int32_t offset)
{
	if (class == VARIABLE)
	{
		SymbolTableElement *l = lookup_scope(*s, name, current_scope, VARIABLE);

		/* if variable not yet exists in the table insert it */
		if (l == NULL)
		{
			if ((*s)->size >= (*s)->capacity)
			{
				grow_symbol_table(s);
			}
			l = &((*s)->symbols[(*s)->size]);
			strcpy(l->attribute.variable.name, name);
			l->attribute.variable.offset = offset;
			l->class = VARIABLE;
			l->type = type;
			l->scope = current_scope;
			(*s)->size++;
		}
		return l;
	}
}

SymbolTableElement *insert_constant(SymbolTable **s, Constant constant, __uint32_t type)
{
	SymbolTableElement *l = lookup_constant(*s,constant, type);
	if (l == NULL)
	{
		if ((*s)->size == (*s)->capacity)
			grow_symbol_table(s);

		l = &((*s)->symbols[(*s)->size]);
			
		l->attribute.constant.int_value = constant.int_value;	
		l->attribute.constant.float_value = constant.float_value;

		l->class = CONSTANT;
		l->type = type;
		l->scope = current_scope;
		++((*s)->size);
	}
	return l;
}

/* return symbol if found or NULL if not found */
SymbolTableElement *lookup_constant(SymbolTable *s, Constant constant, __uint32_t type)
{
	if (type == INT)
	{
		__uint32_t i;
		for (i = 0; i < s->size; i++)
		{
			if (s->symbols[i].class == CONSTANT)
				if (s->symbols[i].attribute.constant.int_value == constant.int_value)
					break;
		}
		if (i < s->size)
			return &(s->symbols[i]);
		return NULL;
	}
	else if (type == FLOAT)
	{
		__uint32_t i;
		for (i = 0; i < s->size; i++)
		{
			if (s->symbols[i].class == CONSTANT)
				if (s->symbols[i].attribute.constant.float_value == constant.float_value)
					break;
		}
		if (i < s->size)
			return &(s->symbols[i]);
		return NULL;
	}
}

/* return symbol if found or NULL if not found */
SymbolTableElement *lookup_scope(SymbolTable *s, char *name, __uint32_t scope, __uint32_t class)
{
	if (class == VARIABLE)
	{
		__uint32_t i;
		for (i = 0; i < s->size && strcmp(s->symbols[i].attribute.variable.name, name) != 0; i++)
			;
		if (i < s->size)
			return &(s->symbols[i]);
		return NULL;
	}
}

void decr_scope(SymbolTable *s)
{
	if (current_scope > 0)
		current_scope--;
}

void incr_scope(SymbolTable *s)
{
	current_scope++;
}

/* print to stdout by default */
void symbol_table_dump(SymbolTable *s, FILE *of)
{
	__uint32_t i;
	fprintf(of, "------------ ------- -------\n");
	fprintf(of, "Name         Type    Scope  \n");
	fprintf(of, "------------ ------- -------\n");
	int nb_cst = 0;
	for (i = 0; i < s->size; ++i)
	{
		// if(symbol_table->symbols[i].attribute.name[0] == '\0')
		// 	continue;
		SymbolTableElement elem = s->symbols[i];

		if (elem.class == CONSTANT)
		{
			nb_cst++;
			continue;
		}

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
		fprintf(of, "%-12s %-7s ", elem.attribute.variable.name, typeStr);
		fprintf(of, "%-4d ", elem.scope);
		fprintf(of, "\n");
	}

	fprintf(of, "------------ ------- -------\n");
	fprintf(of, "Number of constants: %d\n", nb_cst);
}

void symbol_dump(SymbolTableElement *e)
{
	if (e->class == VARIABLE)
		printf("%s", e->attribute.variable.name);
	else if (e->class == CONSTANT)
	{
		if (e->type == INT)
			printf("%d", e->attribute.constant.int_value);
		else if (e->type == FLOAT)
			printf("%f", e->attribute.constant.float_value);
	}
}

void free_symbol_table(SymbolTable *s)
{
	free(s->symbols);
	free(s);
}
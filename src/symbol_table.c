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
	(*s)->symbols = malloc(SYMBOLTABLE_INITIIAL_SIZE * sizeof(SymbolTableElement));
	(*s)->temporary = 0;
	(*s)->size = 0;
	(*s)->capacity = SYMBOLTABLE_INITIIAL_SIZE;
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


SymbolTableElement *insert_variable(SymbolTable **s, char *name, __uint32_t type, __uint32_t class, __int32_t offset)
{
	if (class == VARIABLE)
	{
		SymbolTableElement *l = lookup_variable(*s, name, current_scope, VARIABLE);

		/* if variable not yet exists in the table insert_variable it */
		if (l == NULL)
		{
			if ((*s)->size >= (*s)->capacity)
			{
				grow_symbol_table(s);
			}
			l = &((*s)->symbols[(*s)->size]);
			strncpy(l->attribute.variable.name, name, MAXTOKENLEN);
			l->attribute.variable.offset = offset;
			l->class = VARIABLE;
			l->type = type;
			(*s)->size++;
		}
		return l;
	}
}

SymbolTableElement *insert_function(SymbolTable **s, char *name, __uint32_t type, __uint32_t class, __uint32_t nb_paramaters, __uint32_t *parameters_type)
{
	SymbolTableElement *l = lookup_function(*s, name);
	if (l == NULL)
	{
		if ((*s)->size >= (*s)->capacity)
			grow_symbol_table(s);

		l = &((*s)->symbols[(*s)->size]);
		strncpy(l->attribute.function.name, name, MAXTOKENLEN);
		l->attribute.function.nb_parameters = nb_paramaters;
		
		l->attribute.function.parameters_type = malloc(nb_paramaters * sizeof(__uint32_t));
		if(l->attribute.function.parameters_type == NULL)
		{
			perror("Error malloc in insert_function\n");
			exit(1);
		}
		for (int i = 0; i < nb_paramaters; i++)
			l->attribute.function.parameters_type[i] = parameters_type[i];
		
		l->class = FUNCTION;
		l->type = type;
		(*s)->size++;
	}
	return l;
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
		++((*s)->size);
	}
	return l;
}

SymbolTableElement *insert_string(SymbolTable **s, char *string)
{
	SymbolTableElement *l = lookup_string(*s, string);
	if (l == NULL)
	{
		if ((*s)->size == (*s)->capacity)
			grow_symbol_table(s);

		l = &((*s)->symbols[(*s)->size]);
		
		strncpy(l->attribute.string.string, string, MAXSTRLEN);
		
		l->class = STR;
		l->type = STRING;
		++((*s)->size);
	}
	return l;
}

/* return symbol if found or NULL if not found */
SymbolTableElement *lookup_variable(SymbolTable *s, char *name, __uint32_t scope, __uint32_t class)
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

SymbolTableElement *lookup_function(SymbolTable *s, char *name)
{
	__uint32_t i;
	for (i = 0; i < s->size; i++)
	{
		if (s->symbols[i].class == FUNCTION)
			if (strcmp(s->symbols[i].attribute.function.name, name) == 0)
				break;
	}
	if (i < s->size)
		return &(s->symbols[i]);
	return NULL;
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
					if(s->symbols[i].type == INT) // obligatoire a cause du float_value qui est remplie
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
					if(s->symbols[i].type == FLOAT) // obligatoire a cause du int_value qui est remplie
						break;
		}
		if (i < s->size)
			return &(s->symbols[i]);
		return NULL;
	}
}

SymbolTableElement *lookup_string(SymbolTable *s, char *string)
{
	__uint32_t i;
	for (i = 0; i < s->size; i++)
	{
		if (s->symbols[i].class == STR)
			if (strcmp(s->symbols[i].attribute.string.string, string) == 0)
				break;
	}
	if (i < s->size)
		return &(s->symbols[i]);
	return NULL;
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
	fprintf(of, "-------------- ----------- ---------- ---------------\n");
	fprintf(of, "     Name         Class       Type       arguments   \n");
	fprintf(of, "-------------- ----------- ---------- ---------------\n");
	int nb_cst = 0;
	for (i = 0; i < s->size; ++i)
	{
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
		case MATRIX:
			typeStr = "matrix";
			break;
		case VOID:
			typeStr = "void";
			break;
		case STRING:
			typeStr = "string";
			break;
		default:
			typeStr = "undef";
			break;
		}
		const char *classStr = "";
		switch (elem.class)
		{
		case VARIABLE:
			classStr = "variable";
			break;
		case FUNCTION:
			classStr = "function";
			break;
		case STR:
			classStr = "string";
			break;
		}

		if(elem.class == FUNCTION)
		{
			fprintf(of, "%-14s %-11s %-10s (", elem.attribute.function.name, classStr, typeStr);
			for(int j = 0; j < elem.attribute.function.nb_parameters; j++)
			{
				switch (elem.attribute.function.parameters_type[j])
				{
				case INT:
					fprintf(of, "int");
					break;
				case FLOAT:
					fprintf(of, "float");
					break;
				case MATRIX:
					fprintf(of, "matrix");
					break;
				case VOID:
					fprintf(of, "void*");
					break;
				case STRING:
					fprintf(of, "string");
					break;
				}
				if(j < elem.attribute.function.nb_parameters - 1)
					fprintf(of, ", ");
			}
			fprintf(of, ")\n");
		}
		else
			fprintf(of, "%-14s %-11s %-10s\n", elem.attribute.variable.name, classStr, typeStr);
	}

	fprintf(of, "-------------- ----------- ----------\n");
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
	else if (e->class == STR)
		printf("%s", e->attribute.string.string);
	
}

void free_symbol_table(SymbolTable *s)
{
	free(s->symbols);
	free(s);
}
#include "../include/symbol_table.h"
#include <stdio.h>
#include <stdlib.h>
#include "../include/cmat.tab.h"

__uint32_t current_scope = 0;
__uint32_t next_scope = 1;
__uint32_t previous_scope = 0;

void init_hash_table()
{
	symbol_table = malloc(SIZE * sizeof(SymbolTableElement *));
	for (__uint32_t i = 0; i < SIZE; i++)
		symbol_table[i] = NULL;
}

__uint32_t hash(char *key)
{
    __uint32_t hashval = 0;
    for (; *key != '\0'; key++)
        hashval += *key;
    hashval += key[0] % 11 + (key[0] << 3) - key[0];
    // hashval += additionalValue;  // Incorporate the additional integer value
    return hashval % SIZE;
}



void insert(char *name, __uint32_t len, __uint32_t type, __uint32_t lineno)
{
	__uint32_t hashval = hash(name);
	SymbolTableElement *l = symbol_table[hashval];

	// maybe nul
	while ((l != NULL) && (strcmp(name, l->name) != 0) && (l->scope != current_scope))
		l = l->next;

	/* variable not yet in table */
	if (l == NULL)
	{
		l = (SymbolTableElement *)malloc(sizeof(SymbolTableElement));
		strncpy(l->name, name, len);
		/* add to hashtable */
		l->type = type;
		l->scope = current_scope;
		l->lines = (RefList *)malloc(sizeof(RefList));
		l->lines->lineno = lineno;
		l->lines->next = NULL;
		l->next = symbol_table[hashval];
		symbol_table[hashval] = l;
		// printf("Inserted %s for the first time with linenumber %d!\n", name, lineno); // error checking
	}
	/* found in table, so just add line number */
	else
	{
		// l->scope = current_scope;
		RefList *t = l->lines;
		while (t->next != NULL)
			t = t->next;
		/* add linenumber to reference list */
		t->next = (RefList *)malloc(sizeof(RefList));
		t->next->lineno = lineno;
		t->next->next = NULL;
		// printf("Found %s again at line %d!\n", name, lineno);
	}
}

SymbolTableElement *lookup(char *name)
{ /* return symbol if found or NULL if not found */
	__uint32_t hashval = hash(name);
	SymbolTableElement *l = symbol_table[hashval];
	while ((l != NULL) && (strcmp(name, l->name) != 0))
		l = l->next;
	return l; // NULL is not found
}

SymbolTableElement *lookup_scope(char *name, __uint32_t scope)
{ /* return symbol if found or NULL if not found */
	__uint32_t hashval = hash(name);
	SymbolTableElement *l = symbol_table[hashval];
	while ((l != NULL) && (strcmp(name, l->name) != 0) && (scope != l->scope))
		l = l->next;
	return l; // NULL is not found
}

void decr_scope()
{
	// if (current_scope > 0)
		current_scope = previous_scope;
}

void incr_scope()
{
	previous_scope = current_scope;
	current_scope = next_scope;
	next_scope++;
}

void add_type(char *name, __uint32_t type)
{
	__uint32_t hashval = hash(name);
	SymbolTableElement *l = symbol_table[hashval];
	
	while ((l != NULL) && (strcmp(name, l->name) != 0) && l->scope)
		l = l->next;
	
	if (l != NULL)
		if(l->type == UNDEF)
			l->type = type;
}

/* print to stdout by default */
void symbol_table_dump(FILE *of)
{
	__uint32_t i;
	fprintf(of, "------------ ------- ------- ---------------\n");
	fprintf(of, "Name         Type    Scope    Line Numbers   \n");
	fprintf(of, "------------ ------- ------- ---------------\n");
	for (i = 0; i < SIZE; ++i)
	{
		if (symbol_table[i] == NULL)
			continue;

		SymbolTableElement *l = symbol_table[i];
		while (l != NULL)
		{
			RefList *t = l->lines;
			fprintf(of, "%-12s ", l->name);
			
			if (l->type == INT)
				fprintf(of, "%-7s ", "int");
			else if (l->type == FLOAT)
				fprintf(of, "%-7s ", "float");
			else if (l->type == STRING)
				fprintf(of, "%-7s ", "string");
			else if (l->type == MATRIX)
				fprintf(of, "%-7s ", "matrix");
			else if (l->type == VOID)
				fprintf(of, "%-7s ", "void");
			else
				fprintf(of, "%-7s ", "undef"); // if UNDEF or 0, both are equal
			
			fprintf(of, "%-7d ", l->scope);

			while (t != NULL)
			{
				fprintf(of, "%4d ", t->lineno);
				t = t->next;
			}
			
			fprintf(of, "\n");
			l = l->next;
		}
	}
}
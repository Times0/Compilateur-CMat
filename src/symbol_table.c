#include "../include/symbol_table.h"
#include <stdio.h>
#include <stdlib.h>
#include "../include/cmat.tab.h"

__uint32_t current_scope = 0;
__uint32_t next_scope = 1;
__uint32_t previous_scope = 0;

void init_hash_table()
{
	hash_table = malloc(SIZE * sizeof(list_t *));
	for (__uint32_t i = 0; i < SIZE; i++)
		hash_table[i] = NULL;
}

__uint32_t hash(char *key)
{
	__uint32_t hashval = 0;
	for (; *key != '\0'; key++)
		hashval += *key;
	hashval += key[0] % 11 + (key[0] << 3) - key[0];
	return hashval % SIZE;
}

void insert(char *name, __uint32_t len, __uint32_t type, __uint32_t lineno)
{
	__uint32_t hashval = hash(name);
	list_t *l = hash_table[hashval];

	// maybe nul
	while ((l != NULL) && (strcmp(name, l->st_name) != 0) && (l->scope != current_scope))
		l = l->next;

	/* variable not yet in table */
	if (l == NULL)
	{
		l = (list_t *)malloc(sizeof(list_t));
		strncpy(l->st_name, name, len);
		/* add to hashtable */
		l->st_type = type;
		l->scope = current_scope;
		l->lines = (RefList *)malloc(sizeof(RefList));
		l->lines->lineno = lineno;
		l->lines->next = NULL;
		l->next = hash_table[hashval];
		hash_table[hashval] = l;
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

list_t *lookup(char *name)
{ /* return symbol if found or NULL if not found */
	__uint32_t hashval = hash(name);
	list_t *l = hash_table[hashval];
	while ((l != NULL) && (strcmp(name, l->st_name) != 0))
		l = l->next;
	return l; // NULL is not found
}

list_t *lookup_scope(char *name, __uint32_t scope)
{ /* return symbol if found or NULL if not found */
	__uint32_t hashval = hash(name);
	list_t *l = hash_table[hashval];
	while ((l != NULL) && (strcmp(name, l->st_name) != 0) && (scope != l->scope))
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
	list_t *l = hash_table[hashval];
	
	while ((l != NULL) && (strcmp(name, l->st_name) != 0) && l->scope)
		l = l->next;
	
	if (l != NULL)
		if(l->st_type == UNDEF)
			l->st_type = type;
}

/* print to stdout by default */
void symtab_dump(FILE *of)
{
	__uint32_t i;
	fprintf(of, "------------ ------- ------- ---------------\n");
	fprintf(of, "Name         Type    Scope    Line Numbers   \n");
	fprintf(of, "------------ ------- ------- ---------------\n");
	for (i = 0; i < SIZE; ++i)
	{
		if (hash_table[i] == NULL)
			continue;

		list_t *l = hash_table[i];
		while (l != NULL)
		{
			RefList *t = l->lines;
			fprintf(of, "%-12s ", l->st_name);
			
			if (l->st_type == INT)
				fprintf(of, "%-7s ", "int");
			else if (l->st_type == FLOAT)
				fprintf(of, "%-7s ", "float");
			else if (l->st_type == STRING)
				fprintf(of, "%-7s ", "string");
			else if (l->st_type == MATRIX)
				fprintf(of, "%-7s ", "matrix");
			else if (l->st_type == VOID)
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
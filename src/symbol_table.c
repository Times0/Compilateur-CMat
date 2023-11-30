#include "../include/symbol_table.h"
#include <stdio.h>
#include <stdlib.h>
#include "../include/cmat.tab.h"

__uint32_t current_scope = 0;

/* the hash table */
SymbolTable *symbol_table;
struct code * code;

void init_symbol_table()
{
	symbol_table = malloc(sizeof(SymbolTable));
	if(symbol_table == NULL)
	{
		perror("Error malloc in init_symbol_table\n");
		exit(1);
	}
	symbol_table->symbols = malloc(SYMBOLTABLE_SIZE * sizeof(SymbolTableElement));
	symbol_table->temporary = 0;
	symbol_table->capacity = SYMBOLTABLE_SIZE;
	if(symbol_table->symbols == NULL)
	{
		perror("Error malloc in init_symbol_table\n");
		exit(1);
	}

	for(__uint32_t i = 0; i < SYMBOLTABLE_SIZE; i++)
		symbol_table->symbols[i].name[0] = '\0';
}

__uint32_t hash(char *key)
{
    __uint32_t hashval = 0;
    for (; *key != '\0'; key++)
        hashval += *key;
    hashval += key[0] % 11 + (key[0] << 3) - key[0];
    return hashval % SYMBOLTABLE_SIZE;
}

SymbolTableElement* insert(char *name, __uint32_t len, __uint32_t type, __uint32_t lineno)
{
	__uint32_t hashval = hash(name);
	SymbolTableElement l = symbol_table->symbols[hashval];

	/* variable not yet in table */
	if (l.name[0] == '\0')
	{
		strncpy(l.name, name, len);
		/* add to hashtable */
		l.type = type;
		l.scopes = (ScopeList *)malloc(sizeof(ScopeList));
		l.lines = (LineList *)malloc(sizeof(LineList));
		if(l.lines == NULL|| l.scopes == NULL)
		{
			perror("Error malloc in insert\n");
			exit(1);
		}
		l.lines->lineno = lineno;
		l.lines->next = NULL;
		symbol_table->symbols[hashval] = l;
	}
	/* found in table, so just add line number */
	else
	{
		LineList *t = l.lines;
		while (t->next != NULL)
			t = t->next;
		/* add linenumber to reference list */
		t->next = (LineList *)malloc(sizeof(LineList));
		t->next->lineno = lineno;
		t->next->next = NULL;
	}
	return &(symbol_table->symbols[hashval]);
}

SymbolTableElement* lookup(char *name)
{ /* return symbol if found or NULL if not found */
	__uint32_t hashval = hash(name);
	return &(symbol_table->symbols[hashval]);
}

SymbolTableElement* lookup_scope(char *name, __uint32_t scope)
{ /* return symbol if found or NULL if not found */
	__uint32_t hashval = hash(name);
	return &(symbol_table->symbols[hashval]);
}

void decr_scope()
{
	// if (current_scope > 0)
		current_scope--;
}

void incr_scope()
{
	current_scope++;
}

void add_type(char *name, __uint32_t type)
{
	__uint32_t hashval = hash(name);
	SymbolTableElement l = symbol_table->symbols[hashval];
	
	if (l.name[0] != '\0')
		if(l.type == UNDEF)
			l.type = type;
}

void add_scope(char *name, __uint32_t scope)
{
	__uint32_t hashval = hash(name);
	SymbolTableElement l = symbol_table->symbols[hashval];
	
	if (l.name[0] != '\0')
		if(l.type == UNDEF)
			l.type = 0;
}

/* print to stdout by default */
void symbol_table_dump(FILE *of)
{
	__uint32_t i;
	fprintf(of, "------------ ------- ------- ---------------\n");
	fprintf(of, "Name         Type    Scope    Line Numbers   \n");
	fprintf(of, "------------ ------- ------- ---------------\n");
	for (i = 0; i < SYMBOLTABLE_SIZE; ++i)
	{
		if(symbol_table->symbols[i].name[0] == '\0')
			continue;

		SymbolTableElement elem = symbol_table->symbols[i];

			LineList *line = elem.lines;
			ScopeList *scope = elem.scopes;

			fprintf(of, "%-12s ", elem.name);
			
			if (elem.type == INT)
				fprintf(of, "%-7s ", "int");
			else if (elem.type == FLOAT)
				fprintf(of, "%-7s ", "float");
			else if (elem.type == STRING)
				fprintf(of, "%-7s ", "string");
			else if (elem.type == MATRIX)
				fprintf(of, "%-7s ", "matrix");
			else if (elem.type == VOID)
				fprintf(of, "%-7s ", "void");
			else
				fprintf(of, "%-7s ", "undef"); // if UNDEF
			
			
			while (scope != NULL)
			{
				fprintf(of, "%-4d ", scope->scope);
				scope = scope->next;
			}
			
			while (line != NULL)
			{
				fprintf(of, "%4d ", line->lineno);
				line = line->next;
			}
			
			fprintf(of, "\n");
		
	}
}

void symbol_dump(SymbolTableElement *e)
{
	if (e->name[0] == '\0')
		return;
	printf("%s", e->name);
}


void free_symbol_table()
{
	__uint32_t i;
	for (i = 0; i < SYMBOLTABLE_SIZE; ++i)
	{
		if(symbol_table->symbols[i].name[0] == '\0')
			continue;

		SymbolTableElement l = symbol_table->symbols[i];
			
		LineList *t = l.lines;
		while (t != NULL)
		{
			LineList *temp = t;
			t = t->next;
			free(temp);
		}
	}
	free(symbol_table);
}
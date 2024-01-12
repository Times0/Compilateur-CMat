#include "../include/symbol_table.h"
#include <stdio.h>
#include <stdlib.h>
#include "../include/cmat.tab.h"

extern __uint32_t current_scope;
extern __uint32_t lineno;

SymbolTable *symbol_table;

void init_symbol_table(SymbolTable **s, __uint32_t scope)
{
	*s = malloc(sizeof(SymbolTable));
	if (*s == NULL)
	{
		perror("Error malloc in init_symbol_table\n");
		exit(1);
	}
	(*s)->first_symbol = malloc(sizeof(SymbolTableElement));
	if ((*s)->first_symbol == NULL)
	{
		perror("Error malloc in init_symbol_table\n");
		exit(1);
	}
	(*s)->temporary = 0;
	(*s)->size = 1;    // first symbol is reserved for the table itself
	(*s)->nb_variable = 0;
	(*s)->scope = scope;
	(*s)->next = NULL;
	(*s)->previous = NULL;
	
}

void push_predefined_functions(SymbolTable **s)
{
	SymbolTableElement *l1, *l2, *l3;
	l1 = malloc(sizeof(SymbolTableElement));
	l2 = malloc(sizeof(SymbolTableElement));
	l3 = malloc(sizeof(SymbolTableElement));
	if(l1 == NULL || l2 == NULL || l3 == NULL)
	{
		printf("Error malloc in push_predefined_functions\n");
		exit(1);
	}
	l1->class = VARIABLE; l1->type = VOID;
	l2->class = STR; l2->type = VOID;
	l3->class = ARRAY; l3->type = MATRIX; l3->attribute.array.size[0] = 0;l3->attribute.array.size[1] = 0;
	
	SymbolTableElement **ll1, **ll2, **ll3;
	ll1 = malloc(sizeof(SymbolTableElement*));
	ll2 = malloc(sizeof(SymbolTableElement*));
	ll3 = malloc(sizeof(SymbolTableElement*));
	if(ll1 == NULL || ll2 == NULL || ll3 == NULL)
	{
		printf("Error malloc in push_predefined_functions\n");
		exit(1);
	}
	ll1[0] = l1;ll2[0] = l2;ll3[0] = l3;

	insert_function(&symbol_table, "print", VOID, 1, ll1, -1, -1);
    insert_function(&symbol_table, "printf", VOID, 1, ll2, -1, -1);
	insert_function(&symbol_table, "printmat", VOID, 1, ll3, -1, -1);
	insert_constant(&symbol_table, (Constant){.int_value = 0, .float_value = 0.0f}, INT);
	insert_constant(&symbol_table, (Constant){.int_value = 1, .float_value = 1.0f}, INT);
	insert_constant(&symbol_table, (Constant){.int_value = 4, .float_value = 4.0f}, INT);
	insert_variable(symbol_table, "$fp", INT, VARIABLE, NULL, -1, 0);
}

SymbolTable* add_next_symbol_table(SymbolTable **s, __uint32_t scope, __uint32_t parent_symbol_table_scope)
{
	SymbolTable *tmp = *s;

    SymbolTable *new;
    init_symbol_table(&new, scope);

    while (tmp->next != NULL)
        tmp = tmp->next;

    new->previous = get_symbol_table_by_scope(*s, parent_symbol_table_scope);
    tmp->next = new;

    return new;
}

SymbolTable *get_last_symbol_table(SymbolTable *s)
{
	SymbolTable *tmp = s;
	
	while(tmp->next != NULL)
		tmp = tmp->next;
	
	return tmp;
}

SymbolTable *get_symbol_table_by_scope(SymbolTable *s, __uint32_t scope)
{
	SymbolTable *tmp = s;
	while(tmp != NULL && tmp->scope != scope)
		tmp = tmp->next;
	
	return tmp;
}

SymbolTableElement *get_function_by_scope(SymbolTable *s, __uint32_t scope)
{
	SymbolTable *tmp = get_symbol_table_by_scope(s, scope);
	
	// on remonte jusqu'a trouver la fonction
	while(tmp->scope != 0)
	{
		if(tmp->previous != NULL && tmp->previous->scope == 0)
			break;
		tmp = tmp->previous;
	}

	// on cherche la fonction dans la table de symbole
	SymbolTableElement *l = s->first_symbol;
	for(__uint32_t i = 0; i < s->size; i++)
	{
		if(l->class == FUNCTION)
			if(l->attribute.function.scope == tmp->scope)
				return l;
		l = l->next;
	}
	return NULL;
}

SymbolTableElement *insert_variable(SymbolTable *s, const char *name, __uint32_t type, __uint32_t class, __uint32_t size[2], __int32_t adress, __uint32_t scope)
{
	SymbolTableElement *l = lookup_variable(s, name, scope, class, 1);

	SymbolTable *tmp = s;

	// si la variable avec le bon scope n'existe pas on la cree
	if (l == NULL)
	{
		// on cherche la table de symbole qui correspond au scope
		while((s) != NULL && (s)->scope != scope)
			(s) = (s)->next;
		
		l = malloc(sizeof(SymbolTableElement));
		if (l == NULL)
		{
			perror("Error malloc in insert_variable\n");
			exit(1);
		}
		get_symbol(s, (s)->size-1)->next = l;
		l->next = NULL;
		
		if(class == VARIABLE)
		{
			strncpy(l->attribute.variable.name, name, MAXTOKENLEN);
			l->attribute.variable.adress = adress;
			l->class = VARIABLE;
			l->type = type;
			s->nb_variable++;
		}
		else if(class == ARRAY)
		{
			strncpy(l->attribute.array.name, name, MAXTOKENLEN);
			l->attribute.array.adress = adress;
			l->attribute.array.size[0] = size[0];
			l->attribute.array.size[1] = size[1];
			l->class = ARRAY;		
			l->type = type;
			s->nb_variable+=size[0]*size[1];
		}

		s->size++;
		s = tmp;
		
	}
	return l;
}

SymbolTableElement *insert_function(SymbolTable **s, const char *name, __uint32_t type, __uint32_t nb_paramaters, SymbolTableElement **parameters, __int32_t label, __uint32_t scope)
{
	SymbolTableElement *l = lookup_function(*s, name);
	if (l == NULL)
	{
		l = malloc(sizeof(SymbolTableElement));
		if (l == NULL)
		{
			perror("Error malloc in insert_function\n");
			exit(1);
		}
		get_symbol(*s, (*s)->size-1)->next = l;
		l->next = NULL;

		strncpy(l->attribute.function.name, name, MAXTOKENLEN);
		l->attribute.function.nb_parameters = nb_paramaters;
		l->attribute.function.parameters = parameters;
		
		/* l->attribute.function.parameters_type = malloc(nb_paramaters * sizeof(__uint32_t));
		if(l->attribute.function.parameters_type == NULL)
		{
			perror("Error malloc in insert_function\n");
			exit(1);
		}
		for (int i = 0; i < nb_paramaters; i++)
		{
			l->attribute.function.parameters_type[i].class = parameters_type[i].class;
			l->attribute.function.parameters_type[i].type = parameters_type[i].type;
		}*/
		
		l->class = FUNCTION;
		l->type = type;
		l->attribute.function.label = label;
		l->attribute.function.scope = scope;
		(*s)->size++;
	}
	return l;
}

SymbolTableElement *insert_constant(SymbolTable **s, Constant constant, __uint32_t type)
{
	SymbolTableElement *l = lookup_constant(*s,constant, type);
	if (l == NULL)
	{
		l = malloc(sizeof(SymbolTableElement));
		if (l == NULL)
		{
			perror("Error malloc in insert_constant\n");
			exit(1);
		}
		get_symbol(*s, (*s)->size-1)->next = l;
		l->next = NULL;
			
		l->attribute.constant.int_value = constant.int_value;	
		l->attribute.constant.float_value = constant.float_value;

		l->class = CONSTANT;
		l->type = type;
		++((*s)->size);
	}
	return l;
}

SymbolTableElement *insert_string(SymbolTable *s, const char *string, __uint32_t adress)
{
	// SymbolTableElement *l = lookup_string(s, string);
	SymbolTableElement* l = malloc(sizeof(SymbolTableElement));
	if (l == NULL)
	{
		perror("Error malloc in insert_string\n");
		exit(1);
	}
	get_symbol(s, (s)->size-1)->next = l;
	l->next = NULL;
	
	strncpy(l->attribute.string.string, string, MAXSTRLEN);
	l->attribute.string.adress = adress + strlen(string) + 1; // Car l'offset sur a0 va dans les positifs et ecrase les variables dans la stack
	l->class = STR;
	l->type = STRING;
	s->size++;
	return l;
}

SymbolTableElement *get_symbol(SymbolTable *s, __uint32_t i)
{		
	SymbolTableElement *l = s->first_symbol;
	for(__uint32_t j =0; j<i; j++)
		l = l->next;
	return l;
}

/* return symbol if found or NULL if not found */
SymbolTableElement *lookup_variable(SymbolTable *s, const char *name, __uint32_t scope, __uint32_t class, __uint32_t exact_scope)
{
	SymbolTable *tmp = s;

	// on cherche la table de symbole qui correspond au scope
	while(tmp != NULL && tmp->scope != scope)
		tmp = tmp->next;
	
	if(tmp == NULL)
		return NULL;
		

	// on parcourt les tables de symboles en remontant dans les scopes jusqu'a trouver la variable
	while(tmp != NULL)
	{
		__uint32_t i;
		SymbolTableElement *l = tmp->first_symbol;

		for (i = 0; i < tmp->size; i++)
		{
			// on doit verifier le type car il ya des constantes, des strings et des fonctions dans la table des symboles de cscope 0
			if(l->class == VARIABLE || l->class == ARRAY)
			{
				if(strcmp(l->attribute.variable.name, name) == 0)
					break;
			}
			l = l->next;
			
		} 
				
		if (i < tmp->size)
			return l;
		
		if(exact_scope == 1)
			break; // on s'arrete si on veut trouver la variable dans le scope courant (pour les variables globales

		tmp = tmp->previous;
	}

	return NULL;
}

SymbolTableElement *lookup_function(SymbolTable *s, const char *name)
{
	__uint32_t i;
	SymbolTableElement *l = s->first_symbol;
	for (i = 0; i < s->size; i++)
	{
		if (l->class == FUNCTION)
			if (strcmp(l->attribute.function.name, name) == 0)
				break;
		l = l->next;
	}
	if (i < s->size)
		return l;
	return NULL;
}

/* return symbol if found or NULL if not found */
SymbolTableElement *lookup_constant(SymbolTable *s, Constant constant, __uint32_t type)
{
	SymbolTableElement *l = s->first_symbol;
	if (type == INT)
	{
		__uint32_t i;
		for (i = 0; i < s->size; i++)
		{
			if (l->class == CONSTANT)
				if (l->attribute.constant.int_value == constant.int_value)
					if(l->type == INT) // obligatoire a cause du float_value qui est remplie
						break;
			l = l->next;
		}
		if (i < s->size)
			return l;
		return NULL;
	}
	else if (type == FLOAT)
	{
		__uint32_t i;
		for (i = 0; i < s->size; i++)
		{
			if (l->class == CONSTANT)
				if (l->attribute.constant.float_value == constant.float_value)
					if(l->type == FLOAT) // obligatoire a cause du int_value qui est remplie
						break;
			l = l->next;
		}
		if (i < s->size)
			return l;
		return NULL;
	}
}

SymbolTableElement *lookup_string(SymbolTable *s, char *string)
{
	__uint32_t i;
	SymbolTableElement *l = s->first_symbol;
	for (i = 0; i < s->size; i++)
	{
		if (l->class == STR)
			if (strcmp(l->attribute.string.string, string) == 0)
				break;
		l = l->next;
	}
	if (i < s->size)
		return l;
	return NULL;
}

/* print to stdout by default */
void symbol_table_dump(SymbolTable *s, FILE *of)
{
	SymbolTable *tmp = s;
		
	__uint32_t i;
	fprintf(of, "-------------- ----------- ---------- -------- ---------------\n");
	fprintf(of, "     Name         Class       Type      size 	arguments   \n");
	fprintf(of, "                                          		or scope   \n");
	fprintf(of, "-------------- ----------- ---------- -------- ---------------\n");
	__uint32_t nb_cst = 0;
	__uint32_t nb_str = 0;
	
	while(tmp != NULL)
	{
		for (i = 1; i < tmp->size; ++i)
		{
			SymbolTableElement *elem = get_symbol(tmp, i);

			if (elem->class == CONSTANT)
			{
				nb_cst++;
				continue;
			}
			else if (elem->class == STR)
			{
				nb_str++;
				continue;
			}

			const char *typeStr = "";
			switch (elem->type)
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
			switch (elem->class)
			{
			case VARIABLE:
				classStr = "variable";
				break;
			case FUNCTION:
				classStr = "function";
				break;
			case ARRAY:
				classStr = "array";
				break;
			}

			if(elem->class == FUNCTION)
			{
				fprintf(of, "%-14s %-11s %-19s (", elem->attribute.function.name, classStr, typeStr);
				for(int j = 0; j < elem->attribute.function.nb_parameters; j++)
				{
					switch (elem->attribute.function.parameters[j]->class)
					{
					case STR:
						fprintf(of, "string");
						break;
					case VARIABLE:
						switch (elem->attribute.function.parameters[j]->type)
						{
							case INT:
								fprintf(of, "int");
							break;
							case FLOAT:
								fprintf(of, "float");
							break;
							case VOID:
								fprintf(of, "void*");
							break;
						}
						break;
					case ARRAY:
						switch (elem->attribute.function.parameters[j]->type)
						{
							case INT:
								fprintf(of, "int");
							case FLOAT:
								fprintf(of, "float");
							break;
							case MATRIX:
								fprintf(of, "matrix");
							break;
						}

						if(elem->attribute.function.parameters[j]->attribute.array.size[0] != 0)
							fprintf(of, "[%d]", elem->attribute.function.parameters[j]->attribute.array.size[0]);
						if(elem->attribute.function.parameters[j]->attribute.array.size[1] != 0)
							fprintf(of, "[%d]", elem->attribute.function.parameters[j]->attribute.array.size[1]);
						break;
					}
					if(j < elem->attribute.function.nb_parameters - 1)
						fprintf(of, ", ");
				}
				fprintf(of, ")\n");
			}
			else if(elem->attribute.variable.name[0] != '%')
			{
				if(elem->class == VARIABLE)
					fprintf(of, "%-14s %-11s %-10s %10d\n", elem->attribute.variable.name, classStr, typeStr, tmp->scope);
				if(elem->class == ARRAY)
					fprintf(of, "%-14s %-11s %-10s %-2dx%2d %4d\n", elem->attribute.array.name, classStr, typeStr, elem->attribute.array.size[0], elem->attribute.array.size[1], tmp->scope);
			}
		}
		tmp = tmp->next;
	}
	fprintf(of, "-------------- ----------- ---------- -------- ---------------\n");
	fprintf(of, "Number of constants: %d\n", nb_cst);
	fprintf(of, "Number of strings: %d\n", nb_str);
}

void symbol_dump(SymbolTableElement *e, __uint32_t by_adress)
{
	if (e->class == VARIABLE)
		if(by_adress)
			printf("[%s]", e->attribute.variable.name);
		else
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
	else if(e->class == ARRAY)
		if(by_adress)
			printf("[%s]", e->attribute.array.name);
		else
			printf("%s", e->attribute.array.name);
}

SymbolTableElement *newtemp(SymbolTable *t, __uint32_t class, __uint32_t type, __int32_t offset, __uint32_t size[2])
{
    SymbolTableElement *s;
    char name[MAXTOKENLEN];
    if(class == VARIABLE || class == ARRAY)
	{
		sprintf(name,"%%%d",t->temporary);
    	s = insert_variable(t, name, type, class, size, offset, current_scope);
    	++(t->temporary);
    	return s;
	}
	
}

void free_symbol_table(SymbolTable *s)
{
	free(s->first_symbol);
	free(s);
}
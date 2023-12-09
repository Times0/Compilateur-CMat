#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "quad.h"
#include "../include/cmat.tab.h"

__uint32_t label_counter = 0;     // compteur pour les labels
QuadTable *code;

// il est important d'initialiser les labels a -1 car on va les modifier avant que le quad soit crée.
// cela peut causer de segfault si on essaye de completer un quad alors qu'on est en limite de capacité

QuadTable *code_new()
{
    QuadTable *r = malloc(sizeof(QuadTable));
    if(r == NULL)
    {
        fprintf(stderr, "Error malloc in code_new");
        exit(1);
    }
    r->capacity = 256;
    r->quads = calloc(r->capacity,sizeof(Quad));
    if(r->quads == NULL)
    {
        fprintf(stderr, "Error malloc in code_new");
        exit(1);
    }
    for(int i = 0; i < r->capacity; i++)
    {
        r->quads[i].sym1 = NULL;
        r->quads[i].sym2 = NULL;
        r->quads[i].sym3 = NULL;
        r->quads[i].function_parameters = NULL;
        r->quads[i].nb_parameters = 0;
        r->quads[i].branch_label = -1;
        r->quads[i].label = -1;
    }
    
    r->nextquad = 0;
    r->main_quad = -1;
    return r;
}

void code_grow(QuadTable **c)
{
    (*c)->capacity += 1024;
    (*c)->quads = realloc((*c)->quads,(*c)->capacity*sizeof(Quad));
    if((*c)->quads == NULL) 
    {
        fprintf(stderr,"Error attempting to grow quad list (actual size is %d)\n",(*c)->nextquad);
            exit(1);
    }

    for(int i = (*c)->nextquad; i < (*c)->capacity; i++)
    {
        (*c)->quads[i].sym1 = NULL;
        (*c)->quads[i].sym2 = NULL;
        (*c)->quads[i].sym3 = NULL;
        (*c)->quads[i].function_parameters = NULL;
        (*c)->quads[i].nb_parameters = 0;
        (*c)->quads[i].branch_label = -1;
        (*c)->quads[i].label = -1;
    }
}

void gen_quad(QuadTable *c, enum quad_kind k, SymbolTableElement * s1, SymbolTableElement * s2, SymbolTableElement * s3, __uint32_t by_adress[3])
{
    if ( c->nextquad == c->capacity )
        code_grow(&c);

    Quad *q = &(c->quads[c->nextquad]);
    q->kind = k;
    q->sym1 = s1;
    q->sym2 = s2;
    q->sym3 = s3;
    q->by_adress[0] = by_adress[0];
    q->by_adress[1] = by_adress[1];
    q->by_adress[2] = by_adress[2];
    
    c->nextquad++;
}

void gen_quad_goto(QuadTable *c, enum quad_kind k, SymbolTableElement * s1, SymbolTableElement * s2, __int32_t label)
{
    if ( c->nextquad == c->capacity )
        code_grow(&c);

    Quad *q = &(c->quads[c->nextquad]);
    q->kind = k;
    q->sym2 = s1;
    q->sym3 = s2;
    q->branch_label = label;
    c->nextquad++;
}

void gen_quad_function(QuadTable *c, enum quad_kind k, SymbolTableElement * result, SymbolTableElement * function, SymbolTableElement ** parameters, __uint32_t nb_parameters, __uint32_t *by_address)
{
    if(c->nextquad == c->capacity)
        code_grow(&c);

    Quad *q = &(c->quads[c->nextquad]);
    q->kind = k;
    q->sym1 = result;
    q->sym2 = function;
    q->function_parameters = parameters;
    q->nb_parameters = nb_parameters;
    q->by_address_list = by_address;
    c->nextquad++;
}

char* generate_label()
{
    char* label = (char*)malloc(snprintf(NULL, 0, "%d", label_counter) + 7); // taille de base + taille du compteur + 1 pour le \0
    if(label == NULL)
    {
        fprintf(stderr, "Error malloc in generate_label");
        exit(1);
    }
    sprintf(label, "Label_%d", label_counter);
    label_counter++;

    return label;
}

char *generate_label_with_nb(__uint32_t nb)
{
    char* label = (char*)malloc(snprintf(NULL, 0, "%d", nb) + 7); // taille de base + taille du compteur + 1 pour le \0
    if(label == NULL)
    {
        fprintf(stderr, "Error malloc in generate_label");
        exit(1);
    }
    sprintf(label, "Label_%d", nb);

    return label;
}

// create a list with one element and a sentinel
__int32_t *create_list(__int32_t i)
{
    if(i == -1)
    {
        __int32_t *r = malloc(sizeof(__int32_t));
        if(r == NULL)
        {
            fprintf(stderr, "Error malloc in create_list");
            exit(1);
        }
        r[0] = -1;
        return r;
    }
    
    __int32_t *r = malloc(2*sizeof(__int32_t));
    if(r == NULL)
    {
        fprintf(stderr, "Error malloc in create_list");
        exit(1);
    }
    r[0] = i;
    r[1] = -1;
    // printf("create list %d\n", i);
    return r;
}

__int32_t *concat_list(__int32_t *l1, __int32_t *l2)
{
    __int32_t size1 = 0;
    if(l1 == NULL)
        l1 = create_list(-1);
    while(l1[size1] != -1)
        size1++;
    __int32_t size2 = 0;
    if(l2 == NULL)
        l2 = create_list(-1);
    while(l2[size2] != -1)
        size2++;

    __int32_t *r = malloc(size1+size2+1);
    if(r == NULL)
    {
        fprintf(stderr, "Error malloc in concat_list");
        exit(1);
    }

    __int32_t i = 0;
    while(l1[i] != -1)
    {
        r[i] = l1[i];
        i++;
    }
    __int32_t j = 0;
    while(l2[j] != -1)
    {
        r[i+j] = l2[j];
        j++;
    }
    r[i+j] = -1;

    // printf("concat list %d %d\n", size1, size2);


    free(l1);
    free(l2);
    return r;
}

void complete_list(__int32_t *l, __int32_t i)
{
    // printf("complete list %p with %d\n", l, i);
    if(l == NULL)
    {
        // printf("comple nul\n");
        return;
    }
    if(l[0] == -1)
    {
        // printf("complete -1 with %d\n", i);
        return;
    }

    code->quads[i].label = i;
    printf("complete list %d with %d\n", l[0], i);


    // printf("complete list %d with %d\n", l[0], i);
    __int32_t j = 0;
    
    while(l[j] != -1)
    {
        if(code->quads[l[j]].branch_label == -1)
            code->quads[l[j]].branch_label = i;
        j++;
    }   
}

void quad_dump(Quad *q)
{
    char *l = NULL;
    if(q->branch_label != -1)
        l = generate_label_with_nb(q->branch_label);

    switch ( q->kind )
    {
        case BOP_PLUS:
            symbol_dump(q->sym1, q->by_adress[0]);
            printf(" := ");
            symbol_dump(q->sym2, 0);
            printf(" + ");
            symbol_dump(q->sym3, 0);
            break;
        case BOP_MINUS:
            symbol_dump(q->sym1, q->by_adress[0]);
            printf(" := ");
            symbol_dump(q->sym2, 0);
            printf(" - ");
            symbol_dump(q->sym3, 0);
            break;
        case BOP_MULT:
            symbol_dump(q->sym1, q->by_adress[0]);
            printf(" := ");
            symbol_dump(q->sym2, 0);
            printf(" * ");
            symbol_dump(q->sym3, 0);
            break;
        case BOP_DIV:
            symbol_dump(q->sym1, q->by_adress[0]);
            printf(" := ");
            symbol_dump(q->sym2, 0);
            printf(" / ");
            symbol_dump(q->sym3, 0);
            break;
        case BOP_MOD:
            symbol_dump(q->sym1, q->by_adress[0]);
            printf(" := ");
            symbol_dump(q->sym2, 0);
            printf(" %% ");
            symbol_dump(q->sym3, 0);
            break;
        case UOP_MINUS:
            symbol_dump(q->sym1, q->by_adress[0]);
            printf(" := ");
            printf("- ");
            symbol_dump(q->sym2, 0);
            break;
        case K_CALL_PRINT:
        case K_CALL_PRINTF:
        case K_CALL_PRINTMAT:
            printf("%s (", q->sym2->attribute.function.name);
            for(int i = q->nb_parameters - 1; i >= 0; i--)
            {
                symbol_dump(q->function_parameters[i], q->by_address_list[i]);
                if(i > 0)
                    printf(", ");
            }
            printf(")");
            break;
        case K_COPY:
            symbol_dump(q->sym1, q->by_adress[0]);
            printf(" = ");
            symbol_dump(q->sym2, 0);
            break;
        case K_GOTO:
            printf("goto %s", l);
            break;
        case K_IF:
            printf("if ");
            symbol_dump(q->sym2, 0);
            printf(" == ");
            symbol_dump(q->sym3, 0);
            printf(" goto %s", l);
            break;
        case K_IFNOT:
            printf("if ");
            symbol_dump(q->sym2, 0);
            printf(" != ");
            symbol_dump(q->sym3, 0);
            printf(" goto %s", l);
            break;
        case K_IFLT:
            printf("if ");
            symbol_dump(q->sym2, 0);
            printf(" < ");
            symbol_dump(q->sym3, 0);
            printf(" goto %s", l);
            break;
        case K_IFGT:
            printf("if ");
            symbol_dump(q->sym2, 0);
            printf(" > ");
            symbol_dump(q->sym3, 0);
            printf(" goto %s", l);
            break;
        case K_IFLE:
            printf("if ");
            symbol_dump(q->sym2, 0);
            printf(" <= ");
            symbol_dump(q->sym3, 0);
            printf(" goto %s", l);
            break;
        case K_IFGE:
            printf("if ");
            symbol_dump(q->sym2, 0);
            printf(" >= ");
            symbol_dump(q->sym3, 0);
            printf(" goto %s", l);
            break;
        default:
            printf("BUG\n");
            break;
    }
    if(l != NULL)
        free(l);
}

void code_dump(QuadTable *c)
{
    unsigned int i;
    for ( i=0 ; i<c->nextquad ; i++ )
    {
        printf("%4u | ",i);
        quad_dump(&(c->quads[i]));
        printf("\n");
    }
}

void code_free(QuadTable *c)
{
    free(c->quads);
    free(c);
}



#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "quad.h"
#include "../include/cmat.tab.h"

__uint32_t label_counter = 0;     // compteur pour les labels
QuadTable *code;

QuadTable *code_new()
{
    QuadTable *r = malloc(sizeof(QuadTable));
    if(r == NULL)
    {
        fprintf(stderr, "Error malloc in code_new");
        exit(1);
    }
    r->capacity = 256;
    r->quads = malloc(r->capacity*sizeof(Quad));
    if(r->quads == NULL)
    {
        fprintf(stderr, "Error malloc in code_new");
        exit(1);
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
}

void gen_quad(QuadTable *c, enum quad_kind k, SymbolTableElement * s1, SymbolTableElement * s2, SymbolTableElement * s3)
{
    if ( c->nextquad == c->capacity )
        code_grow(&c);

    Quad *q = &(c->quads[c->nextquad]);
    q->kind = k;
    q->sym1 = s1;
    q->sym2 = s2;
    q->sym3 = s3;
    q->function_parameters = NULL;
    q->nb_parameters = 0;
    q->is_branched = 0;
    q->branch_label = NULL;
    c->nextquad++;
}

void gen_quad_goto(QuadTable *c, enum quad_kind k, SymbolTableElement * s1, SymbolTableElement * s2, char *label)
{
    if ( c->nextquad == c->capacity )
        code_grow(&c);

    Quad *q = &(c->quads[c->nextquad]);
    q->kind = k;
    q->sym1 = NULL;
    q->sym2 = s1;
    q->sym3 = s2;
    q->function_parameters = NULL;
    q->nb_parameters = 0;
    q->is_branched = 0;
    q->branch_label = label;
    c->nextquad++;
}

void gen_quad_function(QuadTable *c, enum quad_kind k, SymbolTableElement * result, SymbolTableElement * function, SymbolTableElement ** parameters, __uint32_t nb_parameters)
{
    if(c->nextquad == c->capacity)
        code_grow(&c);

    Quad *q = &(c->quads[c->nextquad]);
    q->kind = k;
    q->sym1 = result;
    q->sym2 = function;
    q->sym3 = NULL;
    q->function_parameters = parameters;
    q->nb_parameters = nb_parameters;
    q->is_branched = 0;
    q->branch_label = NULL;
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
__uint32_t *create_list(__uint32_t i)
{
    __uint32_t *r = malloc(2*sizeof(__uint32_t));
    if(r == NULL)
    {
        fprintf(stderr, "Error malloc in create_list");
        exit(1);
    }
    r[0] = i;
    r[1] = -1;
    printf("create list %d\n", i);
    return r;
}

__uint32_t *concat_list(__uint32_t *l1, __uint32_t *l2)
{
    __uint32_t size1 = 0;
    // if(l1 == NULL)
    //     l1 = create_list(-1);
    while(l1[size1] != -1)
        size1++;
    __uint32_t size2 = 0;
    // if(l2 == NULL)
    //     l2 = create_list(-1);
    while(l2[size2] != -1)
        size2++;

    __uint32_t *r = malloc(size1+size2+1);
    if(r == NULL)
    {
        fprintf(stderr, "Error malloc in concat_list");
        exit(1);
    }

    __uint32_t i = 0;
    while(l1[i] != -1)
    {
        r[i] = l1[i];
        i++;
    }
    __uint32_t j = 0;
    while(l2[j] != -1)
    {
        r[i+j] = l2[j];
        j++;
    }
    r[i+j] = -1;

    printf("concat list %d %d\n", size1, size2);


    free(l1);
    free(l2);
    return r;
}

void complete_list(__uint32_t *l, __uint32_t i)
{
    if(l == NULL)
    {
        printf("comple nul\n");
        return;
    }
    if(l[0] == -1)
    {
        printf("complete -1\n");
        return;
    }
    code->quads[i].is_branched = 1;
    code->quads[i].branch_label = generate_label_with_nb(i);

    printf("complete list %d with %d\n", l[0], i);
    __uint32_t j = 0;
    
    while(l[j] != -1)
    {
        code->quads[l[j]].branch_label = generate_label_with_nb(i);
        j++;
    }   
}

void quad_dump(Quad *q)
{
    switch ( q->kind )
    {
        case BOP_PLUS:
            symbol_dump(q->sym1);
            printf(" := ");
            symbol_dump(q->sym2);
            printf(" + ");
            symbol_dump(q->sym3);
            break;
        case BOP_MINUS:
            symbol_dump(q->sym1);
            printf(" := ");
            symbol_dump(q->sym2);
            printf(" - ");
            symbol_dump(q->sym3);
            break;
        case BOP_MULT:
            symbol_dump(q->sym1);
            printf(" := ");
            symbol_dump(q->sym2);
            printf(" * ");
            symbol_dump(q->sym3);
            break;
        case BOP_DIV:
            symbol_dump(q->sym1);
            printf(" := ");
            symbol_dump(q->sym2);
            printf(" / ");
            symbol_dump(q->sym3);
            break;
        case BOP_MOD:
            symbol_dump(q->sym1);
            printf(" := ");
            symbol_dump(q->sym2);
            printf(" %% ");
            symbol_dump(q->sym3);
            break;
        case BOP_OR:
            symbol_dump(q->sym1);
            printf(" := ");
            symbol_dump(q->sym2);
            printf(" || ");
            symbol_dump(q->sym3);
            break;
        case BOP_AND:
            symbol_dump(q->sym1);
            printf(" := ");
            symbol_dump(q->sym2);
            printf(" && ");
            symbol_dump(q->sym3);
            break;
        case BOP_EQ:
            symbol_dump(q->sym1);
            printf(" := ");
            symbol_dump(q->sym2);
            printf(" == ");
            symbol_dump(q->sym3);
            break;
        case BOP_NEQ:
            symbol_dump(q->sym1);
            printf(" := ");
            symbol_dump(q->sym2);
            printf(" != ");
            symbol_dump(q->sym3);
            break;
        case UOP_MINUS:
            symbol_dump(q->sym1);
            printf(" := ");
            printf("- ");
            symbol_dump(q->sym2);
            break;
        case UOP_NOT:
            symbol_dump(q->sym1);
            printf(" := ");
            printf("! ");
            symbol_dump(q->sym2);
            break;
        case K_CALL_PRINT:
            printf("print (");
            for(int i = q->nb_parameters - 1; i >= 0; i--)
            {
                symbol_dump(q->function_parameters[i]);
                if(i > 0)
                    printf(", ");
            }
            printf(")");
            break;
        case K_CALL_PRINTF:
            printf("printf (");
            for(int i = q->nb_parameters - 1; i >= 0; i--)
            {
                symbol_dump(q->function_parameters[i]);
                if(i > 0)
                    printf(", ");
            }
            printf(")");
            break;
        case K_COPY:
            symbol_dump(q->sym1);
            printf(" = ");
            symbol_dump(q->sym2);
            break;
        case K_GOTO:
            printf("goto %s", q->branch_label);
            break;
        case K_IF:
            printf("if ");
            symbol_dump(q->sym2);
            printf(" goto %s", q->branch_label);
            break;
        default:
            printf("BUG\n");
            break;
    }
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



#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "quad.h"
#include "../include/cmat.tab.h"

extern __uint32_t current_scope;

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
    c->nextquad++;
}

SymbolTableElement *newtemp(SymbolTable *t, __uint32_t type, __int32_t offset)
{
    SymbolTableElement *s;
    char name[MAXTOKENLEN];
    sprintf(name,"%%%d",t->temporary);
    s = insert_variable(t, name, type, VARIABLE, offset, current_scope);
    ++(t->temporary);
    return s;
}

static void quad_dump(Quad *q)
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
        case CALL_PRINT:
            printf("print (");
            for(int i = q->nb_parameters - 1; i >= 0; i--)
            {
                symbol_dump(q->function_parameters[i]);
                if(i > 0)
                    printf(", ");
            }
            printf(")");
            break;
        case CALL_PRINTF:
            printf("printf (");
            for(int i = q->nb_parameters - 1; i >= 0; i--)
            {
                symbol_dump(q->function_parameters[i]);
                if(i > 0)
                    printf(", ");
            }
            printf(")");
            break;
        case COPY:
            symbol_dump(q->sym1);
            printf(" = ");
            symbol_dump(q->sym2);
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



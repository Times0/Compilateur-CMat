#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "quad.h"

QuadTable *code_new()
{
    QuadTable *r = malloc(sizeof(QuadTable));
    r->capacity = 1024;
    r->quads = malloc(r->capacity*sizeof(QuadTable));
    r->nextquad = 0;
    return r;
}

static void code_grow(QuadTable *c)
{
    c->capacity += 1024;
    c->quads = realloc(c->quads,c->capacity*sizeof(QuadTable));
    if(c->quads == NULL) 
    {
      fprintf(stderr,"Error attempting to grow quad list (actual size is %d)\n",c->nextquad);
        exit(1);
    }
}

void gen_quad(QuadTable *c, enum quad_kind k, SymbolTableElement * s1, SymbolTableElement * s2, SymbolTableElement * s3)
{
    if ( c->nextquad == c->capacity )
        code_grow(c);

    Quad *q = &(c->quads[c->nextquad]);
    q->kind = k;
    q->sym1 = s1;
    q->sym2 = s2;
    q->sym3 = s3;
    c->nextquad++;
}

SymbolTableElement *newtemp(SymbolTable *t, __uint32_t type, __int32_t offset)
{
    SymbolTableElement *s;
    char name[MAXTOKENLEN];
    sprintf(name,"%%%d",t->temporary);
    s = insert(&t, name, type, VARIABLE, offset);
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
        case UOP_MINUS:
            symbol_dump(q->sym1);
            printf(" := ");
            printf("- ");
            symbol_dump(q->sym2);
            break;
        case CALL_PRINT:
            printf("print ");
            symbol_dump(q->sym1);
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



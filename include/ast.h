#ifndef AST_H
#define AST_H
#include <stdio.h>
#include <stdlib.h>

// Forward declaration of tree_t
typedef struct tree tree_t;

// Tree struct
struct tree
{
    char *type;
    char *name;
    int value;
    tree_t *left;
    tree_t *right;
};

tree_t *create_tree();

void add_operation(tree_t *root, char name);

void print_tree(tree_t *root, int level);

#endif
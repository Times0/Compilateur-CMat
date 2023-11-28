#include "ast.h"

tree_t *root;

tree_t *create_tree()
{
    tree_t *node = malloc(sizeof(tree_t));
    node->type = NULL;
    node->name = NULL;
    node->value = 0;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void print_tree(tree_t *root, int level)
{

    // print node (type, name, value)
    if (root->type != NULL)
    {
        for (int i = 0; i < level; i++)
        {
            printf(" |");
        }
        printf("type : %s\n", root->type);
    }
    if (root->name != NULL)
    {
        for (int i = 0; i < level; i++)
        {
            printf(" |");
        }
        printf("name : %s\n", root->name);
    }
    if (root->value != 0)
    {
        for (int i = 0; i < level; i++)
        {
            printf(" |");
        }
        printf("value : %d\n", root->value);
    }

    // print left child
    if (root->left != NULL)
    {
        print_tree(root->left, level + 1);
    }

    // print separator
    for (int i = 0; i < level; i++)
    {
        printf(" |");
    }
    printf("-----\n");

    // print right child
    if (root->right != NULL)
    {
        print_tree(root->right, level + 1);
    }
}
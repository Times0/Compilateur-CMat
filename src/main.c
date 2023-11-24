#include <unistd.h> // for getopt
#include <stdio.h>
#include <stdlib.h>
#include "../include/symbol_table.h"
#include "../include/cmat.lex.h"
#include "../include/cmat.tab.h"

#ifdef RELEASE

int verbose_flag = 0;

int main(int argc, char *argv[])
{
    int option;
    while ((option = getopt(argc, argv, "v")) != -1)
    {
        switch (option)
        {
        case 'v':
            verbose_flag = 1;
            break;
        default:
            fprintf(stderr, "Usage: %s file [-v]\n", argv[0]);
            exit(EXIT_FAILURE);
        }
    }

    if (optind >= argc)
    {
        fprintf(stderr, "Expected argument after options\n");
        exit(EXIT_FAILURE);
    }

    // set yyin to the file we want to parse
    if (!(yyin = fopen(argv[optind], "r")))
    {
        perror(argv[optind]);
        return 1;
    }

    if (verbose_flag)
        printf("-> Initializing hash table...\n");
    init_hash_table();

    if (verbose_flag)
        printf("-> Starting lexical analysis...\n");

    int r = yyparse();

    if (verbose_flag)
        printf("-> Lexical analysis finished with code %d\n", r);

    if (yyin != stdin)
        fclose(yyin);

    // Afficher la table des symboles
    if (!(yyout = fopen("symbol_table.txt", "w+")))
    {
        perror("symbol_table.txt");
        return 1;
    }

    symtab_dump(yyout);
    if (yyout != stdout)
        fclose(yyout);

    return 0;
}

#endif
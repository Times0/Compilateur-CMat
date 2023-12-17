#include <unistd.h> // for getopt
#include <stdio.h>
#include <stdlib.h>

#include "symbol_table.h"
#include "../include/quad.h"
#include "../include/mips.h"
#include "cmat.lex.h"
#include "cmat.tab.h"

extern SymbolTable *symbol_table;
extern QuadTable *code;

int main(int argc, char *argv[])
{
    
    uint32_t option;
    uint32_t verbose_flag = 0;
    uint32_t lex_only_flag = 0;
    char *output_file = NULL;

    // Checking for '-version' option in any position
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-version") == 0) {
            printf("CMat Compiler\n");
            printf("Developed by: Lucas DELETANG, Zaid GHALI, Dorian CHEVALÉRIAS, Oumarou MAIGA\n");
        }
    }

    while ((option = getopt(argc, argv, "Vlo")) != -1)
    {
        switch (option)
        {
            case 'V':
                verbose_flag = 1;
                break;
            case 'l':
                lex_only_flag = 1;
                break;
            case 'o':
                output_file = optarg;
                break;
            default:
                fprintf(stderr, "Usage: %s [-V] [-l] [-version] [-o <output_file_name>] file [-v]\\n", argv[0]);
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
        return 2;
    }

    if (verbose_flag)
        printf("-> Initializing symbol table...\n");
    
    init_symbol_table(&symbol_table, 0);
    push_predefined_functions(&symbol_table);
    code = code_new();

    if (lex_only_flag)
    {
        if (verbose_flag)
            printf("-> Starting lexical analysis...\n");

        int token = yylex();
        while (token)
        {
            token = yylex();
        }

        if(verbose_flag)
            printf("-> Lexical analysis finished\n");

        if (yyin != stdin)
            fclose(yyin);

        return 0;
    }

    if (verbose_flag)
        printf("-> Starting parsing...\n");

    int r = yyparse();

    code_dump(code);

    if (output_file != NULL) {
        FILE *ff = fopen(output_file, "w+");
        gencode_mips_global_variable(ff, symbol_table);
        gencode_mips(code, ff);
        fclose(ff);
    }
    else {
        FILE *ff = fopen("mips.s", "w+");
        gencode_mips_global_variable(ff, symbol_table);
        gencode_mips(code, ff);
        fclose(ff);
    }


    if (verbose_flag)
        printf("-> Finished parsing with error code : %d\n", r);

    if (yyin != stdin)
        fclose(yyin);

    // Afficher la table des symboles
    if (!(yyout = fopen("symbol_table.txt", "w+")))
    {
        perror("symbol_table.txt");
        return 1;
    }

    symbol_table_dump(symbol_table, yyout);
    
    if (yyout != stdout)
        fclose(yyout);

    free_symbol_table(symbol_table);

    return 0;
}

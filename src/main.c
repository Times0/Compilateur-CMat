#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <getopt.h>
#include <stdint.h>

#include "symbol_table.h"
#include "quad.h"
#include "mips.h"
#include "cmat.lex.h"
#include "cmat.tab.h"

extern SymbolTable *symbol_table;
extern QuadTable *code;

void show_options()
{
    printf("Usage: cmat [options] <file>\n");
    printf("Options:\n");
    printf("  -h \t\t show this help\n");
    printf("  -V \t\t verbose mode\n");
    printf("  -l: \t\t lex only\n");
    printf("  -o <file> \t specify the output file for the MIPS code\n");
    printf("  -version \t show who made this compiler\n");
    printf("  -tos \t\t show the symbol table at the end of the compilation\n");
}

void show_version()
{
    printf("CMat Compiler\n");
    printf("Made by: Lucas DELETANG, Zaid GHALI, Dorian CHEVALÉRIAS, Oumarou MAIGA\n");
    printf("Version: 1.0\n");
    exit(EXIT_SUCCESS);
}

static struct option long_options[] = {
    {"tos", no_argument, 0, 't'},
    {"version", no_argument, 0, 'v'},
    {"verbose", no_argument, 0, 'V'},
    {"lex-only", no_argument, 0, 'l'},
    {"output", required_argument, 0, 'o'},
    {"help", no_argument, 0, 'h'},
    {0, 0, 0, 0}};

int main(int argc, char *argv[])
{
    uint32_t option;
    uint32_t verbose_flag = 0;
    uint32_t lex_only_flag = 0;
    uint32_t tos_flag = 0;
    char *output_file = NULL;

    int option_index = 0;
    int c;

    while ((c = getopt_long(argc, argv, "hVlo:t", long_options, &option_index)) != -1)
    {
        switch (c)
        {
        case 'h':
            show_options();
            exit(EXIT_SUCCESS);
        case 'V':
            verbose_flag = 1;
            break;
        case 'l':
            lex_only_flag = 1;
            break;
        case 'o':
            output_file = optarg;
            break;
        case 't':
            tos_flag = 1;
            break;
        case 'v':
            show_version();
            break;

        default:
            show_options();
            abort();
        }
    }

    if (optind >= argc)
    {
        fprintf(stderr, "error: no input file\n");
        exit(EXIT_FAILURE);
    }

    // set yyin to the file we want to parse
    if (!(yyin = fopen(argv[optind], "r")))
    {
        perror(argv[optind]);
        exit(EXIT_FAILURE);
    }

    if (verbose_flag)
        printf("-> Initializing symbol table...\n");

    /* Program starts here */
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

        if (verbose_flag)
            printf("-> Lexical analysis finished\n");

        if (yyin != stdin)
            fclose(yyin);

        return 0;
    }

    if (verbose_flag)
        printf("-> Starting parsing...\n");

    int r = yyparse();

    // code_dump(code);

    FILE *output_fp;
    if (output_file != NULL)
    {
        output_fp = fopen(output_file, "w+");
    }
    else
    {
        output_fp = fopen("mips.s", "w+");
    }
    gencode_mips_global_variable(output_fp, symbol_table);
    gencode_mips(code, output_fp);
    fclose(output_fp);

    if (verbose_flag)
        printf("-> Finished parsing, returned code : %d\n", r);

    if (yyin != stdin)
        fclose(yyin);

    if (tos_flag == 1)
        symbol_table_dump(symbol_table, stdout);

    free_symbol_table(symbol_table);
    return 0;
}

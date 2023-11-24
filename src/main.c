#include <stdio.h>
#include <stdlib.h>
#include "../include/symbol_table.h"
#include "../include/cmat.lex.h"
#include "../include/cmat.tab.h"

#ifdef RELEASE
extern FILE *yyin;
extern FILE *yyout;


int main(int argc, char **argv) {
    init_hash_table();

    if (argc > 1) {
        if (!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return 1;
        }
    }

    /*int token = yylex();
    while(token)
    {
        token = yylex();   
    }

    if (yyin != stdin) fclose(yyin);

    // Afficher la table des symboles
    if (!(yyout = fopen("symbol_table.txt", "w+"))) {
        perror("symbol_table.txt");
        return 1;
    }

    symtab_dump(yyout);
    // printf("Symbol table dumped to symbol_table.txt\n");
    if (yyout != stdout)
        fclose(yyout);*/
    int r = yyparse();
    printf("-> Analyseur lexical retourne : %d\n", r);
    return 0;
}
#endif

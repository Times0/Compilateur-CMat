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

    int r = yyparse();
    printf("-> Analyseur lexical retourne : %d\n", r);

    if (yyin != stdin) fclose(yyin);

    // Afficher la table des symboles
    if (!(yyout = fopen("symbol_table.txt", "w+"))) {
        perror("symbol_table.txt");
        return 1;
    }

    symtab_dump(yyout);
    if (yyout != stdout)
        fclose(yyout);
    
    return 0;
}
#endif

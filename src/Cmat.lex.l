%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../include/symbol_table.h"
#include "../include/Cmat.tab.h"

extern FILE *yyin;
extern FILE *yyout;
int lineno = 1;

void ret_print(char *token_type);
void yyerror(char *);
%}

%x ML_COMMENT
%x SL_COMMENT

DIGIT   [0-9]
ID      [a-zA-Z_][a-zA-Z_0-9]*
STRING  \"([^\\\"]|\\.)*\" 

%%

"/*"            { BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/" { BEGIN(INITIAL); lineno++; }
<ML_COMMENT>.   { /* consume anything inside multi-line comments */ }
<ML_COMMENT>\n  { lineno++; /* count lines inside multi-line comments */ }

"//"            { BEGIN(SL_COMMENT); }
<SL_COMMENT>\n { BEGIN(INITIAL); lineno++; }
<SL_COMMENT>.  { /* consume anything inside single-line comments */ }


"if"            { ret_print("KEYWORD_IF"); }
"else"          { ret_print("KEYWORD_ELSE"); }
"while"         { ret_print("KEYWORD_WHILE"); }
"for"           { ret_print("KEYWORD_FOR"); }
"return"        { ret_print("KEYWORD_RETURN"); }
"main"          { ret_print("KEYWORD_MAIN"); }



{ID}            { insert(yytext, strlen(yytext), UNDEF, lineno);
                  ret_print("IDENTIFIER"); }


{DIGIT}+        { ret_print("INTEGER_CONST"); }
{DIGIT}+"."{DIGIT}* { ret_print("FLOAT_CONST"); }

"+"|"-"         { ret_print("ADD_OP"); }
"*"|"/"         { ret_print("MUL_OP"); }
"="             { ret_print("ASSIGN_OP"); }
"=="|"!="       { ret_print("EQ_OP"); }
"<"|"<="|">"|">=" { ret_print("REL_OP"); }
"&&"|"||"       { ret_print("LOG_OP"); }
"!"             { ret_print("NOT_OP"); }

";"             { ret_print("SEMI"); }
","             { ret_print("COMMA"); }
"("             { ret_print("LPAREN"); }
")"             { ret_print("RPAREN"); }
"["             { ret_print("LBRACK"); }
"]"             { ret_print("RBRACK"); }
"{"             { ret_print("LBRACE"); }
"}"             { ret_print("RBRACE"); }
"~"             { ret_print("TRANSPOSE_OP"); }
{STRING}        { ret_print("STRING_LITERAL"); }

\n              { lineno++; ret_print("\n"); }
[ \t]+          { /* ignore whitespace */ }
.               { yyerror("Unrecognized character"); }
%%

void ret_print(char *token_type) {
    // printf("%s at line %d: %s\n", token_type, lineno, yytext);
    #ifdef TEST
    if (strcmp(token_type, "\n") == 0) {
        fprintf(stdout, "\n");
    } else {
        fprintf(stdout, "%s:<%s> ", token_type, yytext);
    }
    #endif
}

void yyerror(char *message) {
    fprintf(stderr, "Error: %s at line %d.\n", message, lineno);
    exit(1);
}

int main(int argc, char **argv) {
    init_hash_table(); // Initialiser la table des symboles

    if (argc > 1) {
        if (!(yyin = fopen(argv[1], "r"))) {
            perror(argv[1]);
            return 1;
        }
    }

    yylex();

    if (yyin != stdin) fclose(yyin);

    // Afficher la table des symboles
    if (!(yyout = fopen("symbol_table.txt", "w"))) {
        perror("symbol_table.txt");
        return 1;
    }

    symtab_dump(yyout);
    // printf("Symbol table dumped to symbol_table.txt\n");
    if (yyout != stdout)
        fclose(yyout);
    return 0;
}

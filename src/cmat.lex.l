%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../include/symbol_table.h"
#include "../include/cmat.tab.h"


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
INTEGER_CONST   {DIGIT}+
FLOAT_CONST {DIGIT}*"."{DIGIT}+

%%

"/*"                { BEGIN(ML_COMMENT); }
<ML_COMMENT>"*/"    { BEGIN(INITIAL); lineno++; }
<ML_COMMENT>.       { /* consume anything inside multi-line comments */ }
<ML_COMMENT>\n      { lineno++; /* count lines inside multi-line comments */ }

"//"                { BEGIN(SL_COMMENT); }
<SL_COMMENT>\n      { BEGIN(INITIAL); lineno++; }
<SL_COMMENT>.       { /* consume anything inside single-line comments */ }


"if"            { ret_print("IF");      return IF;}
"else"          { ret_print("ELSE");    return ELSE;}
"while"         { ret_print("WHILE");   return WHILE;}
"for"           { ret_print("FOR");     return FOR;}
"return"        { ret_print("RETURN");  return RETURN;}
"main"          { ret_print("MAIN");    return MAIN;}

"int"           { ret_print("INT");     return INT;}
"float"         { ret_print("FLOAT");   return FLOAT;}
"matrix"        { ret_print("MATRIX");  return MATRIX;}
"void"          { ret_print("VOID");    return VOID;}

{ID}            { ret_print("IDENTIFIER"); insert(yytext, strlen(yytext), UNDEF, lineno);
                  yylval.symbol_table_item = lookup(yytext);
                  return ID;}

{INTEGER_CONST} { yylval.int_val = atoi(yytext); ret_print("INT_CONST");   return INT_CONST;}

"++"                { ret_print("INC_OP");          return INCR;}    
"--"                { ret_print("DEC_OP");          return DECR;}
".."                { ret_print("DDOT");            return DDOT;}
"+"|"-"             { ret_print("ADD_OP");          return yytext[0];}
"*"|"/"|"%"         { ret_print("MUL_OP");          return yytext[0];}
"="                 { ret_print("ASSIGN_OP");       return yytext[0];}
"=="                { ret_print("EQ_OP");           return EQ_OP;}
"!="                { ret_print("NEQ_OP");          return NEQ_OP;}
"<"                 { ret_print("LT_OP");           return LT_OP;}
"<="                { ret_print("LE_OP");           return LE_OP;}
">"                 { ret_print("GT_OP");           return GT_OP;}
">="                { ret_print("GE_OP");           return GE_OP;}
"&&"                { ret_print("AND_OP");          return AND_OP;}
"||"                { ret_print("OR_OP");           return OR_OP;}
"!"                 { ret_print("NOT_OP");          return yytext[0];}

";"                 { ret_print("SEMI");            return yytext[0];}
","                 { ret_print("COMMA");           return yytext[0];}
"("                 { ret_print("LPAREN");          return yytext[0];}
")"                 { ret_print("RPAREN");          return yytext[0];}
"["                 { ret_print("LBRACK");          return yytext[0];}
"]"                 { ret_print("RBRACK");          return yytext[0];}
"{"                 { ret_print("LBRACE");          return yytext[0];}
"}"                 { ret_print("RBRACE");          return yytext[0];}
"~"                 { ret_print("TRANSPOSE_OP");    return yytext[0];}


\n                  { lineno++; ret_print("\n");}   /*ignore newlines*/
[ \t]+              { /* ignore whitespaces */ }
.                   { yyerror("Unrecognized character"); }
%%

// For tests only
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

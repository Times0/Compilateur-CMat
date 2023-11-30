%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../include/symbol_table.h"
#include "../include/cmat.tab.h"

void ret_print(char *token_type);
void yyerror(char *);
extern __uint32_t lineno;
%}

%x ML_COMMENT
%x SL_COMMENT

DIGIT   [0-9]
ID      [a-zA-Z_][a-zA-Z_0-9]*
STRING  \"[^\"]*\"
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


"if"            { ret_print("KEYWORD_IF");      return IF;}
"else"          { ret_print("KEYWORD_ELSE");    return ELSE;}
"while"         { ret_print("KEYWORD_WHILE");   return WHILE;}
"for"           { ret_print("KEYWORD_FOR");     return FOR;}
"return"        { ret_print("KEYWORD_RETURN");  return RETURN;}
"main"          { ret_print("KEYWORD_MAIN");    return MAIN;}

"int"           { ret_print("KEYWORD_INT");     yylval.type_val = INT;   return INT;}
"float"         { ret_print("KEYWORD_FLOAT");   yylval.type_val = FLOAT; return FLOAT;}
"matrix"        { ret_print("KEYWORD_MATRIX");  return MATRIX;}
"void"          { ret_print("KEYWORD_VOID");    return VOID;}


{ID}            { ret_print("IDENTIFIER");
                  if ( yyleng > MAXTOKENLEN )
                      fprintf(stderr,"Identifier '%s' too long, truncated\n",yytext);
                  strncpy(yylval.strval,yytext,7);
                  yylval.strval[MAXTOKENLEN] = '\0';
                  return ID;
                }

{INTEGER_CONST}     { ret_print("INTEGER_CONST");   yylval.int_val = atoi(yytext); return INT_CONST;}
{FLOAT_CONST}       { ret_print("FLOAT_CONST");     return FLOAT_CONST;}

"++"                { ret_print("INC_OP");          return INCR;}    
"--"                { ret_print("DEC_OP");          return DECR;}
".."                { ret_print("DDOT");            return DDOT;}
"+"|"-"             { ret_print("ADD_OP");          return yytext[0];}
"*"|"/"|"%"         { ret_print("MUL_OP");          return yytext[0];}
"="                 { ret_print("ASSIGN_OP");       return yytext[0];}
"=="                { ret_print("EQ_OP");           return EQ_OP;}
"!="                { ret_print("NEQ_OP");          return NEQ_OP;}
"<"                 { ret_print("REL_OP");          return LT_OP;}
"<="                { ret_print("REL_OP");          return LE_OP;}
">"                 { ret_print("REL_OP");          return GT_OP;}
">="                { ret_print("REL_OP");          return GE_OP;}
"&&"                { ret_print("LOG_OP");          return AND_OP;}
"||"                { ret_print("LOG_OP");          return OR_OP;}
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
{STRING}            { ret_print("STRING_LITERAL");  return STRING;}

\n                  { lineno++; ret_print("\n");}   /*ignore newlines*/
[ \t]+              { /* ignore whitespaces */ }
.                   { yyerror("Unrecognized character"); }
%%

// For tests only
void ret_print(char *token_type) {
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

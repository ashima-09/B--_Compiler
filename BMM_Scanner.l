%{
    #include<stdio.h>
    #include <string.h>
    #include <math.h>
    #include "y.tab.h"
    int temp;
%}

%%

[0-9]+ {yylval.num=atoi(yytext);return DEC_NUM;}
[A-Z][0-9]? {yylval.str = strdup(yytext); return VAR;}
[\%\!\#\$] {yylval.str = strdup(yytext); return DATA_TYPE;}
[0-9]+(\.[0-9]+) {yylval.str = strdup(yytext); return NUMBER;}

\( {yylval.str = strdup(yytext); return OPEN_PAREN;}
\) {yylval.str = strdup(yytext); return CLOSING_PAREN;}
\^ {yylval.str = strdup(yytext); return POWER;}
\- {yylval.str = strdup(yytext); return MINUS;}
\* {yylval.str = strdup(yytext); return MULTIPLY;}
\/ {yylval.str = strdup(yytext); return DIVIDE;}
\+ {yylval.str = strdup(yytext); return ADD;}


\= {yylval.str = strdup(yytext);return EQUAL;}

\> {yylval.str = strdup(yytext); return GREATER;}
\< {yylval.str = strdup(yytext); return LESS;}
\>\= {yylval.str = strdup(yytext);return GREATER_EQUAL;}
\<\= {yylval.str = strdup(yytext);return LESS_EQUAL;}
\<\> {yylval.str = strdup(yytext);return NOT_EQUAL;}
AND {yylval.str = strdup(yytext);return AND;}
OR {yylval.str = strdup(yytext);return OR;}
NOT {yylval.str = strdup(yytext); return NOT;}
XOR {yylval.str = strdup(yytext); return XOR;}

\t+    {printf("No tabs allowed\n");exit(0);};

DATA {yylval.str = strdup(yytext); return DATA_KEYWORD;}
DEF[ ]FN[A-Z] {yylval.str = strdup(yytext); return FUNC_NAME;}
DIM {yylval.str = strdup(yytext); return DIM;}
[A-Z]\(([0-9]+|[A-Z])(\,[0-9]+)?\)(,[A-Z]\([0-9]+(\,[0-9]+)?\))* {yylval.str = strdup(yytext); return DIM_DECL;}

FOR {yylval.str = strdup(yytext); return FOR;}
TO {yylval.str = strdup(yytext); return TO;}
STEP {yylval.str = strdup(yytext); return STEP;}
NEXT {yylval.str = strdup(yytext); return NEXT;}


GOSUB[ ][0-9]+ {yylval.str = strdup(yytext);return GOSUB;}
GOTO[ ][0-9]+ {yylval.str = strdup(yytext); return GOTO;}

INPUT[ ] { yylval.str = strdup(yytext);return INPUT;}
PRINT {yylval.str = strdup(yytext); return PRINT;}
REM(.*|.*\n) {yylval.str = strdup(yytext);return COMMENT;}
RETURN {yylval.str = strdup(yytext); return RETURN;}
STOP {yylval.str = strdup(yytext); return STOP;}
LET {yylval.str = strdup(yytext); return LET;}

IF {yylval.str = strdup(yytext); return IF;}
THEN {yylval.str = strdup(yytext); return THEN;}


\, {yylval.str = strdup(yytext); return COMMA;}
\; {yylval.str = strdup(yytext); return SEMICOLON;}

\".*\" {yylval.str = strdup(yytext); return STRING;}



END {yylval.str = strdup(yytext); return END;}



%%

int yywrap(){
    return 1;
}
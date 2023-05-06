%{
    #include<stdio.h>
    #include <string.h>
    #include <math.h>
    #include "y.tab.h"
%}

%%

[0-9]+ {yylval=atoi(yytext);return DEC_NUM;}
[A-Z][0-9]? {return VAR;}
[\%\!\#\$] {return DATA_TYPE;}
[0-9]+(\.[0-9]+) {yylval=atoi(yytext);return NUMBER;}

\( {return OPEN_PAREN;}
\) {return CLOSING_PAREN;}
\^ {return POWER;}
\- {return MINUS;}
\* {return MULTIPLY;}
\/ {return DIVIDE;}
\+ {return ADD;}


\= {return EQUAL;}

\> {return GREATER;}
\< {return LESS;}
\>\= {return GREATER_EQUAL;}
\<\= {return LESS_EQUAL;}
\<\> {return NOT_EQUAL;}
AND {return AND;}
OR {return OR;}
NOT {return NOT;}
XOR {return XOR;}

\t+    {exit(0);};

DATA {return DATA_KEYWORD;}
DEF[ ]FN[A-Z] {return FUNC_NAME;}
DIM {return DIM;}
[A-Z]\(([0-9]+|[A-Z])(\,[0-9]+)?\)(,[A-Z]\([0-9]+(\,[0-9]+)?\))* {return DIM_DECL;}

FOR {return FOR;}
TO {return TO;}
STEP {return STEP;}
NEXT {return NEXT;}


GOSUB[ ][0-9]+ {return GOSUB;}
GOTO[ ][0-9]+ {return GOTO;}

INPUT {return INPUT;}
PRINT {return PRINT;}
REM[ ]*.* {return COMMENT;}
RETURN {return RETURN;}
STOP {return STOP;}
LET {return LET;}

IF {return IF;}
THEN {return THEN;}


\, {return COMMA;}
\; {return SEMICOLON;}

\".*\" {return STRING;}



END {return END;}



%%

int yywrap(){
    return 1;
}
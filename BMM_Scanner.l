%{
    #include<stdio.h>
    #include<stdlib.h>
    #include <string.h>
    #include <math.h>
    #include "y.tab.h"
    
%}

%%

[0-9]+ {fprintf(yyout,"Number: %d\n",atoi(yytext)); yylval.num=atoi(yytext); return DEC_NUM;}
[A-Z][0-9]? {fprintf(yyout,"Variable: %s\n",yytext); yylval.str = strdup(yytext); return VAR;}
[\%\!\#\$] {fprintf(yyout,"Data Type: %s\n",yytext); yylval.str = strdup(yytext); return DATA_TYPE;}
[0-9]+(\.[0-9]+) {fprintf(yyout,"Decimal Number: %s\n",yytext); yylval.str = strdup(yytext); return NUMBER;}

\( { fprintf(yyout,"Left Parenthesis: %s\n",yytext); yylval.str = strdup(yytext); return OPEN_PAREN;}
\) { fprintf(yyout,"Right Parenthesis: %s\n",yytext); yylval.str = strdup(yytext); return CLOSING_PAREN;}
\- { fprintf(yyout,"Minus: %s\n",yytext); yylval.str = strdup(yytext); return MINUS;}
\^ { fprintf(yyout,"Power: %s\n",yytext); yylval.str = strdup(yytext); return POWER;}
\* { fprintf(yyout,"Multiply: %s\n",yytext); yylval.str = strdup(yytext); return MULTIPLY;}
\/ { fprintf(yyout,"Divide: %s\n",yytext); yylval.str = strdup(yytext); return DIVIDE;}
\+ { fprintf(yyout,"Plus: %s\n",yytext); yylval.str = strdup(yytext); return ADD;}


\= { fprintf(yyout,"Equal: %s\n",yytext); yylval.str = strdup(yytext);return EQUAL;}

\> { fprintf(yyout,"Greater than: %s\n",yytext); yylval.str = strdup(yytext); return GREATER;}
\< { fprintf(yyout,"Less than: %s\n",yytext); yylval.str = strdup(yytext); return LESS;}
\>\= { fprintf(yyout,"Greater than equal: %s\n",yytext); yylval.str = strdup(yytext);return GREATER_EQUAL;}
\<\= { fprintf(yyout,"Less than equal: %s\n",yytext); yylval.str = strdup(yytext);return LESS_EQUAL;}
\<\> { fprintf(yyout,"Not Equal: %s\n",yytext); yylval.str = strdup(yytext);return NOT_EQUAL;}
AND { fprintf(yyout,"AND: %s\n",yytext); yylval.str = strdup(yytext);return AND;}
OR { fprintf(yyout,"OR: %s\n",yytext); yylval.str = strdup(yytext);return OR;}
NOT { fprintf(yyout,"NOT: %s\n",yytext); yylval.str = strdup(yytext); return NOT;}
XOR { fprintf(yyout,"XOR: %s\n",yytext); yylval.str = strdup(yytext); return XOR;}

\t+    {printf("No tabs allowed\n");exit(0);};

DATA { fprintf(yyout,"DATA: %s\n",yytext); yylval.str = strdup(yytext); return DATA_KEYWORD;}
DEF[ ]FN[A-Z] { fprintf(yyout,"Function: %s\n",yytext); yylval.str = strdup(yytext); return FUNC_NAME;}
DIM { fprintf(yyout,"DIM: %s\n",yytext); yylval.str = strdup(yytext); return DIM;}
[A-Z]\(([0-9]+|[A-Z])(\,[0-9]+)?\)(,[A-Z]\([0-9]+(\,[0-9]+)?\))* { 
    
    
    fprintf(yyout,"DIM Declarations: %s\n",yytext); yylval.str = strdup(yytext); return DIM_DECL;}

FOR { fprintf(yyout,"FOR"); yylval.str = strdup(yytext); return FOR;}
TO { fprintf(yyout,"TO"); yylval.str = strdup(yytext); return TO;}
STEP { fprintf(yyout,"STEP"); yylval.str = strdup(yytext); return STEP;}
NEXT { fprintf(yyout,"NEXT"); yylval.str = strdup(yytext); return NEXT;}


GOSUB[ ][0-9]+ { fprintf(yyout,"%s\n",yytext); yylval.str = strdup(yytext);return GOSUB;}
GOTO[ ][0-9]+ { fprintf(yyout,"%s\n",yytext); yylval.str = strdup(yytext); return GOTO;}

INPUT[ ] { fprintf(yyout,"INPUT");  yylval.str = strdup(yytext);return INPUT;}
PRINT { fprintf(yyout,"PRINT"); yylval.str = strdup(yytext); return PRINT;}
REM(.*|.*\n) { fprintf(yyout,"REM"); yylval.str = strdup(yytext);return COMMENT;}
RETURN { fprintf(yyout,"RETURN"); yylval.str = strdup(yytext); return RETURN;}
STOP { fprintf(yyout,"STOP"); yylval.str = strdup(yytext); return STOP;}
LET { fprintf(yyout,"LET"); yylval.str = strdup(yytext); return LET;}

IF { fprintf(yyout,"IF"); yylval.str = strdup(yytext); return IF;}
THEN { fprintf(yyout,"THEN"); yylval.str = strdup(yytext); return THEN;}


\, { fprintf(yyout,"Comma: %s\n",yytext); yylval.str = strdup(yytext); return COMMA;}
\; { fprintf(yyout,"Semicolon: %s\n",yytext); yylval.str = strdup(yytext); return SEMICOLON;}

\".*\" { fprintf(yyout,"String: %s\n",yytext); yylval.str = strdup(yytext); return STRING;}



END { fprintf(yyout,"END"); yylval.str = strdup(yytext); return END;}



%%

int yywrap(){
    return 1;
}
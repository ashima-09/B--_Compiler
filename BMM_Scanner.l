%{
    #include<stdio.h>
    #include <string.h>
    #include <math.h>
    #include "y.tab.h"
%}

%%

[0-9]+ {yylval=atoi(yytext);printf("start ");return DEC_NUM;}
[A-Z][0-9]? {return VAR;}
[\%\!\#\$] {return DATA_TYPE;}
[0-9]+(\.[0-9]+) {yylval=atoi(yytext);printf("number ");return NUMBER;}

[(\(\))(\^)(\-)(\*)(\/)(\+)] {return ARITHEXPR;}
\= {return EQUAL;}
[(\>)(\<)(\>\=)(\<\=)(\<\>)] {return LOGICEXPR;}
AND {return AND;}
OR {return OR;}
NOT {return NOT;}
XOR {return XOR;}

\t+    {printf("tab cannot be present . terminating program.");exit(0);};

DATA {return DATA_KEYWORD;}
DEF[ ]FN[A-Z] {printf("def ");return FUNC_NAME;}
DIM {return DIM;}
[A-Z]\([0-9]+(\,[0-9]+)?\)(,[A-Z]\([0-9]+(\,[0-9]+)?\))* {return DIM_DECL;}
FOR[ ][A-Z][ ]=[ ]([0-9]+|[A-Z])[ ]TO[ ]([0-9]+|[A-Z])[ ](STEP[ ]([0-9]+|[A-Z]))? {return FOR_LOOP;}
NEXT[ ][A-Z] {return NEXT;}
GOSUB[ ][0-9]+ {return GOSUB;}
INPUT {return INPUT;}
PRINT {return PRINT;}
REM[ ][A-Z ]* {return COMMENT;}
RETURN {return RETURN;}
STOP {return STOP;}
LET {return LET;}
\([A-Z]\) {return PARAMETER;}

\, {return COMMA;}
\; {return SEMICOLON;}
\"[A-Z]+\" {return STRING_VALUE;}

END {exit(0);}



%%

int yywrap(){
    return 1;
}
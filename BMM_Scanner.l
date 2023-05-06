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
\([A-Z]\) {return PARAMETER;}

\, {return COMMA;}
\"[A-Z]+\" {return STRING_VALUE;}

END {exit(0);}



%%

int yywrap(){
    return 1;
}
%{
    #include<stdio.h>    
%}

%%
[0-9]+ {yylval=atoi(yytext); return START_LINE;}
[A-Z][0-9]? {return VAR;}
(%) {return INT};
(!) {return SINGLE_PREC;}
(#) {return DOUBLE_PREC;}
($) {return STRING}

\( {return LPAREN;}
\) {return RPAREN;}
\^ {return EXP;}
\- {return MINUS;}
\+ {return PLUS;}
\* {return MULT;}
\/ {return DIV;}
\= {return EQUAL;}
\> {return GREATER;}
\< {return LESS;}
\>= {return GREATER_EQUAL;}
\<= {return LESS_EQUAL;}
\<\> {return NOT_EQUAL;}
AND {return AND;}
OR {return OR;}
NOT {return NOT;}
XOR {return XOR;}
\n {return NEWLINE;}
%%
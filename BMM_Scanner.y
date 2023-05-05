%{
    #include<stdio.h>
    int yylex();
    int yyparse();
    int  yyerror();   
%}

%token START_LINE NEW_LINE

%%
input: START_LINE NEW_LINE
    | input START_LINE NEW_LINE {printf("SYNTAX ERROR\nLine should start with a number\n"); exit(0);}
    ;
%%
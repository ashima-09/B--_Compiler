%{
    #include<stdio.h>
    #include <stdlib.h>
	#include <string.h>
    void yyerror(char* msg);
    extern FILE* yyin;
	extern FILE* yyout;
    int yylex();
    int yyparse(); 
%}

%token AND OR NOT XOR DEC_NUM DATA_TYPE VAR NUMBER FUNC_NAME EQUAL DATA_KEYWORD COMMA STRING_VALUE DIM DIM_DECL LET INPUT REM PRINT SEMICOLON GOSUB OPEN_PAREN CLOSING_PAREN POWER MINUS MULTIPLY DIVISE ADD  GREATER LESS GREATER_EQUAL LESS_EQUAL NOT_EQUAL
    FOR_LOOP NEXT COMMENT RETURN STOP
%%



line:DEC_NUM function
    |DEC_NUM function line
    ;

function:data
    |def
    |dim
    |let
    |input
    |comments
    |print
    |goto
    ;


data:DATA_KEYWORD number COMMA STRING_VALUE 
    |DATA_KEYWORD number COMMA number
    |DATA_KEYWORD STRING_VALUE COMMA number
    |DATA_KEYWORD STRING_VALUE COMMA STRING_VALUE
    ;

def:FUNC_NAME EQUAL number
    |FUNC_NAME EQUAL expr 
    |FUNC_NAME OPEN_PAREN VAR CLOSING_PAREN EQUAL expr 
    ;

ARITHEXPR:OPEN_PAREN
        |CLOSING_PAREN
        |POWER
        |MINUS
        |MULTIPLY
        |DIVISE
        |ADD
        ;

LOGICEXPR:GREATER
        |LESS
        |GREATER_EQUAL
        |LESS_EQUAL
        |NOT_EQUAL
        ;



/* declarations: var_declarations COMMA declarations
            |dim_declarations COMMA declarations
            | var_declarations
            | dim_declarations
            ; */

dim: DIM dim_declarations
    ;

let: LET var_initialise
    | LET dim_initialise
    ;

input: INPUT var_declarations
    | INPUT dim_declarations
    ;

comments: REM 
        ;


/* var_declarations: VAR COMMA var_declarations
                | VAR DATA_TYPE COMMA var_declarations
                | VAR DATA_TYPE EQUAL number COMMA var_declarations
                | VAR DATA_TYPE EQUAL STRING_VALUE COMMA var_declarations
                | VAR DATA_TYPE EQUAL expr COMMA var_declarations
                | VAR
             ; */

var_declarations: VAR COMMA var_declarations
                | VAR DATA_TYPE COMMA var_declarations
                | VAR
                ;
            
var_initialise: var_initialise COMMA var_initialise
                | VAR DATA_TYPE EQUAL VAR
                | VAR DATA_TYPE EQUAL VAR DATA_TYPE
                | VAR DATA_TYPE EQUAL number
                | VAR DATA_TYPE EQUAL STRING_VALUE
                | VAR DATA_TYPE EQUAL arithexp
                | VAR DATA_TYPE EQUAL logicexp
                | VAR EQUAL VAR
                | VAR EQUAL VAR DATA_TYPE
                | VAR EQUAL number
                | VAR EQUAL STRING_VALUE
                | VAR EQUAL arithexp
                | VAR EQUAL logicexp
                ;



dim_declarations: DIM_DECL COMMA dim_declarations
                | DIM_DECL
                ;

dim_initialise: dim_initialise COMMA dim_initialise
                | DIM_DECL EQUAL DIM_DECL
                | DIM_DECL EQUAL number
                ;

/* alexpr: ARITHEXPR
       | LOGICEXPR
       | EQUAL
       ; */

/* expr: expr alexpr VAR   {printf("bugg1 ");}
    | expr alexpr number {printf("bugg2 ");}
    | expr EQUAL VAR {printf("bugg3 ");}
    | VAR {printf("bugg4 ");}
    | number{printf("bugg5 ");}
    ; */

expr: arithexp
    | logicexp
    ;
    
arithexp: arithexp ARITHEXPR VAR
        | arithexp ARITHEXPR number
        | '('arithexp')'
        | VAR
        | number
        ;

logicexp: logicexp LOGICEXPR VAR
        | logicexp LOGICEXPR number
        | '('logicexp')'
        | VAR
        | number
        ;

number:DEC_NUM
    |NUMBER
    ;

print: PRINT print_statements
    ;

print_statements: print_expr COMMA print_statements
                | print_expr SEMICOLON print_statements
                | print_expr
                ;

print_expr: var_declarations
            | dim_declarations
            | STRING_VALUE
            | arithexp
            | logicexp
            ;


goto: GOSUB
    ;

%%

int main(int argc , char** argv){
    if(argc < 2){
		printf("Syntax is %s <filename>\n", argv[0]);
		return 0;
	}
	yyin = fopen(argv[1], "r");
	yyout = fopen("Lexer.txt", "w");
	stdout = fopen("Parser.txt", "w");
    yyparse();
}

void yyerror(char* msg){
    printf("\nPROGRAM IS SYNTATICALLY INCORRECT\n");
}
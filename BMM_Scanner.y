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

%token AND OR NOT XOR DEC_NUM DATA_TYPE VAR NUMBER FUNC_NAME EQUAL DATA_KEYWORD COMMA DIM DIM_DECL LET INPUT PRINT SEMICOLON GOSUB OPEN_PAREN CLOSING_PAREN POWER MINUS MULTIPLY DIVIDE ADD  GREATER LESS GREATER_EQUAL LESS_EQUAL NOT_EQUAL IF THEN
    COMMENT RETURN STOP END FOR TO STEP STRING NEXT GOTO


%left ADD MINUS
%left MULTIPLY DIVIDE
%left OPEN_PAREN CLOSING_PAREN

%%



line:DEC_NUM function 
    |DEC_NUM function line 
    ;

function:
    data {printf("statement data \n");}
    |def {printf("statement def \n");}
    |dim {printf("statement dIM\n");}
    |let {printf("statement LET \n");}
    |input {printf("statement INPUT \n");}
    |comments {printf("statement COMMENTS \n");}
    |print {printf("statement PRINT\n");}
    |gosub {printf("statement GOSUB\n");}
    |goto {printf("statement GOTO\n");}
    |if {printf("STATEMENT IF\n");}
    |end {printf("STATEMENT END\n");}
    |stop {printf("STATEMENT STOP\n");}
    |return {printf("STATEMENT RETURN\n");}
    |for {printf("STATEMENT FOR\n");}
    |next {printf("STATEMENT next\n");}
    ;


for:for_loop
    |for_loop STEP expr
    ;

for_loop:FOR VAR EQUAL expr TO expr
    ;


next:NEXT VAR
    ;

if:IF expr LOGICEXPR expr THEN DEC_NUM
    |IF VAR LOGICEXPR expr THEN DEC_NUM
    |IF expr EQUAL STRING THEN DEC_NUM
    |IF expr NOT_EQUAL STRING THEN DEC_NUM
    |IF STRING EQUAL STRING THEN DEC_NUM
    |IF STRING NOT_EQUAL STRING THEN DEC_NUM
    |IF VAR DATA_TYPE LOGICEXPR expr THEN DEC_NUM
    |IF VAR DATA_TYPE EQUAL STRING THEN DEC_NUM
    |IF VAR DATA_TYPE NOT_EQUAL STRING THEN DEC_NUM
    |IF dim_declarations LOGICEXPR expr THEN DEC_NUM
    |IF dim_declarations EQUAL STRING THEN DEC_NUM
    |IF dim_declarations NOT_EQUAL STRING THEN DEC_NUM
    ;



data:DATA_KEYWORD data_values
    ;


data_values: number COMMA data_values
    |number
    |STRING COMMA data_values
    |STRING



def:FUNC_NAME EQUAL number
    |FUNC_NAME EQUAL expr 
    |FUNC_NAME OPEN_PAREN VAR CLOSING_PAREN EQUAL expr 
    ;


dim: DIM dim_declarations
    ;

print: PRINT print_statements 
    ;

print_statements: print_expr COMMA print_statements
                | print_expr SEMICOLON print_statements
                | print_expr
                ;

print_expr: var_declarations
            | dim_declarations
            | STRING 
            | expr
            ;

let: 
    LET var_initialise
    | LET dim_initialise
    ;


dim_initialise: dim_initialise COMMA dim_initialise
                | DIM_DECL EQUAL DIM_DECL
                | DIM_DECL EQUAL number
                ;

var_initialise: var_initialise COMMA var_initialise
                | VAR DATA_TYPE EQUAL VAR DATA_TYPE
                | VAR DATA_TYPE EQUAL STRING
                | VAR DATA_TYPE EQUAL expr
                | VAR EQUAL VAR DATA_TYPE
                | VAR EQUAL STRING
                | VAR EQUAL expr
                
                ;

expr: VAR ARITHEXPR expr
    | number ARITHEXPR expr
    | VAR LOGICEXPR expr
    | number LOGICEXPR expr
    | '('expr')'
    | VAR
    | number
    ;

ARITHEXPR:OPEN_PAREN
        |CLOSING_PAREN
        |POWER
        |MINUS
        |MULTIPLY
        |DIVIDE
        |ADD
        ;

LOGICEXPR:GREATER
        |LESS
        |GREATER_EQUAL
        |LESS_EQUAL
        |NOT_EQUAL
        |EQUAL
        ;

number:DEC_NUM
    |NUMBER
    ;



input: INPUT ip_stmts
    ;

ip_stmts: var_declarations COMMA ip_stmts
        | dim_declarations COMMA ip_stmts
        | var_declarations
        | dim_declarations
        ;

dim_declarations: DIM_DECL COMMA dim_declarations
                | DIM_DECL
                ;


var_declarations: VAR COMMA var_declarations
                | VAR DATA_TYPE COMMA var_declarations
                | VAR
                ;
            
comments:COMMENT
        ;


gosub: GOSUB
    ;

goto: GOTO
    ;

end: END 
    ;

stop:STOP
    ;

return:RETURN
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
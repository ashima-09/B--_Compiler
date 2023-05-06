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

%token AND OR NOT XOR NEW_LINE DEC_NUM DATA_TYPE VAR NUMBER FUNC_NAME PARAMETER EQUAL DATA_KEYWORD ARITHEXPR LOGICEXPR COMMA STRING_VALUE DIM DIM_DECL LET

%%



line:DEC_NUM function
    |DEC_NUM function line
    ;

function:data
    |def
    ;


data:DATA_KEYWORD number COMMA STRING_VALUE 
    |DATA_KEYWORD number COMMA number
    |DATA_KEYWORD STRING_VALUE COMMA number
    |DATA_KEYWORD STRING_VALUE COMMA STRING_VALUE
    ;

def:FUNC_NAME EQUAL number
    |FUNC_NAME EQUAL expr 
    |FUNC_NAME PARAMETER EQUAL expr 
    ;

declarations: var_declarations COMMA declarations
            |dim_declarations COMMA declarations
            | var_declarations
            | dim_declarations
            ;

dim: DIM dim_declarations
    ;

let: LET var_declarations
    | LET dim_declarations
    ;

var_declarations: VAR COMMA var_declarations
                | VAR DATA_TYPE COMMA var_declarations
                | VAR DATA_TYPE EQUAL number COMMA var_declarations
                | VAR DATA_TYPE EQUAL STRING_VALUE COMMA var_declarations
                | VAR DATA_TYPE EQUAL expr COMMA var_declarations
                
                | VAR
                ;

dim_declarations: DIM_DECL COMMA dim_declarations
                | DIM_DECL EQUAL number COMMA dim_declarations
                | DIM_DECL EQUAL number
                | DIM_DECL
                ;

alexpr: ARITHEXPR
       | LOGICEXPR
       | EQUAL
       ;

expr: expr alexpr VAR   {printf("bugg1 ");}
    | expr alexpr number {printf("bugg2 ");}
    | expr EQUAL VAR {printf("bugg3 ");}
    | VAR {printf("bugg4 ");}
    | number{printf("bugg5 ");}
    ;
    
number:DEC_NUM
    |NUMBER
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
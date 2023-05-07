%{
    #include<stdio.h>
    #include <stdlib.h>
	#include <string.h>
    void yyerror(char* msg);
    extern FILE* yyin;
	extern FILE* yyout;
    extern FILE* stdout;
    int yylex();
    int yyparse(); 
    int checkend=0;
%}

%union{
    int num;
    char* str;
    float f;
}

%token <str>AND <str>OR <str>NOT <str>XOR <num>DEC_NUM <str>DATA_TYPE
       <str>VAR <str>NUMBER <str>FUNC_NAME <str>EQUAL <str>DATA_KEYWORD
       <str>COMMA <str>DIM <str>DIM_DECL <str>LET <str>INPUT <str>PRINT
       <str>SEMICOLON <str>GOSUB <str>OPEN_PAREN <str>CLOSING_PAREN <str>POWER
       <str>MINUS <str>MULTIPLY <str>DIVIDE <str>ADD <str>GREATER <str>LESS 
       <str>GREATER_EQUAL <str>LESS_EQUAL <str>NOT_EQUAL <str>IF <str>THEN
       <str>COMMENT <str>RETURN <str>STOP <str>END <str>FOR <str>TO <str>STEP
       <str>STRING <str>NEXT <str>GOTO


%left ADD MINUS
%left MULTIPLY DIVIDE
%left OPEN_PAREN CLOSING_PAREN

%%



line:DEC_NUM function 
    |DEC_NUM function line 
    ;

function:
    data {fprintf(stdout,"from DATA\n");}
    |def {fprintf(stdout,"--> FUNCTION CALL\n");}
    |dim {fprintf(stdout," from DIM\n");}
    |let {fprintf(stdout,"--> Initialisation\n");}
    |input {fprintf(stdout,"--> User Input\n");}
    |comments {fprintf(stdout,"Comments\n");}
    |print {fprintf(stdout," Print statement\n");}
    |gosub {fprintf(stdout,"--> GOSUB\n");}
    |goto {fprintf(stdout,"GOTO\n");}
    |if {fprintf(stdout,"--> IF STATEMENT\n");}
    |end {fprintf(stdout,"END\n");}
    |stop {fprintf(stdout,"STOP\n");}
    |for {fprintf(stdout,"--> FOR LOOP\n");} 
    ;


for:for_loop linee {fprintf(stdout,"--> FOR LOOP SHOULD END AFTER NEXT STATEMENT ");} 
    |for_loop STEP expr linee {fprintf(stdout,"--> FOR LOOP SHOULD END AFTER NEXT STATEMENT ");} 
    | error { yyerror("Invalid syntax of for loop"); }
    ;

linee: DEC_NUM NEXT VAR
    |DEC_NUM function linee
    ;

for_loop:FOR VAR EQUAL expr TO expr {fprintf(stdout,"Variable:  %s  -->FOR LOOP STARTS HERE \n",$2);}
    ;

if:IF expr RELEXPR expr THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$6);}
    |IF VAR RELEXPR expr THEN DEC_NUM 
    |IF expr EQUAL STRING THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$6);}
    |IF expr NOT_EQUAL STRING THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$6);}
    |IF STRING EQUAL STRING THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$6);}
    |IF STRING NOT_EQUAL STRING THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$6);}
    |IF VAR DATA_TYPE RELEXPR expr THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$7);}
    |IF VAR DATA_TYPE EQUAL STRING THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$7);}
    |IF VAR DATA_TYPE NOT_EQUAL STRING THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$7);}
    |IF dim_declarations RELEXPR expr THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$6);}
    |IF dim_declarations EQUAL STRING THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$6);}
    |IF dim_declarations NOT_EQUAL STRING THEN DEC_NUM {fprintf(stdout,"Line no.: %d ",$6);}
    ;

data:DATA_KEYWORD data_values
    ;


data_values: number COMMA data_values
    |number
    |STRING COMMA data_values
    |STRING {fprintf(stdout,"Value read: %s ",$1);}
    |error { yyerror("Invalid syntax of data"); }


def:FUNC_NAME EQUAL number {fprintf(stdout,"Function: %s ",$1);}
    |FUNC_NAME EQUAL expr {fprintf(stdout,"Function: %s ",$1);}
    |FUNC_NAME OPEN_PAREN VAR CLOSING_PAREN EQUAL expr {fprintf(stdout,"Function: %s Parameter: %s\n",$1,$3);}
    | error { yyerror("Invalid syntax of function"); }
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
            | error { yyerror("Invalid syntax of print statement"); }
            ;

let: 
    LET var_initialise
    | LET dim_initialise
    ;


dim_initialise: dim_initialise COMMA dim_initialise
                | DIM_DECL EQUAL DIM_DECL {fprintf(stdout,"%s %s %s ",$1,$2,$3);}
                | DIM_DECL EQUAL number {fprintf(stdout,"%s %s value read ",$1,$2);}
                |error { yyerror("Invalid syntax of dim initialisation"); }
                ;

var_initialise: var_initialise COMMA var_initialise
                | VAR DATA_TYPE EQUAL VAR DATA_TYPE {fprintf(stdout,"Variable %s initialised with value of %s ",$1,$3);}
                | VAR DATA_TYPE EQUAL STRING {fprintf(stdout,"Variable %s initialised with %s ",$1,$2);}
                | VAR DATA_TYPE EQUAL expr {fprintf(stdout,"Variable %s initialised with value read ",$1);}
                | VAR EQUAL VAR DATA_TYPE {fprintf(stdout,"Variable %s initialised with value of %s ",$1,$3);}
                | VAR EQUAL STRING {fprintf(stdout,"Variable %s initialised with value %s ",$1,$3);}
                | VAR EQUAL expr {fprintf(stdout,"Variable %s initialised with value read ",$1);}
                |error { yyerror("Invalid syntax of variable initialisation."); }
                
                ;

expr: VAR ARITHEXPR expr {fprintf(stdout,"Variable: %s ",$1);}
    | number ARITHEXPR expr
    | VAR RELEXPR expr {fprintf(stdout,"Variable: %s ",$1);}
    | number RELEXPR expr
    | VAR LOGICEXPR expr {fprintf(stdout,"Variable: %s ",$1);}
    | number LOGICEXPR expr
    | '('expr')' 
    | MINUS VAR
    | VAR {fprintf(stdout,"Variable: %s ",$1);}
    | number 
    | error { yyerror("Invalid syntax of expression provided."); }
    ;

LOGICEXPR: AND {fprintf(stdout,"Operation: %s ",$1);}
        |OR {fprintf(stdout,"Operation: %s ",$1);}
        |NOT {fprintf(stdout,"Operation: %s ",$1);}
        |XOR {fprintf(stdout,"Operation: %s ",$1);}
        |error { yyerror("No such logical expression exists."); }
        ;

ARITHEXPR:OPEN_PAREN
        |CLOSING_PAREN
        |POWER {fprintf(stdout,"Operation: %s ",$1);}
        |MINUS {fprintf(stdout,"Operation: %s ",$1);}
        |MULTIPLY {fprintf(stdout,"Operation: %s ",$1);}
        |DIVIDE   {fprintf(stdout,"Operation: %s ",$1);}
        |ADD {fprintf(stdout,"Operation: %s ",$1);}
        |error { yyerror("No such arithmetic expression exists."); }
        ;

RELEXPR:GREATER {fprintf(stdout,"Operation: %s ",$1);}
        |LESS {fprintf(stdout,"Operation: %s ",$1);}
        |GREATER_EQUAL {fprintf(stdout,"Operation: %s ",$1);}
        |LESS_EQUAL {fprintf(stdout,"Operation: %s ",$1);}
        |NOT_EQUAL {fprintf(stdout,"Operation: %s ",$1);}
        |EQUAL {fprintf(stdout,"Operation: %s ",$1);}
        |error { yyerror("No such relational expression exists."); }
        ;

number:DEC_NUM {fprintf(stdout,"Value: %d ",$1);} 
    |NUMBER {fprintf(stdout,"Value read: %s ",$1);}
    |error { yyerror("Invalid syntax of number"); }
    ;



input: INPUT ip_stmts
    ;

ip_stmts: var_declarations COMMA ip_stmts
        | dim_declarations COMMA ip_stmts
        | var_declarations
        | dim_declarations
        ;

dim_declarations: DIM_DECL COMMA dim_declarations
                | DIM_DECL {fprintf(stdout,"Value read: %s ",$1);}
                | error { yyerror("Invalid syntax of dim declaration"); }
                ;


var_declarations: VAR COMMA var_declarations {fprintf(stdout,"Variable: %s ",$1);}
                | VAR DATA_TYPE COMMA var_declarations {fprintf(stdout,"Variable: %s ",$1);}
                | VAR DATA_TYPE {fprintf(stdout,"Variable: %s ",$1);}
                | VAR {fprintf(stdout,"Variable: %s ",$1);}
                | error { yyerror("Invalid syntax of variable declaration"); }
                ;
            
comments:COMMENT
        |error { yyerror("Invalid syntax of comment"); }
        ;


gosub: sub lineee {fprintf(stdout,"GOSUB SHOULD END HERE AFTER RETURN ");}
    
    ;

sub:GOSUB {fprintf(stdout,"GOSUB STARTS HERE\n");}
    |error { yyerror("Invalid syntax of gosub"); }

lineee: DEC_NUM RETURN
    |DEC_NUM function lineee
    |error { yyerror("Invalid syntax of expression following gosub"); }
    ;

goto: GOTO
    |error { yyerror("Invalid syntax of goto"); }
    ;

end: END {if (checkend==0){checkend=1;} else{ fprintf(stdout,"Error:END statement is called again in program\n"); exit(0);}}
    ;

stop:STOP
    |error { yyerror("Invalid syntax of stop"); }
    ;


%%

int main(int argc , char** argv){
    if(argc < 2){
		fprintf(stdout,"Syntax is %s <filename>\n", argv[0]);
		return 0;
	}
	stdout=fopen("Parser.txt", "w");
	yyin = fopen(argv[1], "r");
	yyout = fopen("Lexer.txt", "w");
    yyparse();
}

void yyerror(char* msg){
    if(sizeof(msg) > 0))
    fprintf(stderr, "Error: %s\n", msg);
    else
    fprintf(stdout,"PROGRAM IS SYNTATICALLY INCORRECT\n");
}
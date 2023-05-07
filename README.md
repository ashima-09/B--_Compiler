# B---Compiler

This project aims to develop a compiler for the B-- programming language. The compiler is built from scratch using Flex and Bison to generate a lexical analyzer (scanner) and a syntax analyzer (parser) for the B-- source code. The generated analyzers can recognize the syntax of B-- and produce meaningful error messages to identify various syntax errors in the provided sample source codes.

## Instructions to Run on Ubuntu

To compile and run the B-- compiler on Ubuntu, follow these steps:

1. Open a terminal.
2. Navigate to the project directory.
3. Run the following commands:

```shell
lex BMM_Scanner.l
yacc -d BMM_Scanner.y
cc lex.yy.c y.tab.c -o BMM_Scanner
```

4. After successful compilation, you can execute the B-- compiler using the following command:

```shell
./BMM_Scanner
```

## Instructions for Windows

To compile and run the B-- compiler on Windows, perform the following steps:

1. Open a command prompt.
2. Navigate to the project directory.
3. Run the following commands:

```shell
flex BMM_Scanner.l
bison -yd BMM_Scanner.y
gcc lex.yy.c y.tab.c -o BMM_Scanner
```

4. After successful compilation, you can execute the B-- compiler by running the following command:

```shell
./BMM_Scanner.exe CorrectSample.bmm
```

Ensure that you have Flex, Bison, and a C compiler (such as GCC) installed on your system before executing the compilation commands.

The outputs will be generated in Lexer.txt(lexical analysis) and Parser.txt(syntax analysis).

If you encounter any errors during the compilation process, please make sure that the required dependencies are installed correctly and that the provided source code files (`BMM_Scanner.l` and `BMM_Scanner.y`) are present in the correct location. Also do ensure that the files lex.yy.c, y.tab.c and y.tab.h are being generated after the commands.
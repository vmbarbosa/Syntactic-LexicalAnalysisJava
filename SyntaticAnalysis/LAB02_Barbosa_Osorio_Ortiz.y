%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
extern FILE * yyin;
extern FILE * yyout;
extern int ErrorsLex;
int ErrorsSint;
%}

%token IF
%token ELSE
%token WHILE
%token FOR
%token DOUBLE
%token INT
%token STRING
%token CHAR
%token NEW
%token PUBLIC
%token CLASS
%token STATIC
%token VOID

%token OP_MULT
%token OP_SUM
%token OP-SUST
%token OP_DIV
%token OP_ASIG
%token OP_MOD

%token OP_MAS_MAS
%token OP_MEN_MEN
%token OP_MAS_ASIG
%token OP_MEN_ASIG
%token OP_POR_ASIG
%token OP_DIV_ASIG

%token COMA
%token PUNTO_Y_COMA

%token PARENT_A
%token PARENT_C
%token CORCHETE_A
%token CORCHETE_C
%token LLAVE_A
%token LLAVE_C

%token IGUAL_A
%token MENOR_IGUAL
%token MAYOR_IGUAL
%token DIFERENTE
%token MAYOR
%token MENOR

%token P_RESERVADA

%token OP_Y
%token OP_O
%token OP_NO

%token INT
%token STRING
%token FLOAT
%token ID

%start INICIO

%%
INICIO  :   funcion_id
        ;

funcion_id  :   PUBLIC CLASS ID CORCHETE_A funcion_main CORCHETE_C
                | PUBLIC CLASS ID CORCHETE_A CORCHETE_C
           ;

funcion_main    :   PUBLIC STATIC VOID P_RESERVADA PARENT_A STRING LLAVE_A LLAVE_C P_RESERVADA PARENT_C LLAVE_A linea LLAVE_C
                    | PUBLIC STATIC VOID P_RESERVADA PARENT_A STRING LLAVE_A LLAVE_C P_RESERVADA PARENT_C LLAVE_A LLAVE_C
                ;

linea   :   statement
            |  statement linea
        ;

statement   :   asignación
                |   ciclo
                |   condicional
            ;

asignación :    INT ID OP_ASIG 
  

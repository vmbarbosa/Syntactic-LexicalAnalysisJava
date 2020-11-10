%{

#include <stdio.h>
#include "LAB02_Barbosa_Osorio_Ortiz.tab.h"
int totalErrors =0 ;
%}


 /***Definiciones***/
 
letra           [a-zA-Z]
digito          [0-9]
entero          {digito}+
real            {digito}+\.{digito}*
exp             "e"(\-|\+)?({digito})*
variable        {letra}+{digito}*
Cte-ent         "-"?({entero})
Cte-cadena      \"({letra}|{digito}|" ")*\"
Cte-real        {real}{exp}?
comentario      \/\/({letra}|{digito}|" ")*|"/*"({letra}|{digito}|" ")*"*/"
arreglo         \[({Cte-ent}*(\,{Cte-ent})*|{Cte-cadena}(\,{Cte-cadena})*)\]
espacio         " "

 /***Palabras clave***/
 
"if"                {return(IF);}              
"else"              {return(ELSE);}  
"while"             {return(WHILE);}  
"for"               {return(FOR);}  
"double"            {return(DOUBLE);}  
"int"               {return(INT);}  
"String"            {return(STRING);}  
"char"              {return(CHAR);}  
"new"               {return(NEW);}  
"public"            {return(PUBLIC);}  
"class"             {return(CLASS);}  
"static"            {return(STATIC);}  
"void"              {return(VOID);}  

 /***Operadores aritmeticos***/

"*"         {return(OP_MULT);}   
"+"         {return(OP_SUM);}   
"-"         {return(OP-SUST);}
"/"         {return(OP_DIV);}
"="         {return(OP_ASIG);}
"%"         {return(OP_MOD);}
 
 /***Operadores aritmeticos especiales***/

"++"            {return(OP_MAS_MAS);}
"--"            {return(OP_MEN_MEN);}
"+="            {return(OP_MAS_ASIG);}
"-="            {return(OP_MEN_ASIG);}
"*="            {return(OP_POR_ASIG);}
"/="            {return(OP_DIV_ASIG);}

 /***Delimitadores de inicio y final de  bloques de instrucción***/
 
","             {return(COMA);}
";"             {return(PUNTO_Y_COMA);}

 /***Parentesis***/

"("            {return(PARENT_A);}
")"             {return(PARENT_C);}
"["             {return(CORCHETE_A);}
"]"             {return(CORCHETE_C);}
"{"             {return(LLAVE_A);}
"}"             {return(LLAVE_C);}

 /***Operadores relacionales***/
 
"=="                {return(IGUAL_A);}
"<="                {return(MENOR_IGUAL);}
">="                {return(MAYOR_IGUAL);}
"!=|<>"             {return(DIFERENTE);}
">"                 {return(MAYOR);}
"<"                 {return(MENOR);}

/***Palabras resevadas***/
"main"|"args" {return P_RESERVADA;}

 /***Operadores logicos***/

"&&"                 {return(OP_Y);} 
"||"                 {return(OP_O);} 
"!"                  {return(OP_NO);}

 /***Retornar Definiciones***/
{Cte-ent}           {return(INT);}
{Cte-cadena}        {return(STRING);}
{Cte-real}          {return(FLOAT);}
{variable}			{return(ID);}
{comentario}        { }


\n              {ErrorsLex++;}
%%


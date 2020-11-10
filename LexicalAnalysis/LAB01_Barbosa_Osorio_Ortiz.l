%{

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int total =0 ;
char ids[100][100];
int m=0;
int total2 =0;
%}

%option noyywrap

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
 
IF              if
ELSE            else
WHILE           while
FOR             for
DOUBLE          double
INT             int
STRING          String
CHAR            char
NEW             new
PUBLIC          public
CLASS           class
STATIC          static
VOID            void

 /***Operadores aritmeticos***/

"*"		{return(Op-mult)}   
Op-sum          \+
Op-sust         \-
Op-div          \/
Op-asig         \=
Op-mod          \%
 
 /***Operadores aritmeticos especiales***/

Op-mas-mas          \+\+
Op-men-men          \-\-
Op-mas-asig         \+\=
Op-men-asig         \-\=
Op-por-asig         \*\=
Op-div-asig         \/\=

 /***Delimitadores de inicio y final de  bloques de instrucción***/
 
coma               \,
punto-y-coma       \;

 /***Parentesis***/

Parent-a           \(
Parent-c           \)
Corchete-a         \[
Corchete-c         \]
Llave-a            \{
Llave-c            \}

 /***Operadores relacionales***/
 
Igual-a         \=\=
Menor-igual     \<\=
Mayor-igual     \>\=
Diferente       \!\=|\<\>
Mayor           \>
Menor           \<

 /***Operadores logicos***/

op-y            \&\& 
op-o            \|\| 
op-no           \!




%%

{PUBLIC}        fprintf(yyout, "PUBLIC");
{CLASS}         fprintf(yyout, "CLASS");
{STATIC}        fprintf(yyout, "STATIC");
{VOID}          fprintf(yyout, "VOID");
{IF}            fprintf(yyout, "IF");
{ELSE}          fprintf(yyout, "ELSE");
{WHILE}         fprintf(yyout, "WHILE");
{FOR}           fprintf(yyout, "FOR");

{espacio}       fprintf(yyout, " ");

{Llave-a}       fprintf(yyout, "Llave-a = {");
{Parent-a}      fprintf(yyout, "Parent-a = (");
{Parent-c}      fprintf(yyout, "Parent-c = )");
{Corchete-a}    fprintf(yyout, "Corchete-a = [");
{Corchete-c}    fprintf(yyout, "Corchete-c = ]");

{INT}           {total++;
                fprintf(yyout, "INT");
                }
{DOUBLE}        {total++;
                fprintf(yyout, "DOUBLE");
                
                }
{STRING}        {total++;
                fprintf(yyout, "STRING");
                }
{CHAR}          {total++;
                fprintf(yyout, "CHAR");
                }

{Cte-ent}       fprintf(yyout, "Cte-ent=%s ", yytext);
{Cte-real}      fprintf(yyout, "Cte-real=%s ", yytext);
{Cte-cadena}    fprintf(yyout, "Cte-cadena=%s ", yytext);
{variable}      {fprintf(yyout, "Id=%s ", yytext);
		 for(int n=0;n<strlen(yytext);n++)
		 ids[m][n]=yytext[n];
		 total2++;
		 m++;
		 ;}
{comentario}    fprintf(yyout, "Comentario=%s ", yytext);
{coma}          fprintf(yyout, "Coma=,");

{Op-mult}       fprintf(yyout, "Op-mult = *");
{Op-sum}        fprintf(yyout, "Op-sum = +");
{Op-sust}       fprintf(yyout, "Op-sust = -");
{Op-div}        fprintf(yyout, "Op-div = /");
{Op-asig}       fprintf(yyout, "Op-asig = =");
{Op-mod}        fprintf(yyout, "Op-mod = %");

{Op-mas-mas}    fprintf(yyout, "Op-MasMas = ++");
{Op-men-men}    fprintf(yyout, "Op-MenMen = --");
{Op-mas-asig}   fprintf(yyout, "Op-MasAsig = +=");
{Op-men-asig}   fprintf(yyout, "Op-MenAsig = -=");
{Op-por-asig}   fprintf(yyout, "Op-PorAsig = *=");
{Op-div-asig}   fprintf(yyout, "Op-DivAsig = /=");

{Igual-a}       fprintf(yyout, "Igual-a = ==");
{Menor-igual}   fprintf(yyout, "Menor-igual = <=");
{Mayor-igual}   fprintf(yyout, "Mayor-igual = >=");
{Diferente}     fprintf(yyout, "Diferente-a = !=");
{Mayor}         fprintf(yyout, "Mayor-que = >");
{Menor}         fprintf(yyout, "Menor-que = <");

{op-y}          fprintf(yyout, "Op-y = &&");
{op-o}          fprintf(yyout, "Op-o = ||");
{op-no}         fprintf(yyout, "Op-no = !");

{punto-y-coma}  fprintf(yyout, "Punto-coma=;");

{Llave-c}       fprintf(yyout, "Llave-c = }");

.               fprintf(yyout, "ERROR=%s ", yytext);

%%

main()
{
extern FILE *yyin, *yyout; 
    yyin = fopen("prueba.java", "r"); 
    int suma = 0;
    yyout = fopen("salida.txt", "w"); 
    yylex();
    fprintf(yyout,"\n\n\n\n\nTABLA DE IDENTIFICADORES\n"); 
    m=0;
    while(m<total2){
    int l=0;
    int rep=1;
    if (m==0){
    suma++;
    }else{
    	while(l<m){
	int temp= strcmp(ids[m],ids[l]);
    	   if(temp == 0){
    	   	rep=0;
    	   }
    	l++;
    	}
    	if(rep==1){
    	suma++;
    	}
    }
    m++;
    }
    fprintf(yyout,"Hay %d identificadores\n",suma);
    m=0;
    while(m<total2){
    int l=0;
    int rep=1;
    if (m==0){
    fprintf(yyout, "Id = %s ;", ids[m]);
    suma++;
    }else{
    	while(l<m){
	int temp= strcmp(ids[m],ids[l]);
    	   if(temp == 0){
    	   	rep=0;
    	   }
    	l++;
    	}
    	if(rep==1){
    	fprintf(yyout, "Id = %s ;", ids[m]);
    	suma++;
    	}
    }
    m++;
    }
}

%{
#include<stdio.h>
#include<string.h>
%}

/*
Steps:
1. Extract all words (of the form [a-zA-Z]+) from the input paragraph.
2. Iterate through the words to find if there is a 'e' or 'E', if so replace it with 'y' and 'Y' respectively.
*/

%%
[a-zA-Z]+    { 
   int i;
   for(i=0; yytext[i]!='\0'; i++) {
      if(yytext[i]=='e')
         fprintf(yyout, "%c", 'y');
      else if(yytext[i]=='E')
         fprintf(yyout, "%c", 'Y');
      else
         fprintf(yyout, "%c", yytext[i]);
      }
     fprintf(yyout, "%c", yytext[i]);
   }
%%

int yywrap() {
   return 1;
}

int main() {

   // declare external file variables
   extern FILE *yyin, *yyout;

   // read input from input.txt
   yyin=fopen("input.txt", "r");
   
   // write output to output.txt
   yyout=fopen("output.txt", "w");
      
   yylex();
}

%{
#include<stdio.h>
#include<string.h>

// initialise i with 0 (the counter variable)
int i = 0;
%}

/*
Define the regex for words containing atleast one t and one vowel and increment counter
*/

%%
[a-zA-Z]*[aeiouAEIOU][a-zA-Z]*[tT][a-zA-Z]*|[a-zA-Z]*[tT][a-zA-Z]*[aeiouAEIOU][a-zA-Z]* {
    i++;
    fprintf(yyout,"%s", yytext);
}
%%

int yywrap(){
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

    // print the counter variable
    fprintf(yyout,"\n%d\n", i);

    return 0;
}

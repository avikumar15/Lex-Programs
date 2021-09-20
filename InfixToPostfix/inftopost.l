%{
#include<stdio.h>
#include<string.h>

/* Define stack as char array */
char stack[100];

int size=0;

/* Define stack operations: pop, top, and push */
void pop(){
    size--;
}

char top(){
    return stack[size-1];
}

void push(char c){
    stack[size]=c;
    size++;
}

int priority(char c){
    switch(c) {
        case '(':
            return 0;
        
        case ')':
            return 0;
        
        case '+':
            return 1;
        
        case '-':
            return 1;
        
        case '*':
            return 2;
        
        case '/':
            return 2;
    }
}
%}

%%
[a-zA-Z]? {
    printf("%c",yytext[0]);
}

[+\-\*\/\(\)] {   
    char op=yytext[0];
    if(size==0||op=='(')
        push(op); 
    else if(op==')') {
        while(top()!='('){
            printf("%c",top());
            pop();
        }
        pop();
    } else if(priority(op)>=priority(top())) {
        push(op);
    } else if(priority(op)<=priority(top())) {
        while(priority(op)<=priority(top())) {
            printf("%c",top());
            pop();
        }
        push(op);
    }
}
[\n]  {
    int i;
    for(i=size-1;i>=0;i--) {
        if(stack[i]!='('&&stack[i]!=')'){
            printf("%c",stack[i]);
        }
    }
    size=0;
}
%%

int yywrap() {
   return 1;
}

int main(){
   yylex();
}

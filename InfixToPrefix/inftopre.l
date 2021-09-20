%{
#include<stdio.h>
#include<string.h>
#include<math.h>
#include <stdlib.h>
#define MAX 20

/* Define stack as char array */
char stack[20], prefix[20];
char* infix;

int top = -1;

/* Define stack operations: pop, top, and push */

char *strrev(char *str) {
    char *p1, *p2;

    if (! str || ! *str)
        return str;
    
    for (p1 = str, p2 = str + strlen(str) - 1; p2 > p1; ++p1, --p2) {
        *p1 ^= *p2;
        *p2 ^= *p1;
        *p1 ^= *p2;
    }
    
    return str;
}

void push(int pos) {
    if(top < MAX-1) {
        top++;
        stack[top] = infix[pos];
    }
}

char pop() {
    char ch;
    ch = stack[top];
    stack[top] = '\0';
    top--;
    return(ch);
}

int precedence(char alpha) {
    if(alpha == '+' || alpha =='-') {
        return(1);
    }
    if(alpha == '*' || alpha =='/') {
        return(2);
    }
    return 0;
}

%}

%%
[a-zA-Z+\-\*\/\(\)]+ {
    infix = strrev(yytext);

    int i=0, j=0;

    while(infix[i] != '\0') {
        if(infix[i] >= 'a' && infix[i] <= 'z') {
            prefix[j] = infix[i];
            j++;
            i++;
        } else if(infix[i] == ')' || infix[i] == '}' || infix[i] == ']') {
            push(i);
            i++;
        } else if(infix[i] == '(' || infix[i] == '{' || infix[i] == '[') {
        
            if(infix[i] == '(') {
                while(stack[top] != ')') {
                    prefix[j] = pop();
                    j++;
                }
                pop();
                i++;
            } else if(infix[i] == '[') {
                while(stack[top] != ']') {
                    prefix[j] = pop();
                    j++;
                }
                pop();
                i++;
            } else if(infix[i] == '{') {
                while(stack[top] != '}') {
                    prefix[j] = pop();
                    j++;
                }
                pop();
                i++;
            }
        } else {
            if(top == -1) {
                push(i);
                i++;
            } else if( precedence(infix[i]) < precedence(stack[top])) {
                prefix[j] = pop();
                j++;
                while(precedence(stack[top]) > precedence(infix[i])){
                    prefix[j] = pop();
                    j++;
                    if(top < 0) {
                        break;
                    }
                }
                push(i);
                i++;
            } else if(precedence(infix[i]) >= precedence(stack[top])) {
                push(i);
                i++;
            }
        }
    }

    while(top!=-1) {
        prefix[j] = pop();
        j++;
    }

    strrev(prefix);
    prefix[j] = '\0';
    
    printf("%s", prefix);
}
%%

int yywrap() {
   return 1;
}

int main(){
   yylex();
}

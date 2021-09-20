%{
#include <bits/stdc++.h>

using namespace std;

string s1, s2, s3;

int currentSegment = 1;
bool flag = false;
int parStack = 0;

void doWhileHeader() {
    cout << s1 << ";\n";
    cout << "do";
}

void incrementer() {
    cout << s3 << ";\n";
}

void condition() {
    cout << "if("+s2+") {";
}

%} 

%%

for[(] {
    currentSegment = 1;
    s1 = "";
    s2 = "";
    s3 = "";
    flag = true;
    parStack = 0;
}

[{] {
    parStack++;
    printf("%s\n", yytext);
    condition();
}

[}] {
    parStack--;
    if (parStack == 0) {
        incrementer();
    }
    printf("%s else {\nbreak;\n}\n} while(1);\n", yytext);
}

[;] {
    if (flag) currentSegment++;
    else {
        printf("%s", yytext);
    }
}

[)] {
    if (flag) {
        flag = false;
        doWhileHeader();
    } else {
        printf("%s", yytext);
    }
}

. {
    if (flag) {
        switch(currentSegment) {
            case 1: {
                s1 += yytext;
                break;
            }
            case 2: {
                s2 += yytext;
                break;
            }
            default: {
                s3 += yytext;
            }
        }
    } else {
        printf("%s", yytext);
    }
}


%% 

int yywrap() {}

int main() {
    extern FILE *yyin;
    yyin = fopen("input.c", "r");
    freopen("output.c", "w", stdout);
    yylex();
    return 0;
}

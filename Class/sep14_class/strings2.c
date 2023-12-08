#include<stdio.h>

int main(void){
    char fmtstring[]="%[^\n]31s";
    char instring[32];
    puts("Please type a string\t");
    scanf(fmtstring,instring);
    printf("Your string is %s: \n",instring);
    return 0;
}
#include<stdio.h>

extern long int stringLength(char string[])


int main(void){

    char mystring[] = "Wabash Always Fights";
    long int ans;

    ans = stringLength(mystring);




    return 0;
}
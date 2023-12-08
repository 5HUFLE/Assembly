#include<stdio.h>

int main(void){
    char mychar = 'a';
    char mystring[]= "Hello";

    printf("The character is %c\n",mychar);
    printf("The string is %s \n",mystring);
    printf("The string is located at %p \n",&mystring);

    return 0;
}
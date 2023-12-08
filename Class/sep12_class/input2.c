#include<stdio.h>


int main(void){
    char instring1[] = "%i";
    int myint;
    
    printf("Please type an integer: \n");
    scanf("%i", &myint);

    printf("Your integer is: %i and is located at %p \n",myint,&myint);
    return 0;
}
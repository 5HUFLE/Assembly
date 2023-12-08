#include<stdio.h>


int mystringLen(char string[]){
    int i = 0;
    while (string[i]!='\0'){
        i++;}
    return i;
}
int main(void){
    char string1[]="%31[^\n]s" ;
    char mainstring[32];
    printf("Enter the string \t");
    scanf(string1,mainstring);

    printf("Your string is %s \n", mainstring);
    int a = mystringLen(mainstring);
    printf("Your string length is %i \n",a);
    
    return 0;
}
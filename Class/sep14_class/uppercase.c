#include<stdio.h>


void uppercase(char string[]){
    int i =0;
    while(string[i]!= '\0'){
        if ((string[i]>=0x61)&&(string[i]<=0x7A)){
            string[i]=string[i]-0x20;
        }
        i++;
    }

}


int main(void){
    char fmtstring[]="%[^\n]31s";
    char instring[32];
    puts("Please type a string\t");
    scanf(fmtstring,instring);
    printf("Your string is %s: \n",instring);

    uppercase(instring);
    printf("The upper case is: %s\n",instring);
    return 0;
}
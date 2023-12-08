#include<stdio.h>


void Caesar(char *stringname, int number){
    int i = 0;
    while (stringname[i] != '\0'){
        if (stringname[i]>=0x41 && stringname[i]<=0x5A){
            stringname[i]=0x41+((stringname[i]+number-0x41)%26);
        }
        else if (stringname[i]>=0x61 && stringname[i]<=0x7A)
        {
            stringname[i]=0x61+((stringname[i]+number-0x61)%26);\
        }
        i++;
    }
}
int main(void){
    char input1[] ="%31[^\n]s";
    char input2[64];
    int num;
    printf("Enter your string \t");
    scanf(input1,input2);
    printf("Your string is %s \n",input2);
    printf("Enter the number of rotation \t");
    fflush(stdin);
    scanf("%d",&num);


    Caesar(input2,num);
    printf("Your cipher text is %s \n",input2);
    return 0;
}
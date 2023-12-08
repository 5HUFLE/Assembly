#include<stdio.h>


void StringReverse (char *string1, int len1, char *string2){
    int i = 0;
    int j = len1 ;
    while (j<= 0,j--){
        string2[i] = string1[j];
        i++;
    }
    string2[i] = '\0';
}

void IntToString(int input1, char *string1){
    int i = 0;
    int negative = 0;

    if(input1<0){
        input1 = input1 *-1;
        negative = 1;
    }

    if(input1 == 0){
        string1[i]='0';
    }

    while(input1>0){
        int remainder = input1%10;
        string1[i] = remainder+'0';
        i++;
        input1 = input1/10;

    }

    if(negative==1){
        string1[i]='-';
        i++;
    }

    string1[i]='\0';

}

int StringLength(char *string){
    int i = 0;
    while (string[i]!='\0'){
        i++;}
    return i;
}
int main(void){
    char input1[]= "%31[^\n]s";
    char input2[64];
    char output1[64];

    printf("Enter the string \t ");
    scanf(input1,input2);
    int lenstring = StringLength(input2);
    StringReverse(input2,lenstring,output1);
    printf("Your reverse string is %s\n",output1);




    int integer;
    char output2[64];
    char final_output[64];
    printf("Enter the int to be converted to str \t");
    fflush(stdin);
    scanf("%d",&integer);
    IntToString(integer,output2);
    int len_out2 = strlen(output2);
    StringReverse(output2,len_out2,final_output);
    printf("Your final string is %s \n",final_output);



    
    return 0;
}
#include<stdio.h>
int string_to_int(char *string_name){
    int i = 0;
    int sign = 1;
    int integer= 0;
    int final_int = 0;

    if (string_name[i] == '-'){
        sign = -1;
        i = 1;
    }
    while (string_name[i] != '\0'){
        integer = integer *10 + string_name[i]-'0';
        i++;
    }

    final_int = sign*integer;
    return final_int;

}
int main(void){
    char input1[] = "%31[^\n]s";
    char input2[64];
    printf("Enter your string: \t");
    scanf(input1,input2);
    int output2 = string_to_int(input2);
    printf("The integer is %i \t ", output2);
}
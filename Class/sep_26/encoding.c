#include<stdio.h>

int main(void){
    int int1 = 1831;
    double float1 = 7.5;
    long int int2 = 1778;
    double float2 = -4.25;

    printf("int1 is located at %p \n", &int1);
    printf("floar1 is located at %p \n", &float1);
    printf("long int is located at %p \n", &int2);
    printf("double is located at %p \n", &float2);
    return 0;

}
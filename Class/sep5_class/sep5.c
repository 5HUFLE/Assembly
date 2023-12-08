#include<stdio.h>


int addnums(int num1, int num2)
{
    return num1+num2;
}

extern int subnum(int num1, int num2); //By putting a semi colon after a function and extern before it you can define it later or call it from another module

int main(void)
{
    int ans = addnums(53,54);
    printf("The sum of %i and %i is %i \n",53,54,ans);

    int sub = subnum(100,50);
    printf("The difference of %i and %i is %i \n", 100, 50, subnum);
    return 0;
}
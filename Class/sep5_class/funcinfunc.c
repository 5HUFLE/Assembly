#include<stdio.h>


int factorial(int n)
{
    if (n<2)
    {
        return 1;
    }
    else
    {
        return n*factorial(n-1);
    }
}

int main(void){
    int ans = factorial(5);
    printf("%i! is %i\n", 5, ans);
    return 0;
}
#include <stdio.h>

int main(void)
{
    int max = 9;

    for(int i=0; i<=max; i++)
    {
        int j = i*i;
        printf("%i \t %i\n",i,j);
    }
    return 0;
}
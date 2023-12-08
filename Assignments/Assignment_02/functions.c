#include<stdio.h>


long int sumsquares(int number){
    if (number<=0){
        return 0;
    }
    else{
        return number*number+sumsquares(number-1);
    }

}


int main(void){
    long int ans = sumsquares(5);
    printf("The sum of square of first %li inegers is %li \n",5,ans);
    return 0;
}
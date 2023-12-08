#include<stdio.h>



int fibrec(int numrec){
    if (numrec<=2){
        return 1;
    }
    else{
        return fibrec(numrec-2)+fibrec(numrec-1);
    }
}

int fibiter(int numite){
    if (numite <=2){
        return 1;
    }
    else{
    int pnum1 = 1;
    int pnum2 =1;
    int ans =0;
    for (int i = 3;i<=numite;i++){
        ans = pnum1 + pnum2;
        pnum2 = pnum1 ;
        pnum1 = ans;

    }
    return ans;}
}


int main(void){
    int number;
    printf("Type a number \t");
    scanf("%i",&number);

    int iter = fibiter(number);
    printf("The Fibonacci of %i through iteration is %i \n",number,iter);


    int recu = fibrec(number);
    printf("The Fibonacci of %i through recurssion is %i \n",number,recu);
 

    return 0;
}
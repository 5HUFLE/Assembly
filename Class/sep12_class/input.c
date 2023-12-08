#include<stdio.h>



int main(void){
char instring1[] = "%s";
char instring2[32];
char outstring1[] = "Please type a string \n";
char outsrting2[]= "Your string was: %s";

printf("%s",outstring1);
scanf("%31s",instring2);
printf(outsrting2,instring2);
printf("%s","\n");
pitf("THe string is at %p",&instring2);

return 0;
}
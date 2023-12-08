#include<stdio.h>
#include<math.h>

void flush(){
    char tempcharbuf;
    while((tempcharbuf=getchar())!= EOF && tempcharbuf != '\n');
}

struct point
{
    double x,y;
};

struct  triangle
{
    struct point ptA, ptB , ptC;
};

double distance(struct point ptA, struct point ptB){
    double temp1 = ptA.x - ptB.x;
    double temp2 = ptA.y - ptB.y;
    temp1 = temp1*temp1;
    temp2 = temp2*temp2;
    return sqrt(temp1+temp2);
}



int main(void){
    struct point pt1 = {3.14,5.7};
    struct point pt2 = {7,5};
    struct point pt3 = {-1,0};
    struct triangle mytri = {pt1,pt2,pt3};


}
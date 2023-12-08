#include<stdio.h>
#include<math.h>


void flush(){
    char tempcharbuf;
    while((tempcharbuf=getchar())!= EOF && tempcharbuf != '\n');
}


struct point
{
    double x,y,z;
};

struct triangle
{
    struct point ptA, ptB, ptC;
};

struct tetrahedron
{
    struct point pt1,pt2,pt3,pt4;
};

double dist(struct point ptA,struct point ptB){
    double dist1 = ptA.x - ptB.x;
    double dist2 = ptA.y - ptB.y;
    double dist3 = ptA.z - ptB.z;


    double output = sqrt(dist1*dist1+dist2*dist2+dist3*dist3);
    return output;

}

double area_tri(struct point ptA,struct point ptB, struct point ptC){
    double dist_atb = dist(ptA,ptB);
    double dist_atc = dist(ptA,ptC);
    double dist_btc = dist(ptB,ptC);
    double semi_per = (dist_atb+dist_atc+dist_btc)/2;

    double area = sqrt(semi_per*(semi_per-dist_atb)*(semi_per-dist_atc)*(semi_per-dist_btc));
    return area;
}


double area_tet(struct point pt1, struct point pt2, struct point pt3,struct point pt4){
    double a1 = area_tri(pt1,pt2,pt3);
    double a2 = area_tri(pt1,pt2,pt4);
    double a3 = area_tri(pt2,pt3,pt4);
    double a4= area_tri(pt1,pt3,pt4);

    double surf_tet = a1+a2+a3+a4;
    return surf_tet;

}


int main(void){
    struct point pt5 = {1.0,2.0,3.0};
    struct point pt6 = {1.0,4.0,0.0};
    struct point pt7 = {3.0,1.0,3.0};
    struct point pt8 = {2.0,0.0,1.0};

    double tet_area = area_tet(pt5,pt6,pt7,pt8);


    printf("The area of tetrahedral is %lf ",tet_area);
    return 0;

    
}
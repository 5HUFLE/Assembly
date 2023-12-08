.data
c1: .word 0x3fc90a4d //c1
c3: .word 0xbf24aaab //c3
c5: .word 0x3d94e916 //c5

mynum: .word 0x42340000
num90: .word 0x42B40000
outstr: .asciz "The sine of %1.15f is approx %1.15f \n"
.text


.global main
main:

stp x29,x30,[sp,#-16]!

ldr x0,=mynum
ldr s0,[x0]  //has 45

ldr x0,=num90
ldr s1,[x0] //has 90

fdiv s2,s0,s1  //s2 has num div by 90 ==input value "x" as in pdf
fmul s3,s2,s2   //s3 is x^2


//polynomial: x(c1+x^2(c3+x^2*c5))

ldr x0,=c1  //this loads the address
ldr s4,[x0]
ldr x0, =c3
ldr s5,[x0]
ldr x0,=c5
ldr s6,[x0]

fmla s5,s3,s6  //multiplies s3,s6 and adds s5 then sotres in s5
//so s5 = (c3+x^2*c5)

fmla s4,s3,s5 //c1+x^2 * (c3+x^2*c5)

fmul s1,s2,s4
//fial answer is in s1


//print
ldr x0,=outstr
fcvt d0,s0
fcvt d1,s1
bl printf

ldp x29, x30,[sp],#16
mov w0,#0
ret
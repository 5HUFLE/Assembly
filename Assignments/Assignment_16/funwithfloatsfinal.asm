.data
num: .dword 0x0000000000000000 
ans: .dword 0x0000000000000000
newto_num: .dword 0x0
one: .dword 0x3FF0000000000000


magic: .dword 0x5FE6EB50C7B537A9
ex2: .dword 0x0
y: .dword 0x0
i: .dword 0x0
threehalfs: .dword 0x3FF8000000000000
onehalf: .dword 0x3FE0000000000000
mystr: .asciz "The fast inverse square root of %1.15f using %li Newton iterations is %1.15f. \n"
instr1: .asciz "Please type a float"
instr2: .asciz "%lf"
instr3: .asciz "%li"
newprmt: .asciz "How many times do you want the newton iteration \n"
armtest: .asciz "The arm value is %1.15f \n"
.text

.global main
main:

stp x29, x30, [sp, #-16]!
negcheck:
ldr x0, =instr1
bl puts

ldr x0, =instr2
ldr x1, =num
bl scanf 
ldr x1, =num
ldr d0, [x1]
fcmpe d0,#0.0 //cmp for negative
b.lt negcheck
//ldr x1,=num
//str d0,[x1]

bl squareRoot
ldr x0,=armtest
bl printf

//Below enter newton number
ldr x0,=newprmt
bl puts
ldr x0,=instr3
ldr x1,=newto_num
bl scanf

ldr x1,=newto_num
ldr x0,[x1]
//End of newton number
ldr x1, =num
ldr d0, [x1]

bl finvsqrt

fmov d1,d0      //store final result in d1
ldr x0,=num
ldr d0,[x0]  //the float passed
ldr x0,=newto_num
ldr x1,[x0]

ldr x0,=mystr
bl printf



ldp x29, x30, [sp], #16
mov w0, #0
ret


// float finvsqrt(float x)


.global squareRoot
squareRoot:
    stp x29, x30, [sp, #-16]!
    //d0 has the num
    ldr x1,=one
    ldr d1,[x1]
    fsqrt d2,d0
    fdiv d0,d1,d2
    ldp x29, x30, [sp], #16
    ret


.global finvsqrt
finvsqrt:
    stp x29,x30,[sp,#-16]!
    //d0 has the number input
    mov x5,x0   //put the iteration in d5 did it last so d5

    ldr x0,=onehalf
    ldr d1,[x0]

    fmul d2,d0,d1   //0.5*num = ex2

    ldr x0,=ex2
    str d2,[x0]

    //y = number 
    ldr x0,=y
    str d0,[x0] //store the num to the address y

    //move the float into integer register
    fmov x0, d0
    ldr x1,=i
    str x0,[x1] //stores float as int in i

    //i = magic num- i>>1  
    lsr x0,x0, #1  //right shift i by1
    ldr x2,=magic
    ldr x1,[x2] //load the magic num
    sub x0,x1,x0    //update the value of i

    ldr x1,=i
    str x0,[x1]

    //convert y to float
    fmov d0,x0
    ldr x1,=y
    str d0,[x1] //the value of y is updated in memory

 return:   
    cmp x5,#0
    b.le newton_end
    //y=y*(threehalf-(x2*y*y))
    ldr x0,=threehalfs
    ldr d1,[x0]
    ldr x0,=ex2
    ldr d2,[x0]
    //d0 has y and d1 has 1.5F and d2 has ex2

    fmul d3,d0,d0   //s3 has y^2
    fmul d3,d3,d2   //x2*y^2
    fsub d3,d1,d3
    fmul d0,d0,d3   //y is updated

    // ldr x0,=one     //time to count the iteration
    // ldr d4,[x0]     
    sub x5,x5,#1

    ldr x0,=y
    str d0,[x0]
    b return

newton_end:
    ldp x29,x30,[sp],16
    ret

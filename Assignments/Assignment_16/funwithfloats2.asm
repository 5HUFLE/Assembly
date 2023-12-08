.data
magic: .dword 0x5FE6EB50C7B537A9
ex2: .dword 0x0
y: .dword 0x0
i: .dword 0x0
threehalfs: .dword 0x3FF8000000000000
onehalf: .dword 0x3FE0000000000000

.text

.global finvsqrt
finvsqrt:
    stp x29,x30,[sp,#-16]!
    //d0 has the number input
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
    
    newtonmethod:
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

    ldr x0,=y
    str d0,[x0]


    ldp x29,x30,[sp],16
    mov w0,#0
    ret

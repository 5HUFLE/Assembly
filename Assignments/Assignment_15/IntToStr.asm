.data
initStr: .dword 0x0 // allocation for for a string 
initInt: .dword 0x0 // allocation for the int
finstr: .dword 0x0
Int_prmt: .asciz "The integer is %i \n" //spits out the answer
Str_prmt: .asciz "The string version is %s\n" // print the string version
Int_inprmt: .asciz "Enter the Integer \n" //request user number
inp_frmt: .asciz "%li" //format for the integer
.text


.global main
main:
    stp x29, x30, [sp, #-16]!

    ldr x0,=Int_inprmt
    bl puts

    ldr x0,= inp_frmt
    ldr x1,=initInt
    bl scanf
    ldr x2,=initInt
    ldr x1,[x2]
    ldr x0,=Int_prmt
    bl printf

mov w0,#32
bl malloc
ldr x1,=initStr
str x0,[x1]

mov w0,#32
bl malloc
ldr x1,=finstr
str x0,[x1]
//sending it to int->str
    ldr x0,=initInt
    ldr x0,[x0]
    ldr x2,=initStr
    ldr x1,[x2]
    ldr x2,=finstr
    ldr x2,[x2]
    bl InttoString

    ldp x29, x30, [sp], #16
    mov w0, #0
    ret


.global InttoString
InttoString:
//x0 is the integer, and x1 is the ptr to the string and x2 is the finalptr to str
    stp x29, x30, [sp, #-16]!


    mov x26,#1 //if its 0 need to add -ve sign
    mov x25,x0 //backup when x0 is going to be into str
    cmp x0,#0
    b.le negative   
    //x0 is convertedt to positive

    ldr x2, [x0]
    mov x3,#10
    mov x6,#0   //pgrm counter

    loop:
    //Remainer code
    udiv x7,x2,x3 
    mul x7,x7,x3
    sub x4,x2,x7    //x4 has the remainder
    udiv x2,x2,x3  //reduces the number by 10

    mov x5,#'0'
    add x5,x5,x4 //adds 0x00 to the remainder to  cnvt to str
    //char concatanation code
    strb w5, [x1,x6]
    add x6,x6,#1
    cbz x2,exit_loop  //check if the number has reached zero
    b loop



    exit_loop:
    cmp x26,#0
    b.eq add_negsig
    //to send it to str rev
    ldr x0, [x1]
    ldr x1,[x1]
    ldr x2,[x6] //x6 is prgm ctr so x6 is eql to len str

    bl stringReverse

    //x0 is reversed str now


    ldp x29, x30, [sp], #16
    ret

    negative:
    mov x24,#-1
    mul x0,x0,x24
    mov x26,#0
    ret

    add_negsig:
    mov w5,#'-'
    strb w5,[x1,x6]
    ret



.global stringReverse
stringReverse:
    stp x29, x30, [sp, #-16]! //x0 is word, x1 is ptr and x2 is len

    sub x2, x2, #1
    mov x3, #0

reverse_loop:
    ldrb w4, [x0, x2] 
    cbz w4, reverse_end 

    strb w4, [x1, x3] 
    add x3, x3, #1
    sub x2, x2, #1
    b reverse_loop

reverse_end:
    mov w4, #0
    strb w4, [x1, x3]
    mov x0, x1
    ldp x29, x30, [sp], #16
    ret



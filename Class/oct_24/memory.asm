.data


.text



.global main
main:
    stp x29,x30,[sp,#-16]!
    
    mov x0,#1832
    mov x1,#1776

    sub sp,sp,#16  //By doing this we are increaing the memory of stack pointer because the stack grows downwards

    stp x0,x1,[sp]
    add sp,sp,#16



    ldp x29,x30,[sp],#16

    mov w0,#0
    ret

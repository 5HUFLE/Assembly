.data
str: .asciz "The value is %i \n"

.text

.gloal main

main:
    stp x29,x30,[sp,#-16]!
    ldr x0,=str
    mov w1,#-1
    bl printf

    ldp x29,x30,[sp],#16
    mov w0,#0
    ret

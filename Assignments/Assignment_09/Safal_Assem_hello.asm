.data
hello_world: .asciz "Hello World \n"

.text 


.global main
main:
    stp x29,x30, [sp, #-16]!
    ldr x0, =hello_world
    b puts

    ldp x29,x30,[sp],#16
    mov w0,#0
    ret

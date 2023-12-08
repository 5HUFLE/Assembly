.data
outstr: .asciz "The sum of %i and %i is %i. \n"

.text



.global main
main:
    stp x29, x30, [sp, #-16]!
    mov w1, #2
    mov w2, #3
    add w3,w1,w2

    // printf           (outstr, num1, num2, sum);
    // outstr has to go in x0   w1      w2     w3
    ldr x0, =outstr
    bl printf
    ldp x29, x30, [sp], #16
    mov w0, #0
    ret 
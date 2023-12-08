.data
mystring: .asciz "The sum is %i\n"
num1:   .word 0x2
num2:   .word 0x3

.text


.global myadd
myadd:
    stp x29, x30, [sp,#-16]!
    add w0, w0, w1

    ldp x29, x30, [sp],#16
    ret

.global main
main:
    stp x29, x30, [sp,#-16]!

    mov w0, #2
    mov w1, #3
    bl myadd

    mov w1, w0
    ldr x0, = mystring
    bl printf

    ldr x4, = num1
    ldr wo,[x4]
    ldr x5, = num2
    ldr w1, [x5]


    ldp x29, x30, [sp],#16
    mov w0, #0
    ret
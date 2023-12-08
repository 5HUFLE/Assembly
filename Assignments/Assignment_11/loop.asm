.data
nobeer: .asciz "We're all out of beer!"
yesbeer: .asciz "%i bottles of beers on the wall, %i bottles of beer!  Take one down, pass it around... \n"

.text

.global main
main:


    stp x29,x30,[sp,#-16]!
    str x19, [sp,#-16]!

    mov w19, #5

    loop:
    cmp w19, #0
    b.le finish


    ldr x0,= yesbeer
    mov w1,w19
    mov w2,w1
    bl printf
    sub w19,w19,#1
    b loop

    finish:
    ldr x0,= nobeer
    bl puts
    ldr x19, [sp],#16
    ldp x29,x30,[sp],#16
    mov w0,#0
    ret

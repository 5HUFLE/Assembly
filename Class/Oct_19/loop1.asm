.data
outstr: .asciz "The square of %i is %i \n"

.text


.global main
main:
    stp x29,x30,[sp,#-16]!
    str x19, [sp,#-16]!
    mov w19,#1

    //loop condition
loop:
    cmp w19,#10
    b.gt finish //this is a condition for not looping rather than looping 
                //i.e the logical   opposite

    //loopbody
    ldr x0,=outstr
    mov w1, w19
    mul w2,w1,w1
    bl printf
    add w19,w19,#1
    b loop

    //stuff after loop
finish:
    ldp x29,x30,[sp],#16
    mov w0,#0
    ret


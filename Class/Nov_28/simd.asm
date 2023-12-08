.data
vec1: 
.word 0x3f800000
.word 0x40000000
.word 0x40400000
.word 0x40800000

vec2:
.word 0x40800000
.word 0x40400000
.word 0x40000000
.word 0x3f800000

printstr: .asciz "The answer is %f \n"


.text



.global main
main:
    stp x29, x30, [sp,#-16]!

    ldr x0,=vec1
    ldr x1,=vec2

    ld1 {v16.4s},[x0]
    ld1 {v17.4s},[x1]

    fmul v18.4s, v16.4s,v17.4s
    faddp v19.4s,v18.4s,v18.4s
    faddp s0,v19.2s

    fcvt d0,s0
    ldr x0,=printstr
    bl printf


    ldp x29,x30,[sp],#16
    mov w0,#0
    ret
    
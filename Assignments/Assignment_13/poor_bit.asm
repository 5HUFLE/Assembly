.data
string1: .asciz "The sum of 0x%016lx%016lx and 0x%016lx%016lx is 0x%016lx%016lx.\n"

no_carry: .asciz "No final carry"
yes_carry: .asciz "A final carry occured"

YL: .dword 0xFEEDCADEDEADBEEF 
XL: .dword 0xFFFF0000FFFF0000
XH: .dword 0xFFFF0000FFFF0FF0
YH: .dword 0xFFFF00FFFFFF0000
ZL: .dword 0x0000000000000000
ZH: .dword 0x0000000000000000

.text

.global main
main:
    stp x29,x30,[sp,#-16]!

    ldr x1,=XH
    ldr x2,=XL
    ldr x3,=YH
    ldr x4,=YL
    ldr x5,=ZH
    ldr x6,=ZL

    ldr x2,[x2]
    ldr x4,[x4]
    adds x7,x2,x4
    str x7,[x6]
    mov x6, x7

    ldr x1,[x1]
    ldr x3,[x3]
    adcs x8,x1,x3
    str x8,[x5]
    mov x5,x8

    str x20,[sp,#-16]!
    mrs x20, NZCV

    ldr x0,= string1
    bl printf

    msr NZCV,x20
    ldr x20,[sp],#16

    bcs if_carry
    ldr x0,=no_carry
    bl printf
    b end

    if_carry:
        ldr x0,=yes_carry
        bl printf

    end:
        ldp x29,x30,[sp],#16
        mov w0,#0
        ret

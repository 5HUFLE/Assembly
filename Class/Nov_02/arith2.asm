.data


.text



.global main
main:
    stp x29,x30,[sp,#-16]!

    // addition instructions: add, addc, adds, addcs


    ldp x29x30,[sp],#16
    mov w0,#0
    ret

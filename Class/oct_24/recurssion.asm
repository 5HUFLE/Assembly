.data

.text

.global main
main:
    stp x29,x30,[sp,#-16]!



    ldp x29,x30,[sp],#16
    mov w0,#0
    ret


.global factorial
factorial:
    stp x29,x30,[sp,#-16]!
    //base case
    cmp x0,#1
    b.gt recursivecase
    basecase:
        mov x0,#1
        b end

    recursivecase:




    end:
    ldp x29,x30,[sp],#16
    ret
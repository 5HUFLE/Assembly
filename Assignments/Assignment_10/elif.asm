.data
positive: .asciz "Positive \n"
negative: .asciz "Negative \n"
zero: .asciz "Zero \n"

.text


.global main
main:
    stp x29,x30,[sp,#-16]!
    mov w0,#5
    cmp w0,#0
    b.gt Positive
    b.lt Negative
    ldr x0,=zero
    bl puts
    b end



    Positive:
    ldr x0,=positive
    bl puts
    b end

    Negative:
    ldr x0,=negative
    bl puts
    b end

    end:
    ldp x29,x30,[sp],#16
    mov w0,#0
    ret

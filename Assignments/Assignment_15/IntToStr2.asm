.data
    str1: .asciz "Enter an int"
    str2: .asciz "Int to string %s\n"
    str3: .asciz "%18li"
    mynum: .dword 0x0
    ptr1: .dword 0x0
    ptr2: .dword 0x0
    integer: .asciz "This is your integer %li\n"

 
.text
.global main
main:
    stp x29, x30, [sp, #-16]!

    ldr x0,=str1
    bl puts

    ldr x0, =str3
    ldr x1, =mynum
    bl scanf

    ldr x0, =integer
    ldr x1, =mynum
    ldr x1, [x1]
    bl printf

    mov w0, #32
    bl malloc
    ldr x2, =ptr1
    str x0, [x2]

    mov w0, #32
    bl malloc
    ldr x3, =ptr2
    str x0, [x3]

    ldr x0, =mynum
    ldr x0, [x0]
    ldr x1, =ptr1
    ldr x1, [x1]
    ldr x2, =ptr2
    ldr x2, [x2]
    mov x3, x0
    mov x0, x3
    bl intToString  

    mov x1, x0
    ldr x0, =str2
    bl printf


    ldp x29, x30, [sp], #16
    mov w0, #0
    ret

.global intToString
intToString:
    stp x29, x30, [sp, #-16]!
    // x0 integer
    // x1 pointer
    // x2 pointer to output
    mov x3, #1       // sign
    mov x4, #0       // counter
    mov x5, #10      // multiplier
    mov x6, #0       // stores after division
    mov x7, #0       // current number

    cmp x0, #0
    b.gt positive

    mov x3, #-1      // negative sign
    mul x0, x0, x3   // make x0 positive

positive:
    udiv x6, x0, x5  // x6 = x0 / 10
    mul x6, x6, x5  // x6 = x6 * 10
    sub x7, x0, x6   // x7 = x0 - x6
    add x7, x7, #'0'
    strb w7, [x1, x4]
    add x4, x4, #1
    udiv x0, x6, x5  // x0 = x6 / 10
    cmp x0, #10
    b.lt end_convert
    b positive

end_convert:
    mov x7, x0
    add x7, x7, #48
    strb w7, [x1, x4]
    add x4, x4, #1
    cmp x3, #0
    b.gt check
    mov w7, #45
    strb w7, [x1, x4]
    add x4, x4, #1

check:
    mov x0, x1
    mov x1, x2
    mov x2, x4
    bl StringReverse

    ldp x29,x30,[sp],#16
    ret


.global StringReverse
StringReverse:
    stp x29, x30, [sp, #-16]!

    sub x2, x2, #1            // move to the end of the string
    mov x3, #0

    reverse_loop:
        ldrb w4, [x0, x2]     // load byte from original string
        strb w4, [x1, x3]
        add x3, x3, #1        //move to the next character
        sub x2, x2, #1       // decrement the length
        cbnz w4, reverse_loop //if not null terminator, keep the loop going on
        b end_reverse

    end_reverse:
    mov x0, x1
    ldp x29, x30, [sp], #16
    ret
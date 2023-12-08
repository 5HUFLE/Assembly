
.data
input_prmt: .asciz "Please enter the string to reverse"
input_frmt: .asciz "15%s"
out_prmt: .asciz "Your entered string is %s\n"
in_word: .dword 0x0
reversed_word: .dword 0x0
result: .asciz "The reversed string is %s\n"

.text


.global main
main:
    stp x29, x30, [sp, #-16]!

    ldr x0, =input_prmt
    bl puts

    ldr x0, =input_frmt
    ldr x1, =in_word
    bl scanf

    ldr x0, =out_prmt
    ldr x1, =in_word
    bl printf

    ldr x0, =in_word
    bl stringlength

    // push length to stack
    str x0, [sp, #-16]!

    // use of malloc
    mov w0, #16
    bl malloc
    ldr x3, =reversed_word
    bl free

    ldr x0, =in_word
    mov x1, x3
    ldr x0, [sp], #16
    mov x2, x0
    ldr x0, =in_word
    bl stringReverse

    mov x1, x0
    ldr x0, =result
    bl printf

    ldp x29, x30, [sp], #16
    mov w0, #0
    ret

.global stringReverse
stringReverse:
    stp x29, x30, [sp, #-16]! //x0 is word, x1 is ptr and x2 is len

    sub x2, x2, #1
    mov x3, #0

reverse_loop:
    ldrb w4, [x0, x2] 
    cbz w4, reverse_end 
    strb w4, [x1, x3] 
    add x3, x3, #1
    sub x2, x2, #1
    b reverse_loop

reverse_end:
    mov w4, #0
    strb w4, [x1, x3]
    mov x0, x1
    ldp x29, x30, [sp], #16
    ret



.global stringlength
stringlength:
    stp x29, x30, [sp, #-16]!
    mov x2, #0

    loop:
        ldrb w1, [x0, x2]
        cbz w1, end
        add x2, x2, #1
        b loop

//     end:
//     mov x0, x2
//     ldp x29, x30, [sp], #16
//     ret

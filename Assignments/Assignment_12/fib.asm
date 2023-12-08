.data
user_input: .asciz "Enter your number"
number: .asciz "%i"
output: .asciz "Fibonacci number %i is %i \n"
my_address: .word 0x0


.text


.global main
main:
    stp x29, x30, [sp, #-16]!
    str x20, [sp, #-16]!

    ldr x0,=user_input
    bl puts

    ldr x0,=number
    ldr x1,=my_address
    bl scanf

    ldr x1,=my_address
    ldr x0, [x1]

    mov x20,x0
    bl fib

    mov x1,x20
    mov x2,x0
    ldr x0,=output
    bl printf

    ldr x20, [sp], #16
    ldp x29, x30, [sp], #16
    mov w0, #0
    ret

.global fib
fib:
    stp x29, x30, [sp, #-16]!

    cmp x0,#2
    b.gt recursivecase

    basecase:
        mov x0,#1
        b end

    recursivecase:
        sub x0,x0,#1
        str x0, [sp, #-16]! 
        bl fib  //calculating (n-1)
        ldr x1,[sp],#16   //x1 has value n-1

        str x0,[sp,#-16]! //store f(n-1) in stack
        sub x0,x1,#1
        bl fib //calculate (n-1)
        ldr x1,[sp],#16 //x1 has value f(n-1)

        add x0,x0,x1


    end:
        ldp x29, x30, [sp], #16
        ret 

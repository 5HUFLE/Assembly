.data

hellostr: .asciz "Hello, world! \n"
goodbye: .asciz "Goodbye \n"


.text


.global main
main:
    stp x29,x30,[sp,#-16]!

    mov x0, #0
    // check if x0 == 0 or not
    mov x1,#0
    cmp x0,x1 //does x1-x0, disregards the results, checks for 0 flag
    b.eq printhello
    b printgoodbye

    printhello:                          
    ldr x0, = hellostr
    bl puts 
    b finish


    printgoodbye:
    ldr x0,=goodbye
    bl puts


    finish:
    ldp x29,x30,[sp],#16
    mov w0, #0
    ret
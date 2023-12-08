.data
String_memory: .dword 0x0 // allocation for for a string 
Integer_memory: .dword 0x0 // allocation for the int
Final_memory: .dword 0x0
Int_prmt: .asciz "The integer is %i \n" //spits out the answer
Str_prmt: .asciz "The string version is %s\n" // print the string version
Enter_intprmt: .asciz "Enter the Integer \n" //request user number
int_frmt: .asciz "%li" //format for the integer
.text


.global main
main:
    stp x29, x30, [sp, #-16]!

    ldr x0,=Enter_intprmt
    bl puts

    ldr x0,= int_frmt
    ldr x1,=Integer_memory
    bl scanf
    ldr x2,=Integer_memory
    ldr x1,[x2]
    ldr x0,=Int_prmt
    bl printf

mov w0,#32
bl malloc
ldr x1,=String_memory
str x0,[x1]

mov w0,#32
bl malloc
ldr x1,=Final_memory
str x0,[x1]
//sending it to int->str
    ldr x0,=Integer_memory
    ldr x0,[x0]
    ldr x2,=String_memory
    ldr x1,[x2]
    ldr x2,=Final_memory
    ldr x2,[x2]
    bl InttoString

    ldr x0,=Final_memory
    ldr x1,[x0]
    ldr x0,=Str_prmt
    bl printf
    ldp x29, x30, [sp], #16
    mov w0, #0
    ret


.global InttoString
InttoString:
    stp x29, x30, [sp, #-16]!
    //x0 in int, x1 is 1st ptr and x2 is 2nd ptr
    mov x4,#10  //for ml and div
    mov x5,#1   //if its 0 add -ve sign at the end
    mov x6,#0   //prgm counter
    
    cmp x0,#0
    b.le negative

str_loop:
    udiv x7,x0,x4   //x7 = x0 div 10
    mul x7,x7,x4
    sub x8, x0,x7   //x8 stores the remainder
    add x8,x8,#'0'
    strb w8,[x1,x6]
    add x6,x6,#1
    udiv x0,x0,x4   
    cmp x0,#10
    b.lt exit_loop
    b str_loop

exit_loop:

mov x8,x0
add x8,x8,#'0'
strb w8,[x1,x6]
add x6,x6,#1
cbz x5,add_negsig
b end

add_negsig:
mov w8,#'-'
strb w8, [x1,x6]
add x6,x6,#1
b end

negative:
mov x25,#-1
mul x0,x0,x25
mov x5,#0
b str_loop

end:
mov x0,x1
mov x1,x2
mov x2,x6
bl stringReverse

ldp x29, x30, [sp], #16
mov w0, #0
ret


.global stringReverse
stringReverse:
    stp x29, x30, [sp, #-16]! //x0 is word, x1 is ptr and x2 is len

    sub x2, x2, #1
    mov x3, #0  //prgm counter

reverse_loop:
    ldrb w5, [x0, x2] 
    strb w5, [x1, x3] 
    add x3, x3, #1
    sub x2, x2, #1
    cbnz w5, reverse_loop


    ldp x29, x30, [sp], #16
    ret


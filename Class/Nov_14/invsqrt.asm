.data

magic: .word 0x5F3759DF
num: .dword 0x00000000 
ans: .dword 0x00000000
mystr: .asciz "The fast inv sqrt of %f is %f.\n"
instr1: .asciz "Please type a float"
instr2: .asciz "%f"

.text

.global main
main:

stp x29, x30, [sp, #-16]!

ldr x0, =instr1
bl puts

ldr x0, =instr2
ldr x1, =num
bl scanf 

ldr x1, =num
str d0, [x1]
//ldr d0, [x1]
//fcvt s0, d0
//str s0, [x1]



ldr x0, =mystr
ldr x1, =num
ldr d0, [x1]
//fcvt d0, s0
ldr x1, =ans
ldr s1, [x1]
fcvt d1, s1
bl printf



ldp x29, x30, [sp], #16
mov w0, #0
ret

// float finvsqrt(float x)
.global finvsqrt
finvsqrt:
stp x29, x30, [sp, #-16]!




ldp x29, x30, [sp], #16
ret
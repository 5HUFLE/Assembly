.data
threehalfs: .dword 0x3FF8000000000000
onehalf: .dword 0x3FE0000000000000
magic: .dword 0x5FE6EB50C7B537A9
num: .dword 0x0000000000000000 
ans: .dword 0x0000000000000000
newto_num: .dword 0x0
one: .dword 0x3FF0000000000000


mystr: .asciz "The fast inverse square root of %1.15f using %li Newton iterations is %1.15f.  The ARM value is %1.15f.\n"
instr1: .asciz "Please type a float"
instr2: .asciz "%lf"
newprmt: .asciz "How many times do you want the newton iteration \n"
armtest: .asciz "The arm value is %1.15f \n"
.text

.global main
main:

stp x29, x30, [sp, #-16]!
negcheck:
ldr x0, =instr1
bl puts

ldr x0, =instr2
ldr x1, =num
bl scanf 
ldr x1, =num
ldr d0, [x1]
fcmpe d0,#0.0 //cmp for negative
b.lt negcheck

bl squareRoot
ldr x0,=armtest
bl printf

//Below enter newton number
ldr x0,=newprmt
bl puts
ldr x0,=instr2
ldr x1,=newto_num
bl scanf

ldr x1,=newto_num
ldr d1,[x1]
//End of newton number






ldp x29, x30, [sp], #16
mov w0, #0
ret


// float finvsqrt(float x)


.global squareRoot
squareRoot:
stp x29, x30, [sp, #-16]!
//d0 has the num
ldr x1,=one
ldr d1,[x1]
fsqrt d2,d0
fdiv d0,d1,d2
ldp x29, x30, [sp], #16
ret
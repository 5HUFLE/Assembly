.data

magic: .dword 0x5f3759df
ex2: .word 0x0
y: .word 0x0
i: .word 0x0
threehalfs: .word 0x3FC00000
onehalf: .word 0x3F000000

.text


//float finvsqrt(float number)
//s0 is the number coming in
//s1 is 0.5
.global finvsqrt
finvsqrt:
stp x29, x30, [sp,#-16]!

//x2 = num * 0.5
ldr x0,=onehalf
ldr s1,[x0]
fmul s2, s0, s1
ldr x0,=ex2
str s2,[x0]

//y = number
ldr x0,=y 
str s0,[x0]

//i = *(long*)&y
//changing float to int
fmov w0,s0
ldr x1, =i
str w0, [x1]

//i = 0x5f3759df - (i>>1)
//>> is bit sift by 1, this implies divide by 2
lsr w0,w0, #1 //right shift i by 1
ldr x2,=magic
ldr w1, [x2]
sub w0,w1,w0
ldr x1,=1
str w0,[x1]

//convert back to float
fmov s0,w0
ldr x1,=y 
str s0,[x1]

//y = y*(threehalfs-(x2*y*y))
ldr x0,=threehalfs
ldr s1,[x0]
ldr x0,=ex2
ldr s2,[x0]
//s0 has y, s1 has 1.5F, s2 has x2

fmul s3, s0,s0
fmul s3,s3,s2
fsub s3,s1,s3
fmul s0,s0,s3
ldr x0,=y 
str s0,[x0]


ldp x29,x30,[sp],#16
ret 



.data
 
   nestr: .asciz "The string you produced was -%s.\n"
   postr: .asciz "The string you prouducd was %s.\n"
   outstr: .asciz "The integer you typed was %li.\n"
   str1: .asciz "Please type a integer\n"
   instr: .asciz "%li"
   mynum: .dword 0x0000000000000000
   mynm: .dword 0x0234543234543234
   reversestr: .asciz "00000000000000000000000000000000"
   finalstr: .asciz "00000000000000000000000000000000"
 
.text
 
.global main
main:
 
   stp x29, x30, [sp, #-16]!
 
   ldr x0, =str1
   bl puts
 
   ldr x0, =instr
   ldr x1, =mynum
   bl scanf

   ldr x0, =mynum
   ldr x5, [x0] //the number that was typed
   ldr x2, =reversestr
   mov x3, #0 //used for counter
   mov x4, #10 //used for division
   bl check
   ldr x8, =finalstr 
   mov x9, #0 //alternative counter
   sub x3, x3, #1 //sub one from our counter that was used when coputing strlength
   bl reversecheck
 
   ldr x0, =mynum
   ldr x21, [x0] //number now in x21 because x5 was overlaoded
   mov x22, x8 //mov a copy of the final str into another register

   ldr x0, =outstr
   mov x1, x21 //print the original number
   bl printf

   mov x0, x21
   cmp x0, #0 //checks the original typed number to see if neg
   blt neggend
 
   ldr x0, =postr
   mov x1, x22 //if number wasnt negative prints the number
   bl printf 
 
end:
   ldp x29, x30, [sp], #16
   mov w0, #0
   ret

check: //negative checker...branches to negg which mul by 1 and flips it
   cmp x5, #0 //compare to make sure no null terminator
   blt negg
   cbnz x5, divstore //branches on not zero, once zero returns to main
   ret
 
   divstore: //divides and stores the new string
 
       sdiv x6, x5, x4 //Integer division...divides number by 10
       mul x6, x6, x4 //computes 10*quotient
       sub x5, x5, x6 //computes EX. 12345 - 10*1234
       add x5, x5, #0x30 //add hex30 to convert it to a character
       strb w5, [x2,x3] //stores the bit(remainder)
       add x3, x3, #1 //increment counter
       sdiv x5, x6, x4 //divides to reset to EX. 1234
       b check
 
reversecheck: //this is where we reverse the string

   add x10, x3, #1 //increments counter by one
   cbnz x10, reverse //on not zero branches to the reverse func
   strb wzr, [x8, x9] //the w zero register, no extra zeros when printing
   ret
 
   reverse: //reverses the string that was in reversestr and puts it in finalstr

       ldrb w0, [x2,x3] //loads from old string
       strb w0, [x8,x9] //stores in new string
       add x9, x9, #1 //adds to counter
       sub x3, x3, #1 //subs one from counter
       b reversecheck
 
negg://negative swapper
   mov x11, #-1 
   mul x5, x5, x11 //multiples by -1 to get a positive number 
   b check
 
 
neggend: //prints if the int was negative
   ldr x0, =nestr
   mov x1, x22
   bl printf
 
 
   ldp x29, x30, [sp], #16
   mov w0, #0
   ret
 
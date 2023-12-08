.data
//32 bit Apollo Coefficients
ctabApollo32:
  .word 0x3fc90a4d
  .word 0xbf24aaab
  .word 0x3d94e916

//64 bit Apollo Coefficients
ctabApollo64:
  .dword 0x3ff92149914389c3
  .dword 0xbfe49555673aa1bc
  .dword 0x3fb29d22bb15eb24

//32 bit Chebyshev Coefficients
ctabCheby32:
  .word 0x3fc90fdb
  .word 0xbf255de7
  .word 0x3da335e3
  .word 0xbb996966
  .word 0x39283c19
  .word 0xb6718319
  .word 0x33744fb8
  .word 0xb031481f

//64 bit Chebyshev Coefficients
ctabCheby64:
  .dword 0x3ff921fb54442d17
  .dword 0xbfe4abbce625bd83
  .dword 0x3fb466bc677522bd
  .dword 0xbf732d2cce1ea145
  .dword 0x3f25078327046959
  .dword 0xbece30631bdf732d
  .dword 0x3e6e89f6fe44fe7b
  .dword 0xbe062903d02bb153


//32 bit Taylor Coefficients
ctabTaylor32:
  .word 0x3fc90fdb
  .word 0xbf255de7
  .word 0x3da335e3
  .word 0xbb996966
  .word 0x39283c1a
  .word 0xb67183a8
  .word 0x33747a1a
  .word 0xb037d6dd

//64 bit Taylor Coefficients
ctabTaylor64:
  .dword 0x3ff921fb54442d18
  .dword 0xbfe4abbce625be53
  .dword 0x3fb466bc6775aae2
  .dword 0xbf732d2cce62bd86
  .dword 0x3f250783487ee782
  .dword 0xbece3074fde8871f
  .dword 0x3e6e8f434d018d63
  .dword 0xbe06fadb9f155744

inval: .dword 0x0
divval: .dword 0x0
prmpt: .asciz "Please type an angle in degrees."
taylor_out: .dword 0x0
cheby_out: .dword 0x0
appolo_out: .dword 0x0
instr: .asciz "%lf"
num90: .dword 0x4056800000000000
outstr: .asciz "The sine of %f degrees is\nApollo %1.15f\nChebyshev %1.15f\nTaylor %1.15f\n"


.text
.global main
main:
    stp x29, x30, [sp, #-16]!

    ldr x0,=prmpt
    bl printf
    ldr x0,=instr
    ldr x1,=inval
    bl scanf

    ldr x0,=inval
    ldr d0,[x0]
    ldr x0,=num90
    ldr d1,[x0]
    fdiv d0,d0,d1

    ldr x0,=divval 
    str d0,[x0] //store the div value so cancel div by 90

    ldr x0,=ctabTaylor64
    bl sinpi2x    
    // main() should accept user input, divide by 90, then pass that value
    // to three subroutines.  Two copies of sinpi2x, and Apollo.
    // It should then print everything.

    //d0 has the output from sin
    ldr x0,=taylor_out
    str d0,[x0]

    ldr x0,=divval
    ldr d0,[x0]
    ldr x0,=ctabCheby64
    bl sinpi2x   
  //d0 has cheby output
    ldr x0,=cheby_out
    str d0,[x0]


    ldr x0,=divval
    ldr d0,[x0]
    ldr x0,=ctabApollo64
    bl Apollo
    ldr x0,=appolo_out
    str d0,[x0]   //could just move it to d1 but store it just in case

    ldr x0,=inval
    ldr d0,[x0]

    ldr x0,=appolo_out
    ldr d1,[x0]

    ldr x0,=cheby_out
    ldr d2,[x0]

    ldr x0,=taylor_out
    ldr d3,[x0]



    ldr x0,=outstr
    bl printf



    ldp x29, x30, [sp], #16
    mov w0, #0
    ret



// double Apollo (double x)
// Should compute sin(pi/2*x) using the 5th degree formula only

.global Apollo
Apollo:
    stp x29, x30, [sp, #-16]!
    fmul d2,d0,d0 //d2=x2
    fmul d3,d0,d2 //d3=x3
    fmul d4,d2,d2 //d4=x4
    fmov d5,d0    //d5=x

    mov v4.2d[1],v4.2d[0]
    mov v5.2d[1],v3.2d[0]
    fmul v6.2d,v4.2d,v5.2d


    ld1		{v16.2d},[x0],#16		
    ld1		{v17.2d},[x0],#16		

    fmul v9.2d,v16.2d,v5.2d
    fmul v8.2d,v17.2d,v6.2d
    fadd v9.2d,v9.2d,v8.2d
    faddp d0,v9.2d

    ldp x29, x30, [sp], #16
    ret

// think of this as double sinpi2x(double x, double *ptr)
// the pointer is to a coefficient table
// pass x in d0
// pass the pointer to the coefficient table in x0
.global sinpi2x

sinpi2x:	
	stp x29,x30,[sp,#-16]!
									//d0 	x
	fmul 	d2,d0,d0				//d2	x^2
	fmul	d3,d0,d2				//d3 	x^3
	fmul	d4,d2,d2				//d4	x^4
	fmov	d5,d0					//d5	x^1, v5 [x^1,.]
	
	mov		v4.2d[1],v4.2d[0]		//v4	[x^4,x^4]
	mov		v5.2d[1],v3.2d[0]		//v5	[x^1,x^3]
	fmul	v6.2d,v4.2d,v5.2d		//v6	[x^5,x^7]
	fmul	v7.2d,v6.2d,v4.2d		//v7	[x^9,x^11]
	fmul	v8.2d,v7.2d,v4.2d		//v8	[x^13,x^15]	

	ld1		{v16.2d},[x0],#16		//v16	[c1,c3]
	ld1		{v17.2d},[x0],#16		//v17 	[c5,c7]
	ld1		{v18.2d},[x0],#16		//v18 	[c9,c11]
	ld1		{v19.2d},[x0],#16		//v19	[c13,c15]

	fmul 	v9.2d,v16.2d,v5.2d		//v9	[c1x,c3x^3]
	fmla	v9.2d,v17.2d,v6.2d		//v9	[c1x+c5x^5,c3x^3+c7x^7]
	fmla	v9.2d,v18.2d,v7.2d		//v9	[c1x+c5x^5+c9x^9,c3x^3+c7x^7+c11x^11]
	fmla	v9.2d,v19.2d,v8.2d		//v9	[c1x+c5x^5+c9x^9+c13x^13,c3x^3+c7x^7+c11x^11+c15x^15]
	faddp	d0,v9.2d				//d0 has sum

	ldp x29,x30,[sp],#16
	ret
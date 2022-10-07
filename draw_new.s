                .data
FRAME_WIDTH:    .word   640
FRAME_HEIGHT:   .word   480
maxIter:        .word   255
num1500:        .word   1500
num4M:			.word	3999999

                .text
                .globl drawww
drawww: @ zx:       [fp, #-36]
        @ zy:       [fp, #-40]
        @ tmp:      [fp, #-44]
        @ color:    [fp, #-48]

		stmfd	sp!, {fp, lr}
		add		fp,		sp, #4
		stmfd	sp!, {r4-r10}		@[fp, #-4] ~ [fp, #-32]
		sub		sp,		sp, #16		@ zx, zy, tmp, color

		mov     r4,     r0          @r4 = cX
		mov     r5,     r1          @r5 = cY
		mov     r6,     #640        @r6 = width
		mov     r7,     #480        @r7 = height
		mov     r8,     #0          @r8 = i = 0
		mov     r9,     #0          @r9 = x = 0
		mov     r10,    #0          @r10 = y = 0
		@========= local variable ========@

		b       for1Statement

preFor2:
		mov		r10,	#0      	@ y = r3 = 0
		b		for2Statement

for2:
		mov		r3,     r6, asr#1	@ r3 = width >> 1
		rsb		r2,     r3,	r9      @ x - (width >> 1)
		ldr		r1,     =num1500
		ldr		r1,     [r1]		@ r1 = #1500 @ xx mov r1, #1500
		mul		r0,     r2, r1      @ r0 = x - (width >> 1) * 1500
		mov		r1,     r3          @ r1 = width >> 1
		bl		__aeabi_idiv        @ r0 = r0/r1 bl
		mov		r3,     r0
		str		r3, 	[fp, #-36]	@ store r3 in zx
		mov		r3,     r7, asr#1   @ height >> 1
		sub		r2,     r10, r3     @ y - ( height >> 1 )
		mov     r1,     #1000
		mul     r0,     r2, r1      @ y - ( height >> 1 ) * 1000
		mov     r1,     r3          @ r1 = height >> 1
		bl	    __aeabi_idiv        @ r0 = r0/r1 bl
		mov     r3,     r0
		str		r3,		[fp, #-40]	@store r3 in zy
		ldr     r0,     =maxIter
		ldr     r0,     [r0]
		mov     r8,     r0          @ i = maxIter
		b		whileStatement

while:
		ldr		r2,		[fp, #-36]	@ zx
		mul		r2,		r2, r2		@ r2 = zx * zx
		ldr		r1,		[fp, #-40]	@ zy
		mul		r3,		r1, r1		@ r3 = zy * zy
		sub		r2,		r2, r3		@ r2 = ( zx * zx ) - ( zy * zy )*
		mov		r0,		r2			@ r0 = r2
		mov		r1,		#1000
		bl	    __aeabi_idiv        @ r0 = r0/r1 bl
		add		r3,		r0,	r4		@ r3 = r0 + cX = ( zx * zx )^2 - ( zy * zy )^2 / 1000 + cX
		str		r3,		[fp, #-44]	@ store r3 in tmp
		ldr		r3,		[fp, #-36]	@ zx
		mov		r3,		r3, asl#1		@ zx *2
		ldr		r2,		[fp, #-40]	@ zy
		mul		r0,		r2, r3		@ ( 2 * zx * zy )
		mov		r1,		#1000
		bl	    __aeabi_idiv        @ r0 = r0/r1 bl
		add		r3,		r0,	r5		@ r3 = r0 + cY = ( 2 * zx * zy ) / 1000 + cY
		str		r3,		[fp, #-40]	@ store r3 in zy
		ldr		r3,		[fp, #-44]	@ r3 = tmp
		str		r3,		[fp, #-36]	@ store tmp to zx
		sub		r8,		r8, #1		@ i--

whileStatement:
		ldr		r3,		[fp, #-36]
		ldr		r2,		[fp, #-36]	@ zx
		mul		r2,		r2, r3		@ r2 = zx * zx
		ldr		r3,		[fp, #-40]
		ldr		r1,		[fp, #-40]	@ zy
		mul		r3,		r1, r3		@ r3 = zy * zy
		add		r2,		r2, r3		@ r2 = ( zx * zx )^2 + ( zy * zy )^2
		ldr		r3,		=num4M		@ r3 = 3999999
		ldr     r3,     [r3]
		cmp		r2,		r3			@ r2 cmp r3
		bgt		processColor		@ if( !( r2 < 4M ) ) goto processColor >false part<

		@ op code 1
		movle	r3,		r8			@ if <= then r3 = i
		
		cmp		r3,		#0			@ i cmp 0
		bgt		while				@ if( i > 0 ) goto while >true part<
									@ else goto processColor >false part<
processColor:
		mov		r3,		r8, asl#8	@ r3 = i << 8
		mov     r2,     r8
		orr		r3, 	r2, r3
		strh	r3,		[fp, #-48]	@ store r3 in color(half word)
		ldrh	r3,		[fp, #-48]	@ store r3 in color(half word)
		mvn		r3, 	r3
		strh	r3,		[fp, #-48]	@ store r3 in color(half word)

		@ store data to 2nd array

		mov		r2,		r10			@ r2 = y
		mov		r3,		r2			@ duplicate y to r3
		mov		r3,		r3, asl#2	@ y << 2
		add		r3,		r2, r3		@ y << 2 + y
		mov		r3,		r3, asl#8	@ ( y << 2 + y ) << 8
		ldr		r2,		[fp, #4]	@ load head of array to r2 ( frame[0][0] )
		add		r2,		r2, r3		@ let r2 = frame[y][0] address
		mov		r3,		r9, asl#1	@ r3 = x * 2 Bytes
		add		r3,		r2, r3		@ r3 = frame[y][x] address
		ldrh	r2,		[fp, #-48]	@ load r2 with color(half word)
		strh	r2,		[r3]	    @ store color in frame[y][x]
		add		r10,	r10, #1		@ y++ [y = y +2 ( can be faster )]

for2Statement:
		mov		r2,		r10			@ r2 = r10 = y
		mov		r3,		r7			@ r3 = r7 = height
		cmp		r2,		r3			@ y cmp height
		blt		for2				@ if y < height goto for2

		@ op code 2
		addge	r9,		r9, #1		@ if >= then x++

for1Statement:
		mov		r2,		r9			@ r2 = r9 = x
		mov		r3,		r6			@ r4 = r6 = width
		cmp		r2,		r3			@ x cmp width
		blt		preFor2				@ if x < width goto preFor2
last:
		add     sp,     sp, #16
		ldmfd	sp!, {r4-r10}
		sub		sp,		fp, #4
		ldmfd	sp!, {fp, pc}

		@return
		
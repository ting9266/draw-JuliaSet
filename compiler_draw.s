	.arch armv6
	.eabi_attribute 27, 3
	.eabi_attribute 28, 1
	.fpu vfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"drawJuliaSet.c"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 614408
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #614400
	sub	sp, sp, #16
	ldr	r3, .L2
	str	r3, [fp, #-8]
	ldr	ip, .L2+4
	sub	r3, fp, #614400
	sub	r3, r3, #4
	sub	r3, r3, #8
	str	r3, [sp, #0]
	ldr	r0, [fp, #-8]
	ldr	r1, [fp, #-12]
	mov	r2, #640
	mov	r3, #480
	blx	ip
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L3:
	.align	2
.L2:
	.word	-700
	.word	drawJuliaSet
	.size	main, .-main
	.global	__aeabi_idiv
	.align	2
	.global	drawJuliaSet
	.type	drawJuliaSet, %function
drawJuliaSet:
	@ args = 4, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #48
	str	r0, [fp, #-40]
	str	r1, [fp, #-44]
	str	r2, [fp, #-48]
	str	r3, [fp, #-52]
	mov	r3, #255
	str	r3, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L5
.L11:
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L6
.L10:
	ldr	r3, [fp, #-48]
	mov	r3, r3, asr #1
	ldr	r2, [fp, #-20]
	rsb	r3, r3, r2
	ldr	r2, .L12
	mul	r2, r2, r3
	ldr	r3, [fp, #-48]
	mov	r3, r3, asr #1
	mov	r0, r2
	mov	r1, r3
	bl	__aeabi_idiv
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-52]
	mov	r3, r3, asr #1
	ldr	r2, [fp, #-24]
	rsb	r3, r3, r2
	mov	r2, #1000
	mul	r2, r2, r3
	ldr	r3, [fp, #-52]
	mov	r3, r3, asr #1
	mov	r0, r2
	mov	r1, r3
	bl	__aeabi_idiv
	mov	r3, r0
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-16]
	b	.L7
.L9:
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-8]
	mul	r2, r2, r3
	ldr	r3, [fp, #-12]
	ldr	r1, [fp, #-12]
	mul	r3, r1, r3
	rsb	r3, r3, r2
	ldr	r2, .L12+4
	smull	r1, r2, r2, r3
	mov	r2, r2, asr #6
	mov	r3, r3, asr #31
	rsb	r2, r3, r2
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #1
	ldr	r2, [fp, #-12]
	mul	r3, r2, r3
	ldr	r2, .L12+4
	smull	r1, r2, r2, r3
	mov	r2, r2, asr #6
	mov	r3, r3, asr #31
	rsb	r2, r3, r2
	ldr	r3, [fp, #-44]
	add	r3, r2, r3
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-16]
	sub	r3, r3, #1
	str	r3, [fp, #-16]
.L7:
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-8]
	mul	r2, r2, r3
	ldr	r3, [fp, #-12]
	ldr	r1, [fp, #-12]
	mul	r3, r1, r3
	add	r2, r2, r3
	ldr	r3, .L12+8
	cmp	r2, r3
	bgt	.L8
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bgt	.L9
.L8:
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #8
	uxth	r2, r3
	ldr	r3, [fp, #-16]
	uxth	r3, r3
	uxtb	r3, r3
	uxth	r3, r3
	orr	r3, r2, r3
	strh	r3, [fp, #-34]	@ movhi
	ldrh	r3, [fp, #-34]	@ movhi
	mvn	r3, r3
	strh	r3, [fp, #-34]	@ movhi
	ldr	r2, [fp, #-24]
	mov	r3, r2
	mov	r3, r3, asl #2
	add	r3, r3, r2
	mov	r3, r3, asl #8
	ldr	r2, [fp, #4]
	add	r2, r2, r3
	ldr	r3, [fp, #-20]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r2, [fp, #-34]	@ movhi
	strh	r2, [r3, #0]	@ movhi
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L6:
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-52]
	cmp	r2, r3
	blt	.L10
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L5:
	ldr	r2, [fp, #-20]
	ldr	r3, [fp, #-48]
	cmp	r2, r3
	blt	.L11
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L13:
	.align	2
.L12:
	.word	1500
	.word	274877907
	.word	3999999
	.size	drawJuliaSet, .-drawJuliaSet
	.ident	"GCC: (Debian 4.6.3-8+rpi1) 4.6.3"
	.section	.note.GNU-stack,"",%progbits

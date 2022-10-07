        .data
formatc:.asciz "%s"
formatd:.asciz "%d"
str:    .asciz "%d\n"
start1: .asciz "*****Input\ ID*****"
member1:.asciz "**\ Please\ Enter\ Member\ 1\ ID **"
member2:.asciz "**\ Please\ Enter\ Member\ 2\ ID **"
member3:.asciz "**\ Please\ Enter\ Member\ 3\ ID **"
command:.asciz "**\ Please\ Enter\ Command\ **\n"
sum:    .asciz "*****Print\ Team\ Member\ ID\ and\ ID\ Summation*****"
id:     .asciz "\nID\ Summation\ =\ %d\n"
endPt:   .asciz "*****End\ Print*****"
target: .word   112

AllId:  .word   0
        .word   0
        .word   0
        .word   0

Cmd:    .word   0

        .text
        .globl  ID
        .globl  AllId
        .globl  id
        .globl  endPt

ID:     stmfd   sp!, {r0-r6, lr}
        ldr 	r0, =start1     @"*****Input ID*****"
        bl 		puts
        ldr 	r0, =member1    @"** Please Enter Member 1 ID **"
        bl 		puts

        ldr 	r0, =formatd     @"%d"
        ldr 	r1, =AllId      @load address(AllId) to r1
        bl 		scanf

        ldr 	r0, =member2    @"** Please Enter Member 2 ID **"
        bl 		puts

        ldr 	r0, =formatd     @"%d"
        ldr 	r1, =AllId+4    @load address(AllId+4) to r1
        bl 		scanf

        ldr 	r0, =member3    @"** Please Enter Member 3 ID **"
        bl		puts

        ldr 	r0, =formatd     @"%d"
        ldr 	r1, =AllId+8    @load address(AllId+8) to r1
        bl		scanf


        ldr 	r0, =command
        bl  	printf

        ldr 	r0, =formatc    @load "%s" to r0
        ldr		r1, =Cmd        @load  "p" to r1
        bl  	scanf


        @Sum up students ID
        ldr 	r2, =AllId      @load address(AllId) to r2
        ldr 	r3, =AllId+4    @load address(AllId+4) to r3
        ldr 	r4, =AllId+8    @load address(AllId+8) to r4

        ldr 	r2, [r2]        @member 1 ID
        ldr 	r3, [r3]        @member 2 ID
        ldr 	r4, [r4]        @member 3 ID

        adds    r5, r2, r3      @r5 = r2+r3, then set CPSR
        addne   r5, r4          @if Z !clear, r5 +=r4

        ldr     r4, =AllId+12   @load address(AllId+12) to r4
        str     r5, [r4]        @Answer!!


        @compare if the command is 'p'
        ldr 	r1, =Cmd        @load address(Cmd) to r1
        ldr 	r1, [r1]        @load command to r1

        ldr 	r2, =target     @load address(target) to r2
        ldr 	r2, [r2]        @load address(AllId+12)
        cmp 	r1, r2          @compare r1, r2
        bne     else


        ldr 	r0, =sum        @load "*****Print Team Member ID and ID Summation*****"
        bl  	puts
        ldr 	r0, =str        @load "%d"
        ldr 	r1, =AllId
        ldr 	r1, [r1]        @load member 1 ID
        bl  	printf

        ldr 	r0, =str        @load "%d"
        ldr 	r4, =AllId+4
        ldr 	r1, [r4],#0     @load member 2 ID
        bl  	printf

        ldr 	r0, =str
        ldr 	r6, =AllId
        ldr 	r1, [r6,#8]!    @load member 3 ID
        bl 		printf



        ldreq 	r0, =id
        ldr 	r1, [r6,#4]        @load Id summation
        bl  	printf

        b   	after


else:   mov     r0, r0, LSL#31     @ return 0
        ldmfd   sp!, {r0-r6, lr}
        mov     pc, lr

after:  ldr 	r0, =endPt      @   *****End Print*****
        bl 		puts
        mov     r0, #0          @ return 0
        ldmfd   sp!, {r0-r6, lr}
        mov     pc, lr


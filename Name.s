        .data
start:  .asciz  "*****Print\ Name*****"
team:   .asciz  "Team\ 35"
name1:  .asciz  "Ting\ Lin"
name2:  .asciz  "Hank\ Peng"
name3:  .asciz  "Ian\ Feng"
end:    .asciz  "*****End\ Print*****"

        .text
        .globl  start
        .globl  Name
        .globl  team
        .globl  name1
        .globl  name2
        .globl  name3
        .globl  end
        @.type Name
@.intel_syntax noprefix


Name:   stmfd   sp!, {r0-r2, lr}
        ldr     r0, =start
        bl      puts

        ldr     r0, =team
        bl      puts

        ldr     r0, =name1
        bl      puts

        ldr     r0, =name2
        bl      puts

        ldr     r0, =name3
        bl      puts

        ldr     r0, =end
        bl      puts


        subvc     r14, r15, r13   @r14 = r15 - r13
        adds    r15, r14, r13   @r15 = r14 + r13

        mov     r0, #0
        ldmfd   sp!, {r0-r2, lr}
        mov     pc, lr

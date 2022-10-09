/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4
str_addr:
        .space 10, 0

        .align 4
format_1:
	.ascii "%d\000"

        .align 4
format_2:
        .ascii "The string is %s\n\000"

        .align 4
value_addr:
        .word 12

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function
main:
	mov ip, sp
	stmfd sp!, {fp, ip, lr, pc}
	sub fp, ip, #4

        /* use sprinf() */
	ldr r0, =str_addr 
	ldr r1, =format_1
        ldr r6, =value_addr
        ldr r2, [r6]
	bl  sprintf

	ldr r0, =format_2
        ldr r1, =str_addr
	bl printf

	ldmea fp, {fp, sp, pc}

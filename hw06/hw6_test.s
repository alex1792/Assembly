.set SWI_Write, 0x5
.set SWI_Open, 0x1
.set SWI_Close, 0x2
.set AngelSWI, 0x123456
/* ========================= */
/*       DATA section        */
/* ========================= */	
	.data
	.align 4

	/* --- variable a --- */
	.type a, %object
	.size a, 40 // a is array ,item :10 
array:
	.word 18	// 0x12
	.word 35	// 0x23
	.word 12	// 0xc
	.word 98	// 0x62
	.word 65	// 0x41	
	.word 14	// 0xe
	.word 60	// 0x3c
	.word 99	// 0x63
	.word 39	// 0x27
	.word 55	// 0x37
	.word 16	// 0x10
	.word 10	// 0xa


result_array:
	.space 48, 0  // array, 12 elements
helloStr:
	.asciz "result array value:"
inputStr:
	.asciz "input array value:"
integer:
	.asciz "%d "
new_line:
	.asciz "\n\000"
filename:
	.ascii "result.txt\000"
comma:
	.ascii ", "
str_addr:
	.space 10, 0
	
	.align 4
format_1:
	.ascii "%d\000"

	.align 4
/* ========================= */
/*       TEXT section        */
/* ========================= */

	.section .text
	.global main
	.type main,%function
.array:
	.word array
	.word result_array

.address_format:
	.word helloStr
.input_str:
	.word inputStr

.int_str:
	.word integer
.newline:
	.word new_line
.open_param:
	.word filename
	.word 0x4
	.word 0x8
.write_param:
	.space 4   /* file descriptor */
	.space 4   /* address of the string */
	.space 4   /* length of the string */
.close_param:
	.space 4

main:
	/*the part that no need to change */
	MOV ip, sp
	STMFD sp!,{fp , ip , lr ,pc}
	SUB fp , ip , #4

	
	ldr r0, =#12	/*put array size into r0*/
	ldr r1, .array	/*put array address into r1*/

	@ counter for output loop
	mov r10, r0
	mov r9, #0
	@ mov r8, #1

	bl NumSort

	/*---end of your function--- */
	
	@ r5 save the result address
	mov r5, r0

	/* open a file */
	mov r0, #SWI_Open
	adr r1, .open_param
	swi AngelSWI
	mov r6, r0                /* r2 is file descriptor */

print_loop:
	cmp r9, r10
	bge end_of_print
	ldr r1, [r5]
	ldr r0, .int_str
	bl printf

	add r9, #1
	
	@ do sprintf(str, "%d", val)
	ldr r0, =str_addr
	ldr r1, =format_1
	ldr r2, [r5], #4
	bl sprintf

	@ write in result.txt
	adr r1, .write_param
	str r6, [r1, #0]          /* store file descriptor */
	ldr r3, =str_addr
	str r3, [r1, #4]          /* store the address of string */
	mov r3, #2
	str r3, [r1, #8]          /* store the length of the string */
	mov r0, #SWI_Write
	swi AngelSWI
	
	cmp r9, r10
	blt write_comma

	b print_loop

write_comma:
	adr r1, .write_param
	str r6, [r1, #0]          /* store file descriptor */
	ldr r3, =comma
	str r3, [r1, #4]          /* store the address of string */
	mov r3, #2
	str r3, [r1, #8]          /* store the length of the string */
	mov r0, #SWI_Write
	swi AngelSWI
	
	b print_loop


end_of_print:
	@ print new line symbol
	ldr r0, .newline
	bl printf
	nop	

	/* write new line */
	adr r1, .write_param
	str r6, [r1, #0]          /* store file descriptor */
	ldr r3, =new_line
	str r3, [r1, #4]          /* store the address of string */
	mov r3, #2
	str r3, [r1, #8]          /* store the length of the string */
	mov r0, #SWI_Write
	swi AngelSWI

	/* close a file */
	adr r1, .close_param
	str r2, [r1, #0]
	mov r0, #SWI_Close
	swi AngelSWI

	nop
	LDMEA fp , {fp , sp ,pc}

	.end

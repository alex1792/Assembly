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
	.word 99	// 0x63
	.word 65	// 0x41	
	.word 14	// 0xe
	.word 60	// 0x3c
	.word 127	// 0x7f
	.word 39	// 0x27
	.word 55	// 0x37
	.word 16	// 0x10
	.word 1		// 0x1 


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
	/* calculate the address of result array */
	@ ldr r4,=#4
	@ mul r5,r0,r4
	@ add r3,r1,r5
	
	@ r3 save the result address
	mov r5, r0

	@ printf("input array:")
	ldr r0, .input_str
	bl printf

	ldr r6, .array
input_array:
	cmp r9, r10
	bge end_of_input_array
	ldr r1, [r6], #4
	ldr r0, .int_str
	bl printf
	add r9, #1
	b input_array

end_of_input_array:
	mov r9, #0
	@ print new line symbol
	ldr r0, .newline
	bl printf
	@ printf("result array:")
	ldr r0, .address_format
	bl printf
	

print_loop:
	cmp r9, r10
	bge end_of_print
	ldr r1, [r5], #4
	ldr r0, .int_str
	bl printf
	
	add r9, #1
	@ cmp r9, r10
	@ blt print_comma
	@ add r8, #1
	b print_loop
	

@ print_comma:
@ 	@ print ','
@ 	@ cmp 8, r10
@ 	ldr r0, .comma_str
@ 	b printf
@ 	b print_loop
	
	
	@ b print
	@ cmp r10, r9
	@ addle r9, #1
	@ ble print_loop
end_of_print:
	@ print new line symbol
	ldr r0, .newline
	bl printf
	nop	

	@ ldr r1, [r0]
	@ ldr r0, .address_format
	@ bl printf
	nop
	LDMEA fp , {fp , sp ,pc}

	.end

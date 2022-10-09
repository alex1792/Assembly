	.data
	.align 4

	/* --- variable a --- */
	.type a, %object
	.size a, 48 // array, 12 elements ---> 4 * 12 == 48
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

/* ========================= */
/*       TEXT section        */
/* ========================= */

	.section .text
	.global main
	.type main,%function
.array:
	.word array
	.word result_array

main:
	/*the part that no need to change */
	MOV ip, sp
	STMFD sp!,{fp , ip , lr ,pc}
	SUB fp , ip , #4

	
	ldr r9, =#12	/*array size */
	ldr r10, .array	/*array address */
	
	cmp r9, #100
	blls NumSort
	
	/* calculate the address of result array */
	ldr r4,=#4
	mul r5,r9,r4
	add r10,r10,r5
	nop
	LDMEA fp , {fp , sp ,pc}

	.end

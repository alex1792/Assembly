	.section .text
	.global NumSort
	.type NumSort,%function
NumSort:
	/* the part that no need to change */
	STMFD sp!, {r4-r9, fp, ip, lr}

	/* copy array size and address */
	mov r6,r0 /*array size*/ 
	mov r3,r1/*array address*/ 
	mov r0, r0, lsl #2
	bl malloc
	

	/* calculate size of result address */
	@ ldr r4,=#4
	@ mul r5,r0,r4
	@ add r4,r1,r0 /* result array address*/
	@ mov r7,r4
	@ mov r0, r7

	/*malloc the memory space of result array */
	@ mov r0, r5
	@ bl malloc
	@ mov r7, r0
	mov r4, r6
	mov r7, r0

/* copy array to result */
copy_loop:
	cmp r4,#0
	ble copy_loop_end
	ldr r5, [r3],#4
	str r5,[r7],#4
	sub r4,r4,#1
	b copy_loop

copy_loop_end:  
	mov r3,r6


/*bubble sort*/
mov r2,r6 /* idx(r2) = array size*/
while_idx_greater_than_1:
	cmp r2,#0 
	ble end_of_while
	sub r2,r2,#1 /*toinddex--*/
	ldr r4,=#0 /* i */

bubble_for_loop:
	cmp r4,r2 
	bge end_of_for_loop /* i >=toIndex end for*/
	ldr r1,=#4
	mul r5,r4,r1 /* r6 = r3+r4*4 */
	add r6,r0,r5 
	ldr r7,[r6],#4 /* result[i] */
	ldr r8,[r6],#4 /* result[i+1] */

	add r4,r4,#1 /* i++ */
	cmp r8 , r7 /* compare if need to swap or not */
	bge end_of_if	/* result[i + 1] > result[i]  ----> no need to swap */
	
	/*swap result[i] with result[i+1] */
	sub r6,r6,#8 /* r6 -8 ------> go back to the address of result[i] */
	str r8,[r6],#4
	str r7,[r6],#4

end_of_if:
	b bubble_for_loop

end_of_for_loop:
	b while_idx_greater_than_1

end_of_while:
	nop
	@ mov r0, r7 
	LDMFD sp!, {r4-r9, fp, ip, pc}
	.end
	
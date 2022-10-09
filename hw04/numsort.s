	.section .text
	.global NumSort
	.type NumSort,%function
NumSort:
	/* the part that no need to change */
	MOV ip, sp
	STMFD sp!, {r0-r10, fp, ip, lr, pc}
	SUB fp, ip, #4

	/* copy array size and address */
	mov r2,r9 /*array size*/ 
	mov r3,r10/*array address*/ 

	/* calculate result address */
	ldr r4,=#4
	mul r5,r9,r4
	add r6,r10,r5 /* result array address*/
	mov r7,r6

/* copy array to result */
copy_loop:
	cmp r2,#0
	ble copy_loop_end
	ldr r5, [r3],#4
	str r5,[r7],#4
	sub r2,r2,#1
	b copy_loop

copy_loop_end:  
	mov r3,r6


/*bubble sort*/
mov r2,r9 /* idx(r2) = array size*/
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
	add r6,r3,r5 
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
	LDMEA fp, {r0-r10, fp, sp, pc}
	.end
	
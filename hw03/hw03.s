/* ========================= */
/*       DATA section        */
/* ========================= */
	.data
	.align 4

/* --- variable a --- */
	.type a, %object
	.size a, 8
a:
	.word 5
	.word 5
	.word 5
	.word 5
	.word 5
	.word 5
	.word 5
	.word 5

/* --- variable b --- */
	.type b, %object
	.size b, 4
b:
	.word 1
	.word 1
	.word 1
	.word 1
	.word 1
	.word 1
	.word 1
	.word 1

c:
	.space 16, 0

/* ========================= */
/*       TEXT section        */
/* ========================= */
	.section .text
	.global main
	.type main,%function
.matrix:
	.word a
	.word b
	.word c
main:
	ldr r0, .matrix /*matrix A */
	ldr r1, [r0], #4  /* load a(1,1) to a(1,4) */	           
	ldr r2, [r0], #4
    	ldr r3, [r0], #4
    	ldr r4, [r0]

	ldr r5, .matrix + 4 /* matrix B */
	ldr r6, [r5], #8    /*load b(1,1) to b(4,1) */      
    	ldr r7, [r5], #8
    	ldr r8, [r5], #8      
    	ldr r9, [r5]
	
    	mul r10, r1, r6  /*a11 * b11 */
    	mul r6, r2, r7  /*a12 * b21 */
    	mul r7, r3, r8  /*a13 * b31 */
    	mul r8, r4, r9  /*a14 * b41 */
   	add r0, r10, r6
    	add r0, r0, r7
    	add r0, r0, r8
    
    	ldr r12, .matrix + 8    /*matrix C */    
    	str r0, [r12], #4   /*store c11 */
    

	ldr r5, .matrix + 4 /* matrix B */
	ldr r6, [r5, #4]!   /*load b(1,2) to b(4,2) */      
    	ldr r7, [r5, #8]!
    	ldr r8, [r5, #8]!     
    	ldr r9, [r5, #8]!
	
    	mul r10, r1, r6  /*a11 * b12 */
    	mul r6, r2, r7  /*a12 * b22 */
    	mul r7, r3, r8  /*a13 * b32 */
    	mul r8, r4, r9  /*a14 * b42 */
    	add r0, r10, r6
    	add r0, r0, r7
    	add r0, r0, r8
      
    	str r0, [r12], #4   /*store c12 */

    	ldr r0, .matrix /*matrix A */
	ldr r1, [r0, #16]! /* load a(2,1) to a(2,4) */	           
	ldr r2, [r0, #4]!
    	ldr r3, [r0, #4]!
    	ldr r4, [r0, #4]!

	ldr r5, .matrix + 4 /* matrix B */
	ldr r6, [r5], #8    /*load b(1,1) to b(4,1) */      
    	ldr r7, [r5], #8
    	ldr r8, [r5], #8      
    	ldr r9, [r5]
	
    	mul r10, r1, r6  /*a21 * b11 */
    	mul r6, r2, r7  /*a22 * b21 */
    	mul r7, r3, r8  /*a23 * b31 */
    	mul r8, r4, r9  /*a24 * b41 */
    	add r0, r10, r6
    	add r0, r0, r7
    	add r0, r0, r8
      
    	str r0, [r12], #4   /*store c21 */


	ldr r5, .matrix + 4 /* matrix B */
	ldr r6, [r5, #4]!   /*load b(1,2) to b(4,2) */      
    	ldr r7, [r5, #8]!
    	ldr r8, [r5, #8]!      
    	ldr r9, [r5, #8]!
	
    	mul r10, r1, r6  /*a21 * b12 */
    	mul r6, r2, r7  /*a22 * b22 */
    	mul r7, r3, r8  /*a23 * b32 */
    	mul r8, r4, r9  /*a24 * b42 */
    	add r0, r10, r6
    	add r0, r0, r7
    	add r0, r0, r8
       
    	str r0, [r12]   /*store c22 */

        nop

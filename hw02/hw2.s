    	.section .text
    	.global main
    	.type main, %function

main:
	mov r1, #10	/*set value of r1*/
	mov r2, #20	/*set value of r2*/
	mov r3, #12	/*set value of r3*/

	mov r0, $0	/*set r0 = 0*/
	mov r4, #2	/*r4 = 2*/
	MUL r0, r1, r4	/*r0 = 2 * r1*/
	
	mov r4, #4	/*r4 = 4*/
	MUL r1, r2, r4	/*r1 = 4 * r2*/
	
	mov r4, #8	/*r4 = 8*/
	MUL r2, r3, r4	/*r2 = 8 * r3*/
	
	add r0, r0, r1	/*r0 += r1*/
	add r0, r0, r2	/*r0 += r2*/
	nop
    	.end
    

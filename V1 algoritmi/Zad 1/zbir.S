.section .data
.section .text
.global main

main:
	movl $0, %eax
	movl $10, %ecx

uporedi:

	cmpl $0, %ecx
	je kraj
	addl %ecx, %eax
	subl $1, %ecx
	jmp uporedi

kraj:
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80

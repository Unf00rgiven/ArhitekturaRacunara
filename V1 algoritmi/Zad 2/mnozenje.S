.section .data
.section .text
.global main

main:

	movl $5, %eax
	movl $3, %ebx
	movl $0, %ecx
	cmpl %eax, %ebx
	ja sabiranje
	xchgl %eax, %ebx

sabiranje:
	
	cmpl $0, %eax
	je kraj
	addl %ebx, %ecx
	subl $1, %eax
	jmp sabiranje

kraj:

	movl $1, %eax
	movl $0, %ebx
	int $0x80

	

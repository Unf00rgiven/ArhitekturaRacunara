.section .data
.section .text
.global main

main:
	movl $1, %eax
	movl $1, %ebx 
	movl $15, %esi
	movl $2, %ecx #brojac
	movl $0, %edx #prosli clan
	
racunaj:
	cmpl %ecx, %esi
	je kraj
	movl %eax, %edx	
	addl %ebx, %edx
	movl %ebx, %eax
	movl %edx, %ebx
	addl $1, %ecx
	jmp racunaj

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80

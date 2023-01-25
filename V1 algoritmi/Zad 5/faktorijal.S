.section .data
.section .text
.global main

main:
	movl $5, %esi
	movl $0, %edx
	movl $1, %eax 	

pocetak:
	cmpl $1, %esi
	jbe kraj
	subl $1, %esi
	movl %eax,%ebx
	addl $1, %ebx
	movl %eax, %ecx
	jmp mnozenje

mnozenje:
	cmpl $0, %ecx
	je pocetak
	addl %ebx, %edx
	subl $1, %ecx
	addl $1, %eax
	jmp mnozenje

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80

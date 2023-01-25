#autor: Ognjen Stojisavljevic ra155-2019

.section .data

prompt_1: .ascii "Unesite string: \0"
duzina_prompt1=.-prompt_1

prompt_2: .ascii "Enkodovan string: \0"
duzina_prompt2=.-prompt_2

maxduzina=51

string: .fill maxduzina,1,0

.section .text
.globl main
main:

	# UNESITE STRING
	movl $4, %eax
	movl $1, %ebx
	movl $prompt_1, %ecx
	movl $duzina_prompt1, %edx
	int $0x80

	# UPISIVANJE STRINGA
	movl $3, %eax
	movl $0, %ebx
	movl $string, %ecx
	movl $maxduzina, %edx
	int $0x80

	movl $string, %eax #adresa unetog stringa
	
	cmpb $0, (%eax) #da li je prvi znak NULL tj. da li je string prazan
	je kraj
	
petlja:
	cmpb $0, (%eax) #da li je kraj stringa
	je ispis
	cmpb $'A', (%eax) 
	jb dalje
	cmpb $'Z', (%eax)
	ja mala
	jmp kodiraj

dalje:
	addl $1, %eax	#nije karakter,provera sledeceg
	jmp petlja

kodiraj:
	cmpb $'D', (%eax) 
	jb kodiraj2
	subl $3, (%eax)
	jmp dalje
kodiraj2:
	#A,B,C	
	addl $23, (%eax)
	jmp dalje

mala:
	cmpb $'a', (%eax) 
	jb dalje
	cmpb $'z', (%eax)
	ja dalje
	jmp kodirajm

kodirajm:
	cmpb $'d', (%eax) 
	jb kodiraj2m
	subl $3, (%eax)
	jmp dalje
kodiraj2m:
	#a,b,c
	addl $23, (%eax)
	jmp dalje

ispis:	#ENKODOVAN STRING:
	movl $4, %eax
	movl $1, %ebx
	movl $prompt_2, %ecx
	movl $duzina_prompt2, %edx
	int $0x80
	
	#ispis kodiranog stringa
	movl $4, %eax
	movl $1, %ebx
	movl $string, %ecx
	movl $maxduzina, %edx
	int $0x80

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80

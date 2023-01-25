#autor: Ognjen Stojisavljevic ra155-2019

.section .data

prompt1: .ascii "Unesite logicki izraz: \0"
duzina_prompt1=.-prompt1

prompt2: .ascii "Rezultat: \0"
duzina_prompt2=.-prompt2

err1: .ascii "Greska kod operanda.\n\0"
duzina_err1=.-err1

err2: .ascii "Greska kod operacije.\n\0"
duzina_err2=.-err2

newline: .ascii "\n\0"
duzina_newline=.-newline

maxstring=101 
string: .fill maxstring,1,0

prvioperand: .byte 0
drugioperand: .byte 0
operacija: .byte 0

.section .text
.globl main
main:
	#UNESITE IZRAZ
	movl $4, %eax
	movl $1, %ebx
	movl $prompt1, %ecx
	movl $duzina_prompt1, %edx
	int $0x80
	
	#unosenje izraza
	movl $3, %eax
	movl $0, %ebx
	movl $string, %ecx
	movl $maxstring, %edx
	int $0x80

	movl $string, %esi	#adresa unetog stringa

	
petlja:
	cmpb $0, (%esi)		#kraj stringa ?
	je kraj
provera:	
	cmpb $'0',(%esi)	#provera da li je 0?
	je x
	cmpb $'0',(%esi)
	jb dalje
	cmpb $'9',(%esi)
	ja dalje
	jmp dekadni
dalje:
	cmpb $' ',(%esi)	#razmak
	je razmak	
	cmpb $'<',(%esi)	#provera operacija
	je rotl
	cmpb $'>',(%esi)
	je rotd
	cmpb $'^',(%esi)
	je exor
rotl:
	movl $1, operacija
	addl $2, %esi		#preskoci razmak idi na sledeci operand
	jmp petlja
rotd:
	movl $2, operacija
	addl $2, %esi
	jmp petlja
exor:
	movl $3, operacija
	addl $2, %esi
	jmp petlja

razmak:
	incl %esi
	jmp petlja

dekadni:	
	xorl %eax, %eax 	#r=0
	xorl %ebx, %ebx
	movl $10, %ecx
cifraD:
	movb (%esi), %bl
	cmpb $' ', %bl
	jz razmak
	subb $'0', %bl		#cifra
	mull %ecx		#rez*=10
	addl %ebx, %eax		#r=r+cifra
	movl %eax, drugioperand
	incl %esi
	jmp cifraD
	
x:				#naredni znak X
	incl %esi
	cmpb $'x',(%esi)
	je hexa
	cmpb $'X',(%esi)
	je hexa
	jmp greska1
hexa:				#pretvaranje iz znakovnog u interni
	incl %eax
	xorl %eax, %eax		# rezultat na 0
	xorl %ebx, %ebx
	movl $16, %ecx		#osnova
cifraX:
	movb (%esi), %bl
	cmpb $' ', %bl
	jz razmak
	subb $'0', %bl		#cifra
	mull %ecx		#rez*=16
	addl %ebx, %eax
	movl %eax, drugioperand
	incl %esi		#sledeci znak
	jmp cifraX

#######################################################

ispis:	
	#REZULTAT
	movl $4, %eax
	movl $1, %ebx
	movl $prompt2, %ecx
	movl $duzina_prompt2, %edx
	int $0x80
	movl $0,%ebx
	jmp kraj

greska1:
	#GRESKA 1
	movl $4, %eax
	movl $1, %ebx
	movl $err1, %ecx
	movl $duzina_err1, %edx
	int $0x80
	movl $1,%ebx
	jmp kraj
	
greska2:	
	#GRESKA 2
	movl $4, %eax
	movl $1, %ebx
	movl $err2, %ecx
	movl $duzina_err2, %edx
	int $0x80
	movl $1,%ebx
	jmp kraj

kraj:	
	movl $1, %eax
	int $0x80

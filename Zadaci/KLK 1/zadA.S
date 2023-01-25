#Ognjen Stojisavljevic RA155/2019

.section .data

poruka1: .ascii "Unesite prvi string: \0"
poruka1len= .-poruka1

poruka2: .ascii "Unesite drugi string: \0"
poruka2len= .-poruka2

ispis1: .ascii "Prvi string ima vise malih slova nego drugi.\n\0"
ispis1len= .-ispis1

ispis2: .ascii "Drugi string ima vise malih slova od prvog.\n\0"
ispis2len= .-ispis2

ispis3: .ascii "Oba stringa imaju isti broj malih slova.\n\0"
ispis3len= .-ispis3

maxstring=41

string1: .fill maxstring,1,0	#stringovi koje korisnik unosi
string2: .fill maxstring,1,0

brojacs1: .long 0	#brojaci malih slova
brojacs2: .long 0


.section .text
.global main
main:
	#ispis poruka1
	movl $4, %eax		
	movl $1, %ebx 
	movl $poruka1, %ecx
	movl $poruka1len, %edx
	int $0x80

	#korisnik unosi prvi string	
	movl $3, %eax	
	movl $0, %ebx	
	movl $string1, %ecx 
	movl $maxstring, %edx
	int $0x80

	#Racunanje koliko malih slova ima u prvom stringu koji korisnik unosi
	movl $string1, %eax
	
petlja1:
	
	cmpl $0,(%eax)
	je unos2
	cmpb $'a', (%eax)
	jb nema1
	cmpb $'z', (%eax)
	ja nema1
	addl $1, brojacs1

nema1:
	incl %eax
	cmpb $10, (%eax)
	jne petlja1
		
	
unos2:

	#ispis poruka2
	movl $4, %eax
	movl $1, %ebx
	movl $poruka2, %ecx
	movl $poruka2len, %edx
	int $0x80
	
	#korisnik unosi drugi string
	movl $3, %eax
	movl $0, %ebx
	movl $string2, %ecx
	movl $maxstring, %edx
	int $0x80
	
	#Racunanje koliko malih slova ima u drugom stringu koji korisnik unosi
	movl $string2, %eax
	
petlja2:
	
	cmpl $0,(%eax)
	je poredi
	cmpb $'a', (%eax)
	jb nema2
	cmpb $'z', (%eax)
	ja nema2
	addl $1, brojacs2

nema2:
	addl $1, %eax
	cmpb $10,(%eax)
	jne petlja2
	
poredi:
	#Poredjenje brojaca
	movl brojacs1, %esi
	movl brojacs2, %edi
	
	cmpl %esi,%edi
	jb slucaj1
	je slucaj3
	ja slucaj2

slucaj1: #ispis 1
	movl $4, %eax
	movl $1, %ebx
	movl $ispis1, %ecx
	movl $ispis1len, %edx
	int $0x80

	subl %edi, %esi
	movl %esi, %ebx
	jmp kraj
		
slucaj2: #ispis 2
	movl $4, %eax
	movl $1, %ebx
	movl $ispis2, %ecx
	movl $ispis2len, %edx
	int $0x80

	subl %esi, %edi
	movl %edi, %ebx
	jmp kraj				

slucaj3: #ispis 3
	movl $4, %eax
	movl $1, %ebx
	movl $ispis3, %ecx
	movl $ispis3len, %edx
	int $0x80
	
	movl $0, %ebx
	jmp kraj

kraj:
	movl $1, %eax
	int $0x80

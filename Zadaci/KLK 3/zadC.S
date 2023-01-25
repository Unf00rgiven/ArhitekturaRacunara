#autor: Ognjen Stojisavljevic RA 155/2019

.section .data

string1:	.ascii "Unesite tekst:\t\0"
string1len=.-string1 	#duzina stringa koji cemo ispisati na ekran

string2:	.ascii "Resenje je: \0"
string2len=.-string2

string3:	.ascii "Greska: Prekoracenje\n\0"		#napravili smo promenljive koje cemo
string3len=.-string3						#koristiti u daljem ispisivanju stringova	
								#u zavisnosti od toka programa
string4:	.ascii "Greska: Pogresan operand\n\0"
string4len=.-string4

string5:	.ascii "Greska: Ima vise od 2 heks broja\n\0"
string5len=.-string5

string6:	.ascii "Greska: Drugi broj veci od prvog\n\0"
string6len=.-string6

max=51					#korisnik unosi string max 50 karaktera(51 null terminator)
stringkorisnik: .fill max,1,0

brznakova: .long 0	#ovde cemo cuvati koliko znakova je uneseno
znak: .long 0 		#ukoliko je operacija - postavicemo na 1,ako je plus ostace 0

.section .text
.globl main
main:
	#ispisacemo poruku korisniku da unese string (string1)	
	movl $4, %eax
	movl $1, %ebx
	movl $string1, %ecx
	movl $string1len, %edx
	int $0x80

	#upis stringa koji korisnik unosi
	movl $3, %eax
	movl $0, %ebx
	movl $stringkorisnik, %ecx			
	movl $max, %edx 			
	int $0x80
	
	movl %eax, brznakova	
	#############provera unesenog stringa#############

        movl $stringkorisnik, %esi		#adresa unetog stringa->esi

prviznak:
	cmpb $'-', (%esi) 	#da li je minus prvi znak
	je hexbroj
	cmpb $'+', (%esi)	#da li je  plus prvi znak
	je minus
	jmp pogresan1znak

minus:
	movl $1, znak
hexbroj:
	movl $8, %edi	#brojac koji pokazuje koliko je maksimalno ostalo do kraja hex broja(8jer je hex broj 4bita,4*8=32max)
dalje:			
	cmpl $0, %edi
	je hexbroj
	cmpb $'0', (%esi) #ako je tacno kraj stringa
	je krajstringa

	
	
krajstringa:
	

		
pogresan1znak:	#treba da ispisemo gresku
	movl $4, %eax
	movl $1, %ebx
	movl $string4, %ecx
	movl $string4len, %edx
	int $0x80
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80
	

kraj:
	movl $1, %eax
	movl $0, %ebx
	int $0x80

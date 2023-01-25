#autor: Ognjen Stojisavljevic ra155-2019
#int encode(char* izvorni, char* ciljni, char* enkodovati);

.section .text

.globl encode
encode:
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx
	pushl %esi
	pushl %edi
	
	movl 16(%ebp), %ebx	#adresa unetog stringa
	xorl %eax, %eax		#postavljamo brojac izmenjenih slova na 0, odnosno povratnu vrednost

unetiString:
	movl 8(%ebp), %esi	#adresa izvornog ide u esi
	movl 12(%ebp), %edi 	#adresa ciljnog ide u edi
	
	cmpb $0, (%ebx)	 	#da li je kraj stringa
	je kraj			#proveriti prvo da li je prvo string bio prazan
	movb (%ebx), %cl	#proveramo prvi znak stringa sa izvnornim
	jmp proveri

proveri:
	cmpb %cl, (%esi)
	jne sledeciIzvorni
	movb (%edi), %cl	#upisi kodirano slovo
	movb %cl, (%ebx)
	incl %ebx		#povecaj adresu na sledece slovo
	incl %eax		#povecaj brojac promenjenih slova
	jmp unetiString

sledeciIzvorni:
	cmpb $0, (%esi) 	#proveravamo da li je kraj izvornog string
	je sledeciKarakter
	incl %esi
	incl %edi
	jmp proveri
	
sledeciKarakter:
	incl %ebx
	jmp unetiString
kraj:	
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp,%esp
	popl %ebp
	ret

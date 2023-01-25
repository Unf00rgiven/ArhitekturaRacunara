#autor: Ognjen Stojisaljevic RA 155/2019

#int kodiraj(unsigned int vrednost);

.section .text
.globl kodiraj 

kodiraj:
	pushl %ebp		#pocetak potprograma
	movl %esp, %ebp		
	movl 8(%ebp), %eax	#32bitni broj sa kojim treba da operisemo postavljamo u eax
	pushl %ebx
	pushl %esi
	pushl %edi								
	movl $2, %edx		#maska sa kojim cemo raditi logicke operacije i proveravati 0 ili 1,krecemo od drugog bita

	movl $31, %ebx #brojac
	
	#prvo cemo da proverimo vrednost prvog bita
	testl $0b00000000000000000000000000000001, %eax
	jz prvibit0		#prvi bit 0
	jnz prvibit1

prvibit0: ##################prvi bit 0	
	cmpl $0, %ebx
	je kodiran
	testl %edx,%eax 		
	jnz bit1		#pronasli smo 1
	#shll %edx
	roll %edx	
	decl %ebx
	jmp prvibit0		#opet 0 u eax

bit1:
	movl %edx, %ecx  	#ecx prosla vrednost edx
	#shll %edx
	roll %edx
	testl %edx, %eax	#proveravamo da li je naredna vrednost 1 isto
	jnz opet1
	xorl %ecx, %eax
	decl %ebx
	jmp prvibit0

opet1:
	#shll %edx		#radi sve dok ne nadjes 0
	roll %edx
	decl %ebx	
	testl %edx,%eax	
	jnz opet1
	jmp prvibit0
		
	  ##################prvi bit 1
prvibit1:
	testl $0b10000000000000000000000000000000, %eax #poslednji bit 1?
	jnz daljeB					#ako ne menjamo 1 na pocetku
	testl $0b00000000000000000000000000000010, %eax #da li je 0...01?
	jnz daljeB					#ako ne menjamo 1 na pocetku
	xorl $0b00000000000000000000000000000001, %eax #postavljamo prvi bit na 0
	jmp prvibit0

daljeB:
	testl %edx, %eax #naredni 1 ili 0?
	jz nula
	#shll %edx	#kad pronadjes prvu 0 idi na labelu nula
	roll %edx
	decl %ebx
	jmp daljeB
nula:
	#shll %edx
	roll %edx
	decl %ebx
nastavak:
	cmpl $0, %ebx
	je kodiran	
	testl %edx,%eax 		
	jnz bit1B		#pronasli smo 1
	#shll %edx
	roll %edx	
	decl %ebx
	jmp nastavak		#opet 0 u eax

bit1B:
	movl %edx, %ecx  	#ecx prosla vrednost edx
	#shll %edx
	roll %edx
	testl %edx, %eax	#proveravamo da li je naredna vrednost 1 isto
	jnz opet1
	xorl %ecx, %eax
	decl %ebx
	jmp prvibit0

opet1B:
	#shll %edx		#radi sve dok ne nadjes 0
	roll %edx
	decl %ebx	
	testl %edx,%eax	
	jnz opet1B
	jmp nastavak
	

################# 2 deo zadatka ######################################

kodiran:
	xorl %esi, %esi		#postavljamo brojac jedinica za visi deo na 0		
	xorl %edi, %edi		#brojac nizih na 0
	movl $0b00000000000000010000000000000000, %edx #komparator za visi deo
	movl $0b00000000000000000000000000000001, %ecx #komparator za nizi deo
	movl $0b00000000000000010000000000000000, %ebx

visibitovi:
	cmpl $0, %edx	#racunanje broja jedinica visih bitova eax
	je nizibitovi	
	testl %edx, %eax
	jnz ima1
	shll %edx
	jmp visibitovi
ima1:
	incl %esi
	shll %edx
	jmp visibitovi

nizibitovi:		
	cmpl %ebx, %ecx	#racunanje broja jedinica nizih bitova eax
	je esiedi
	testl %ecx, %eax
	jnz ima1B
	shll %ecx
	jmp nizibitovi
ima1B:
	incl %edi
	shll %ecx
	jmp nizibitovi	

esiedi:			#koji deo ima vise jedinica
	cmpl %edi, %esi
	jae kraj
	rorl $16, %eax	
	

kraj: 
	popl %edi
	popl %esi
	popl %ebx
	movl %ebp, %esp	
	popl %ebp
	ret

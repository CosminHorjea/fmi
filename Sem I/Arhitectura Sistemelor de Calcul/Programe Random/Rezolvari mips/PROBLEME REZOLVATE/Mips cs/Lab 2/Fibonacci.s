.data
	x:.space 4
	y:.space 4
	message:.asciiz "Cititi numarul de ordine al termenului ce doriti a fi afisat :\n"
	display:.asciiz "Termenul de pe pozitia ceruta este :\n"
	error:.asciiz "Numarul de ordine nu este valid !"
.text
main:
	li $v0,4			 	#afisare mesaj in consola
	la $a0, message
	syscall
	
	li $v0, 5			 	#citire numar de ordine
	syscall
	
	blez $v0, eroare		#numarul citit nu este valid

	move $t0, $v0		 	#$t0 va contine numarul de ordine al termenului
	
	li $t1, 1 			 	#$t1 va fi contor
	li $t2, 0			 	#$t2 va contine valoarea primilor 2 termeni
	sw $t2, x 			 	#primii 2 termen ai sirului
	sw $t1, y


	loop :
		beq $t1, $t0, afisare	#cat timp nu am ajuns la pozitie
			lw $t2, x
			lw $t3, y
			add $t2, $t2, $t3   # x + y
			sw $t3, x 	   		# x = y
			sw $t2, y	   		# y = x + y
			addiu $t1, $t1, 1   # maresc contorul
			b loop	
		 
afisare:

	li $v0, 4
	la $a0, display
	syscall

	li $v0, 1
	lw $a0, y
	syscall

	j sfarsit	

sfarsit :
	li $v0, 10
	syscall

eroare :
	li $v0, 4
	la $a0, error
	syscall
	


.data
	alfabet: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	p : .word 4
	powers: .space 400
	mesajPrim: .asciiz "Numarul nu este prim"
	mesajPrimOk: .asciiz "Numarul este prim"
	spatiu: .asciiz " "
	linie: .asciiz "-"
.text
main:
	li $v0,5
	syscall
	sw $v0,p
	li $t0,2 #de la 2
	lw $t1,p #la p
	prim:
		bge $t0,$t1,ePrim
		rem $t3,$t1,$t0
		beqz $t3,exitPrim
		addi $t0,$t0,1
		j prim
			
exitPrim:
	la $a0,mesajPrim
	li $v0,4
	syscall
	j exit
ePrim:
	lw $t0,p # (7) p e in t0
	subu $t1,$t0,1 # (6) g e in $t1
	li $t2,1 #t2 e g care initial e 2 dar adaug 1 in loop
	genPuteri: #imi genereaza puterile pana la p-1, dar schimba mereu vectorul, trebuie sa fac conditia de generator
		# o modalitate ar putea sa fie ca daca un element e 1 inainte de pozitia g sau cv gen
		addi $t2,$t2,1
		bgt $t2,$t1,afisez
		li $t3,0 # incep de la puterea 0
		move $t4,$t2 # fac o copie la $t2
		genPuteri2:
			bge $t3,$t1,genPuteri
			mul $t4,$t4,$t2
			rem $t5,$t4,$t0 #fac restul la rez cu p($t0)
			mul $t6,$t3,4 # calculez pozitia in vector
			sw $t5,powers($t6)
			addi $t3,$t3,1
			j genPuteri2
	

	
afisez:
	li $t0,0
	afisez2:
		bge $t0,$t1,exit
		mul $t2,$t0,4
		move $a0,$t0
		li $v0,1
		syscall
		la $a0, linie
		li $v0,4
		syscall
		lw $a0,powers($t2)
		li $v0,1
		syscall
		addi $t0,$t0,1
		la $a0, spatiu
		li $v0,4
		syscall
		j afisez2
		
exit:
	
	li $v0,10
	syscall
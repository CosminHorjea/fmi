.data
	alfabet: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	p : .word 4
	powers: .space 400
	mesajPrim: .asciiz "Numarul nu este prim"
	mesajPrimOk: .asciiz "Numarul este prim"
	spatiu: .asciiz " "
	linie: .asciiz "-"
	mesaj1: .space 400
	mesaj2: .space 400
.text
main:
	li $v0,5
	syscall
	sw $v0,p
	li $t0,2 #de la 2
	lw $t1,p #la p
	prim: #TODO: eficient (i*i)
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
	li $t2,1 #t2 e g care initial e 2 , adaug 1 in loop
	li $t3,1 # incep de la puterea 0
	li $t6,0
	li $t5,1
	li $t7,1
	genPuteri: 
		addi $t2,$t2,1
		bgt $t2,$t1,exit
		sw $t5,powers($t6) #prima pozitie e 1
		move $t4,$t2 # fac o copie la $t2 (care e incercare pt generator)
		genPuteri2:
			bge $t3,$t1,amGasitGenerator #inseamna ca am gasit un vector (de la 0 la g)
			rem $t5,$t4,$t0 #fac restul la rez cu p($t0) $t5 e restul de pus in vector (asta daca e 1 e gata)
			beq $t5,$t7, nuEGenerator
			mul $t6,$t3,4 # calculez pozitia in vector $t6 e pozitia
			sw $t5,powers($t6)
			mul $t4,$t4,$t2
			rem $t4,$t4,$t0
			
			addi $t3,$t3,1
			j genPuteri2
nuEGenerator:
	li $t3,1 # incep de la puterea 0
	li $t5,1
	li $t6,0
	j genPuteri

	
amGasitGenerator:
	#in mom asta am in $t2 generatorul
	# si in "powers" puterile
	move $a0,$t2
	li $v0,1
	syscall
	#li $t0,0 ASTA E PT AFISAT VECTOR, NU O LASA IN VAR FINALA
	#afisez2:
	#	bge $t0,$t1,genPuteri
	#	mul $t2,$t0,4
	#	move $a0,$t0
	#	li $v0,1
	#	syscall
	#	la $a0, linie
	#	li $v0,4
	#	syscall
	#	lw $a0,powers($t2)
	#	li $v0,1
	#	syscall
	#	addi $t0,$t0,1
	#	la $a0, spatiu
	#	li $v0,4
	#	syscall
	#	j afisez2
	la $a0,mesaj1
	li $a1,99
	li $v0,8
	syscall
	la $a0,mesaj2
	li $a1,99
	li $v0,8
	syscall
exit:
	li $v0,10
	syscall
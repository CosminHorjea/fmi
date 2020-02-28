.data
	alfabet: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	p : .word 4
	g : .word 4
	powers: .space 400
	mesajPrim: .asciiz "Numarul nu este prim"
	mesajPrimOk: .asciiz "Numarul este prim"
	spatiu: .asciiz " "
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
	li $t7,4
	li $t6,0
	subu $t1,$t1,1
	sw $t1,g
	addi $t1,$t1,1
	lw $t0,g
	li $t2,1 # t2 puterea la care il ridic pe g
	li $t3,1
	sw $t3,powers($t6)
	puteri:
		bge $t2,$t0,afisezPuteri
		mul $t3,$t3,$t0
		rem $t4,$t3,$t1
		mul $t5,$t2,$t7
		sw $t4,powers($t5)
		addi $t2,$t2,1
		j puteri
afisezPuteri:
	li $t2,0
	bge $t2,$t0,exit
		mul $t4,$t2,4
		lw $a0,powers($t4)
		li $v0,1
		syscall
		addi $t2,$t2,1

	
exit:
	li $v0,10
	syscall
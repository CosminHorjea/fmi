.data
	alfabet : .asciiz "ABCDEFGHIJKLMONPQRSTUVWXYZ"
	p: .word 4
	g: .word 4
	frecv: .space 400
.text
main:
	li $v0,5
	syscall#citesc pe p
	sw $v0,p
	li $t0,2 #de la 2
	li $t2,0
	lw $t1,p
	sub $t1,$t1,1 #la p-1
puteri:
	bge $t0,$t1,exit
	move $t3,$t0
	li $t4,2
	rez:
		bge $t4,$t1,afisez
		mul $t3,$t3,$t0   #trebuie nr din t3 sa fie la puterea t4, deci inca un loop
		addi $t4,$t4,1
		j rez           #la final am puterea in $t3
	
afisez:
	addi $t1,$t1,1
	rem $a0,$t3,$t1
	addi $t0,$t0,1
	li $v0,1
	syscall
	sub $t1,$t1,1
	j puteri
exit:
	li $v0,10
	syscall
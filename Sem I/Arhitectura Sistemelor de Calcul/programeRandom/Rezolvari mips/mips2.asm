.data 
	v: .space 400
	n: .space 4
	max : .space 4
	pozMax: .space 4
.text
	main:
	li $v0,5
	syscall
	move $t0,$v0
	sw $t0,n
	lw $t0,n
	li $t1,0
	li $t2,0
	li $t7,0
	loop:
		bge $t1,$t0,exit1
		li $v0,5
		syscall
		sw $v0,v($t2)
		addi $t1,$t1,1
		addi $t2,$t2,4
		
		j loop
	exit1:
		li $t1,0
		li $t2,0
		lw $t0,n
		j loop2
	loop2:
		bge $t1,$t0,afis
		lw $t4,v($t2)
		bgt $t4,$t7,atrib
		addi $t1,$t1,1
		addi $t2,$t2,4
		
	atrib:
		move $t7,$t4
		sw $t7, max
		sw $t1, pozMax
		j cont
	cont:
		addi $t1,$t1,1
		addi $t2,$t2,4
		j loop2
	afis:
		li $v0,1
		lw $a0,max
		syscall
		li $v0,1
		li $v0,1
		lw $a0,pozMax
		syscall
		j exit
	exit:
	li $v0,10
	syscall
	
	
	
	

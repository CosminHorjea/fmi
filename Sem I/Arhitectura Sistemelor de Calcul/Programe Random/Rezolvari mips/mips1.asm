.data 
	v: .space 400
	n: .space 4
.text
	main:
	li $v0,5
	syscall
	move $t0,$v0
	sw $t0,n
	lw $t0,n
	li $t1,0
	li $t2,0
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
		li $t3,2
		lw $t0,n
		j loop2
	loop2:
		bge $t1,$t0,exit
		lw $t4,v($t2)
		rem $t5,$t4,$t3
		
		beq $t5,0,afis
	cont:
		addi $t1,$t1,1
		addi $t2,$t2,4
		j loop2
	afis:
		li $v0,1
		lw $t4,v($t2)
		move $a0,$t4
		syscall
		j cont
	exit:
	li $v0,10
	syscall
	
	
	
	

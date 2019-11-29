.data 
	str: .space 100
.text
main:
	la $a0,str
	li $a1,99
	li $v0,8
	syscall
	la $a0,str
	li $t0,0 
	lb $t1,str($t0)
	loop:
		beq $t1,0,exit
		addi $t0,$t0,1
		lb $t1,str($t0)
		rem $t2,$t0,2
		beq $t2,0,afis
	afis:
		move $a0,$t1
		li $v0,11
		syscall
		j loop
	exit:
		li $v0,10
		syscall
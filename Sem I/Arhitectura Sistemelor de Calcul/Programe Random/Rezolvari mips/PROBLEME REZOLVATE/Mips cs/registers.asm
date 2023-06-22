.data
	newline: .asciiz "\n"

.text
	main: 
		li $s0, 4
		
		li $v0, 1 
		move $a0, $s0
		syscall
		
		jal increaseMyRegister
		
		li $v0, 1 
		move $a0, $s0
		syscall
		
	
	li $v0, 10
	syscall 
	
	increaseMyRegister:
		addi $sp, $sp, -8
		
		sw $s0, 0($sp)
		sw $ra, 4($sp)
		
		addi $s0, $s0, 10
		
		jal printValue
		
		lw $s0, 0($sp)
		lw $ra 4($sp)
		addi $sp, $sp, 8
		
		
		jr $ra
		
	printValue: 
		move $a0, $s0
		li $v0, 1
		syscall 
		
		li $v0, 4
		la $a0, newline
		syscall
		
		jr $ra
		
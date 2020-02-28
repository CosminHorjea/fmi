.data

.text
	main:
		li $t1, 1
		li $t2, 2
		
		add $a1, $t1, $zero
		add $a2, $t2, $zero
		
		jal addTwoNumbers
		
		move $a0, $t3
		li $a1, 23
		li $v0, 1
		
		syscall
		
		
	
	li $v0, 10
	syscall
	
	addTwoNumbers: 
		add $t3, $t1, $t2
		
		jr $ra
		
.data
	userInput: .space 20
	
.text

	main:
		li $v0, 8
		la $a0, userInput
		li $a1, 20
		
		syscall
		
		li $v0, 4
		syscall 
		
	
	li $v0, 10 
	syscall 
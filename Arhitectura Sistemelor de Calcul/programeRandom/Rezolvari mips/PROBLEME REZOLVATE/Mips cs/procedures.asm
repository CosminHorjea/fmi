.data
	message: .asciiz "Hello world!"
.text
	main:
		jal myMessage
		li $v0, 10
		syscall
	myMessage:
		li $v0, 4
		la $a0, message
		
		syscall 
		
		jr $ra
		
	
	
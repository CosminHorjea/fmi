.data
	sir1: .asciiz "abcd"
	sir2: .asciiz "efgh"
	

.text
	main:
	 
       
       
		la $a0, sir1
		la $a1, sir2
	    jal lungime
	     
		 la $a0, sir1
		 li $v0, 4
		 syscall
	
	li $v0, 10
	syscall
	
	lungime:
	
	lb $t0, 0($a0)
	beq $t0, $zero concatenare
	addi $a0, $a0, 1
	j lungime
	
	concatenare:
	
	lb $t1, 0($a1)
	beq $t1, $zero sari
	addi $a1, $a1, 1
	sb $t1, 0($a0)
	
	addi $a0, $a0, 1
	j concatenare 
	
	sari:
	sb $t1, 0($a0)
	jr $ra
	
	
	
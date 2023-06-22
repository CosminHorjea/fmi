.data 
	v: .word 4, 2, 1, 2, 2, 1, 0, 3, 0
	n: .word 9
	result: .space 28
.text
	main: 
		li $t0, 0 # i = 0
		li $t1, 0 #j = 0
		li $t2, 0 # new_elements_bytes = 0
		li $t7, 0
		lw $t3, n
		mul $t3, $t3, 4 
		
		jal v_iteration
		
		li $t0, 0
		continue_main:
			beq $t7, $t2, exit_program
			
			li $v0, 1
			lw $t4, result($t7)
			move $a0, $t4
			syscall
			
			addi $t7, $t7, 4
			j continue_main
	
	
	li $v0, 10
	syscall
	
	v_iteration:
		beq $t0, $t3, exit
		lw $a1, v($t0)
		
		
		jal find_elem
		continue: 
			addi $t0, $t0, 4
			move $t1, $t2
			addi $t1, $t1, -4
			j v_iteration
	find_elem: # element to find is stored in a1
		bgt $zero, $t1, elem_not_found
			lw  $t4, result($t1)
			beq $a1, $t4, elem_found
			addi $t1, $t1, -4
		j find_elem
	
	elem_found:
		jr $ra
		
	elem_not_found:
		sw $a1,  result($t2)
		addi $t2, $t2, 4
		
		j continue
		
	
	exit:
		j continue_main
		
	exit_program:
		li $v0, 10
		syscall
	
	
	

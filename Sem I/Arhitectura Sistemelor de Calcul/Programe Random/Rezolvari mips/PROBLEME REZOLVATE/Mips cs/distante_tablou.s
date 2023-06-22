
	.data
		nr:		.word		6
		array:		.word		3, 3, 5, 5, 9, 11
		Title:		.asciiz		"Program Started\n"
		Space:		.asciiz		" "
		Newline:	.asciiz		"\n"
		Finish:		.asciiz		"\nProgram finished\n"
	.text

		main:
			li	$v0, 4 # Program start
			la	$a0, Title
			syscall
			# --------Begin--------------

			la	$t0, array
			lw	$t1, nr
			addi	$sp, $sp, -8 # n , adresa si frame pointer
			sw	$t0, 0($sp)
			sw	$t1, 4($sp)
			
			jal	distance

			addi	$sp, $sp, 8
					 
			
			#----------End---------------
			li	$v0, 4 # Print finish
			la	$a0, Finish	
			syscall			
			li	$v0, 10 # Exit the program
			syscall

	distance:
		addi	$sp, -4
		sw	$fp, 0($sp)
		move	$fp, $sp
		
		lw	$t0, 8($fp) #nr 
		lw	$t1, 4($fp) # adresa
		
		li	$t3, -1 # poz prim element par
		li	$t2, 0
	for1:
		sll	$t4, $t2, 2
		add	$t4, $t4, $t1
		lw	$t5, 0($t4)
		li	$t4, 1
		and	$t4, $t4, $t5
		beq	$t4, $0, break1
		addi	$t2, 1
		bne	$t2, $t0, for1

	break1:
		move	$t3, $t2
		move	$t2, $t0
		addi	$t2, -1
		li	$t4, -1
	for2:		
		sll	$t5, $t2, 2
		add	$t5, $t5, $t1
		lw	$t6, 0($t5)
		li	$t5, 1
		and	$t5, $t5, $t6
		beq	$t5, $0, break2
		addi	$t2, -1		
		li	$t8, -1
		bne	$t2, $t8, for2
	break2:
		move	$t4, $t2
		sub	$s0, $t4, $t3
		blt	$s0, $t0, skip
		li	$s0, -1

	skip: 
		lw	$fp, 0($sp)
		addi	$sp, 4
		jr	$ra 


	maxVal:
		slt	$t0, $s0, $s1
		beq	$t0, $zero, swap
		move	$t1, $s0
		move	$s0, $s1
		move	$s1, $t1
		swap:
			nop
		jr	$ra							

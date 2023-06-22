
	.data
		string:		.space 		100
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

			li	$t0, 97
			li	$t1, 101
			la	$t2, string
			addi	$sp, $sp, -10 # a, b, adresa, frame pointer
			sb	$t0, 0($sp)
			sb	$t1, 1($sp)
			sw	$t2, 2($sp)
			sw	$fp, 6($sp)
			move	$fp, $sp
			
			jal	generate			
			
			sw	$fp, 6($fp)
			addi	$sp, $sp, 10
			
				
					 
			
		exit:	#---------End---------------
			li	$v0, 4 # Print finish
			la	$a0, Finish	
			syscall			
			li	$v0, 10 # Exit the program
			syscall

	generate:
		lb	$t0, 0($fp)
		lb	$t1, 1($fp)
		lw	$t2, 2($fp)
		li	$t3, 0
		
	for:	
		add	$t4, $t2, $t3
		sb	$t0, 0($t4)

		move	$a0, $t0
		li	$v0, 11
		syscall

		addi	$t0, 1
		addi	$t3, 1
		bne	$t0, $t1, for
		
		add	$t4, $t2, $t3
		sb	$0, 0($t4)
		
			
	
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

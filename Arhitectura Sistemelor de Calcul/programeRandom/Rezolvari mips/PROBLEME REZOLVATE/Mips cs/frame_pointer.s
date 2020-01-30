
	.data
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
			li	$t0, 2
			li	$t1, 5

			addi	$sp, $sp, -16 # a, b, frame pointer, return value
			sw	$t0, 0($sp)
			sw	$t1, 4($sp)
			sw	$fp, 8($sp)
			move 	$fp, $sp			

			jal	addNumbers

			lw	$t0, 0($sp)
			lw	$t1, 4($sp)
			lw	$fp, 8($sp)
			lw	$s0, 12($sp)
			addi	$sp, $sp, 16	
					 
			
			#----------End---------------
			li	$v0, 4 # Print finish
			la	$a0, Finish	
			syscall			
			li	$v0, 10 # Exit the program
			syscall

	addNumbers:
		lw	$t0, 0($fp)
		lw	$t1, 4($fp)
		add	$t0, $t0, $t1
		sw	$t0, 12($fp)
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

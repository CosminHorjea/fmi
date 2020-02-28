
	.data
		Title:		.asciiz		"Program Started\n"
		Space:		.asciiz		" "
		Newline:	.asciiz		"\n"
		Finish:		.asciiz		"\nProgram finished\n"
		Arr:		.word		6, 5, 1, 2, 9, 0, 100, 20, 16, 12
		N:		.word		10
	.text

		main:
			li	$v0, 4 # Program start
			la	$a0, Title
			syscall
			# --------Begin--------------
			addi	$sp, -8
			lw	$t0, N
			li	$s0, 1
			beq	$t0, $s0, skip
			blt	$t0, $s0, exit
			sw	$t0, 0($sp)
			la	$t0, Arr
			sw	$t0, 4($sp)
			jal	sort
			addi	$sp, 8	
			
	skip:		# loop to display the array
			lw	$t9, N
			la	$t3, Arr
			li	$t0, 0 # i = 0		
	displayloop:	sll	$t1, $t0, 2 # i*4
			add	$t1, $t1, $t3 # addr = arr + i*4
			lw	$t2, 0($t1) # load a[i] into $t2
			move	$4, $t2 # put t2 into $4 display register
			li	$v0, 1	# prepare to print integer
			syscall
			li	$v0, 4  # prepare to print space
			la	$a0, Space
			syscall	
			addi	$t0, $t0, 1 # i = i + 1
			bne	$t0, $t9, displayloop 
	
	exit:		#---------End---------------
			li	$v0, 4 # Print finish
			la	$a0, Finish	
			syscall			
			li	$v0, 10 # Exit the program
			syscall

	sort:
			subu	$sp, 4
			sw	$fp, 0($sp)
			addiu	$fp, $sp, 0
					
			li	$t0, 0 # i = 0
			li	$t1, 1 # j = 0
			lw	$t3, 8($fp) # load address of arr in $t3	
			lw	$t9, 4($fp) # load N into t9			
			addi	$t9, -1
				
		for1:	move	$t1, $0

		for2:	move	$t4, $t1 # load j
			sll	$t4, $t4, 2 # i*4 -- index in arr of arr[i]
			add	$t4, $t4, $t3 # loaded address of arr[i] -- arr address+ 4*i
			lw	$t6, 0($t4) # load arr[i] in t6
			move	$t5, $t1 # load j + 1
			addi	$t5, 1
			sll	$t5, $t5, 2 # j*4 -- index in arr of arr[j]
			add	$t5, $t5, $t3 # loaded address of arr[j]
			lw	$t7, 0($t5) # load arr[j] in t7						    
		        blt     $t6, $t7,donothing1 # if a[i] < a[j] do nothing, else swap them	
			move	$t8, $t6
			move	$t6, $t7
			move	$t7, $t8			 
	donothing1:
		
			sw	$t6, 0($t4) # load t6 back to a[i]
			sw	$t7, 0($t5) # load t7 back to a[j]
			addi	$t1, $t1, 1 # increment j

			move 	$t2, $t9
			sub	$t2, $t2, $t0
			addi	$t2, -1		
			ble	$t1, $t2, for2 # second loop
			addi	$t0, $t0, 1 # increment i
			ble	$t0, $t9, for1 # first loop
				
			lw	$fp, 0($fp)
			addu	$sp, 4
	
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

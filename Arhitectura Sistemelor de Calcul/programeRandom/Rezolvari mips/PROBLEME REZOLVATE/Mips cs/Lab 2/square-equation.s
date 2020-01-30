
	.data
		Title:		.asciiz		"Program Started\n"
		Space:		.asciiz		" "
		Newline:	.asciiz		"\n"
		msgNoSolution:	.asciiz		"Nu-s solutii"
		msgSolutionIs:	.asciiz		"Multimea solutiilor=\n"
		msgSolutionInf:	.asciiz		"Infinitate de solutii\n"
		Finish:		.asciiz		"\nProgram finished\n"
		coefA:		.float		120,0
		coefB:		.float		70,0
		coefC:		.float		-2000,0
		doubleV:	.float		2,0
		threehalf:	.float		1,5
		temp:		.space 		4
		magicConstant:	.word		0x5f375a86	
	.text

		main:
			li	$v0, 4 # Program start
			la	$a0, Title
			syscall
			# --------Begin--------------
			li	$v0, 6
			syscall	
			s.s	$f0, coefA			

			li	$v0, 6
			syscall	
			s.s	$f0, coefB

			li	$v0, 6
			syscall	
			s.s	$f0, coefC
			
			lwc1	$f2, coefA
			lwc1	$f4, coefB
			lwc1	$f6, coefC
			
				
			li.s	$f0, 0,0
			c.eq.s	$f2, $f0 # a=0 -> branch1 
			bc1t	branch_1		
			# calculate delta	
			li.s	$f8, 4,0
			mul.s	$f8, $f8, $f2
			mul.s	$f8, $f8, $f6
			mul.s	$f0, $f4, $f4
			sub.s	$f0, $f0, $f8	
			li.s	$f10, 0,0	
			c.lt.s	$f0, $f10 # if delta <0 exit -> branch_5
			bc1t	branch_5			
			c.eq.s	$f0, $f10 # if delta = 0 -> branch6
			bc1t	branch_6		

			jal	sqRoot # f0 = sqrt(delta)
			lwc1	$f2, coefA
			lwc1	$f4, coefB
			lwc1	$f6, coefC
			
			# solutia 1	
			li.s	$f10, 0,0
			sub.s	$f8, $f10, $f4
			add.s	$f8, $f8, $f0
			li.s	$f10, 2,0
			mul.s	$f10, $f10, $f2
			div.s	$f8,$f8,$f10			
			
			# solutia 2
			li.s	$f10, 0,0
			sub.s	$f12, $f10, $f4
			sub.s	$f12, $f12, $f0
			li.s	$f10, 2,0
			mul.s	$f10, $f10, $f2
			div.s	$f12,$f12,$f10			
			
			li	$v0, 4
			la	$a0, msgSolutionIs
			syscall			

			li	$v0, 2
			#mov.s	$f12, $f8
			syscall	
			
			li	$v0, 4	
			la	$a0, Newline
			syscall

			li	$v0, 2
			mov.s	$f12, $f8
			syscall
			j	exit				
			
	branch_5:	# delta < 0
			li	$v0, 4
			la	$a0, msgNoSolution
			syscall
			j 	exit	

	branch_6:	# x = -b/2a 		
			li.s	$f10, -1,0
			mul.s	$f10, $f10, $f4	
			div.s	$f10, $f10, $f2
			li.s	$f12, 2,0
			div.s	$f10, $f10, $f12
			
			li	$v0, 4
			la	$a0, msgSolutionIs
			syscall
			
			li	$v0, 2
			mov.s	$f12, $f10
			syscall	
			j	exit
	
	branch_1:	
			li.s	$f0, 0,0
			c.eq.s	$f0, $f4
			bc1t	branch_3 # b = 0 -> nu-s solutii
			# x = -c/b
			li.s	$f10, -1,0
			mul.s	$f10, $f10, $f6
			div.s	$f10, $f10, $f4
			
			li	$v0, 4
			la	$a0, msgSolutionIs
			syscall
			

			li	$v0, 2
			mov.s	$f12, $f10
			syscall	
			j 	exit

	branch_3:	
			li.s	$f0, 0,0
			c.eq.s	$f0, $f6
			bc1t	branch_4 # c = 0 -> solutii infinit
			
			j	branch_5
	branch_4:		
			li	$v0, 4
			la	$a0, msgSolutionInf
			syscall
			j	exit

	exit:
			#----------End---------------
			li	$v0, 4 # Print finish
			la	$a0, Finish	
			syscall			
			li	$v0, 10 # Exit the program
			syscall

	maxVal:
		slt	$t0, $s0, $s1
		beq	$t0, $zero, swap
		move	$t1, $s0
		move	$s0, $s1
		move	$s1, $t1
		swap:
			nop
		jr	$ra

	sqRoot:	# fast square root using float IEE 754 representation bit manipulation
		# f0 contains the nr -- f0 = nr_float
		lwc1	$f2, doubleV # f2 = 2.0 
		lwc1	$f4, threehalf	# f4 = 1.5
		div.s	$f6, $f0, $f2 # f6 = nr / 2
		la	$t0, temp # load address of temp in t0
		swc1	$f0, 0($t0) # store f6 in temp with -- temp = f6
		lw	$s0, temp # load s0 from temp -- s0 = temp
		sra	$t1, $s0, 1 # t1 = nr >> 1
		lw	$t2, magicConstant # t2 = magicConst
		sub	$t3, $t2, $t1 # t3 = magicCosnt - (nr >> 1)

		# nr_float = nr_float * (1.5 - nr_float/2 * nr_float * nr_float)
		sw	$t3, 0($t0) 		 
		lwc1	$f8, temp
		mul.s	$f10, $f8, $f8 # f10 = nr_float * nr_float
		mul.s	$f10, $f10, $f6 # f10 = nr_float/2 * f10
		sub.s	$f10, $f4, $f10 # f10 = 1.5 - f10
		mul.s	$f10, $f8, $f10 # f10 = nr_float * f10
		
		# repeat the above to increase precision 
		mov.s 	$f8, $f10  
		mul.s	$f10, $f8, $f8 # f10 = nr_float * nr_float
		mul.s	$f10, $f10, $f6 # f10 = nr_float/2 * f10
		sub.s	$f10, $f4, $f10 # f10 = 1.5 - f10
		mul.s	$f10, $f8, $f10 # f10 = nr_float * f10
		li.s	$f12, 1,0
		div.s	$f0, $f12, $f10 # f0 = 1 /sqrt(nr)
		jr 	$ra	

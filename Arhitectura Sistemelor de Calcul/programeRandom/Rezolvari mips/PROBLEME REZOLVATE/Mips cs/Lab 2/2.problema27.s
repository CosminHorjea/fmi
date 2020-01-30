.data
	suma: .word 0
	v: .word 1, 4, 7, 10, 2, 5, 8, 11, 3, 6, 9, 12 
	n: .word 4
	m: .word 3
	i: .space 4
	k: .space 4
	maxim: .space 4

.text
	main: 
             li $t0, 1
             sw $t0, i
             lw $t1, n
			 lw $t2, m
            bgt $t0, $t1, iesire
			bgt $t0, $t2, iesire
		    li $t0, 0
	        sw $t0, i #i = 0
		 
		 #cilcu1:
			intrare:
				lw $t0, i
				lw $t1, n
				bge $t0, $t1, iesire   
				    add $t0, $t0, $t0
					add $t0, $t0, $t0
					
					lw $t0, v($t0) 
					sw $t0, maxim
					lw $t2, maxim 
					 
					lw $t3, i
					lw $t4, n
					add $t3, $t3, $t4
					sw $t3, k
					
					
					#cilcu2 
					   intrare2:
					       lw $t2, maxim
					       lw $t3, k
						   lw $t6, n
						   lw $t7, m
						   mul $t8, $t6, $t7
				           li $t4, 0
					       add $t4, $t4, $t8
						   bge $t3, $t4, iesire2 
						    add $t3, $t3, $t3
							add $t3, $t3, $t3
					        lw $t3, v($t3) 
							bgt $t2, $t3, et1
							  sw $t3, maxim
							 et1:
							  lw $t3, k
							  lw $t5, n
							  add $t3, $t3, $t5
							  sw $t3, k 
							  j intrare2
						
						iesire2:
						  lw $t6, suma
						  lw $t7, maxim
						  add $t6, $t6, $t7
						  sw $t6, suma
						  
						  lw $t0, i
						  addi $t0, $t0, 1
						  sw $t0, i # i = i + 1
						  j intrare
					
			iesire:
			lw $t6, suma
              li $v0, 10
               syscall			  
	
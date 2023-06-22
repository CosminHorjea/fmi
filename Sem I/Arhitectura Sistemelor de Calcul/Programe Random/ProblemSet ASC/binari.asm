.data
	v: .word 16, 14, 10, 8, 7, 9, 3, 2, 4, 1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
	n: .word 10
.text
main:
	lw $t0,n
	subu $sp,$sp,4
	sw $t0,0($sp)
	
	la $t0,v
	subu $sp,$sp,4
	sw $t0,0($sp)

	jal eval

	addu $sp,$sp,8
	
	li $v0,1
	move $a0,$v1
	syscall
	
	j exit

eval:
	subu $sp,$sp,4
	sw $fp,0($sp)
	addi $fp,$sp,4
	
	subu $sp,$sp,4
	sw $ra,0($sp)
	# sp: (rav)(fpv)$fp:(*v)(n)
	subu $sp,$sp,4
	sw $s0,0($sp)
	
	subu $sp,$sp,4
	sw $s1,0($sp)

	lw $s0,0($fp) # v
	lw $s1,4($fp) # n
	li $t0,1
	li $t2,0 #suma
	for:
		bgt $t0,$s1,exit_eval
		subu $sp,$sp,4
		sw $s0, 0($sp)
		
		subu $sp,$sp,4
		sw $t0,0($sp)

		jal suma_drum_dreapta

		addu $sp,$sp,8
		
		add $t2,$t2,$v0
		addi $t0,$t0,1
		j for
		
		
exit_eval:
	move $v1,$t0
	# sp: ($s1)($s0)(rav)(fpv)$fp:(*v)(n)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	lw $ra, -8($fp)
	lw $fp, -4($fp)

	jr $ra

suma_drum_dreapta:
	subu $sp,$sp,4
	sw $fp,0($sp)
	addi $fp,$sp,4
	
	subu $sp,$sp,4
	sw $s3,0($sp)  

	subu $sp,$sp,4
	sw $s4,0($sp) 
	
	lw $s4,4($fp) #  *v
	lw $s3,0($fp) #  i
	
	lw $t4, 0($s4)
	li $t5,0
	for2:
		beq $t4,-1,exit_for2
		add $t5,$t5,$t4
		
		li $t6,4
		mul $s3,$s3,$t6
		li $t6,2
		mul $s3,$s3,$t6
		addi $s3,$s3,1

		add $s4,$s4,$s3

		lw $t4,0($s4)
exit_for2:
	# sp: ($s4)($s3)(fpv)$fp:(*v)(n)
	lw $s4, -12($fp)
	lw $s0, -8($fp)
	lw $fp, -4($fp)

	jr $ra

exit:
	li $v0,10
	syscall

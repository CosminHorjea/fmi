.data
	v: .word 1, 2, 3
	n: .word 3
.text
main:
	la $t0,v
	lw $t1,n

	subu $sp,$sp,4
	sw $t1,0($sp)

	subu $sp,$sp,4
	sw $t0,0($sp)

	jal modif

	addu $sp,$sp,8
	la $t0,v
	forAfis:
		beqz $t1,exitProgram
			lw $a0,0($t0)
			li $v0,1
			syscall
			addi $t0,$t0,4
			subu $t1,$t1,1
			j forAfis


	exitProgram:
	li $v0,10
	syscall

modif:
	subu $sp,$sp,4
	sw $fp,($sp)

	addu $fp,$sp,4

	subu $sp,$sp,4
	sw $ra,0($sp)

	subu $sp,$sp,4
	sw $s0,0($sp)

	subu $sp,$sp,4
	sw $s1,0($sp)

	lw $s0,0($fp)
	lw $s1,4($fp)

	for:
		beqz $s1,exitModif
			lw $t0,0($s0)
			addi $t0,$t0,1
			sw $t0,0($s0)
			addi $s0,$s0,4
			subu $s1,$s1,1
			j for
	exitModif:
		lw $s1,-16($fp)
		lw $s0,-12($fp)
		lw $ra,-8($fp)
		lw $fp,-4($fp)
		addi $sp,$sp,16

		jr $ra


#133-2
.data
	v: .word 10, 11, 12, 13
	w: .word 2, 3, 5, 6	
	n: .word 40
	p: .word 3
.text
main:
lw $t4,n
lw $t5,p

subu $sp,$sp,4
sw $t5,0($sp)

subu $sp,$sp,4
sw $t4,0($sp)

jal cel_putin_p_div

addu $sp,$sp,4

move $a0,$v0
li $v0,1
syscall
li $v0,10
syscall

cel_putin_p_div:
	subu $sp,$sp,4
	sw $fp,0($sp)
	addu $fp,$sp,4

	subu $sp,$sp,4
	sw $ra,0($sp)

	subu $sp,$sp,4
	sw $s0,0($sp)

	subu $sp,$sp,4
	sw $s1,0($sp)
	
	lw $s1,4($fp)
	lw $s0,0($fp)

	li $t0,1
	li $t2,0
	for_div:
		bgt $t0,$s0,exit_div
			rem $t1,$s0,$t0
			bnez $t1, cont
				addi $t2,$t2,1
	cont:
		addu $t0,$t0,1
		j for_div

exit_div:
	bgt $t2,$s1, exit_adev
	li $v0,0
	j exit_div2
	exit_adev:
		li $v0,1
exit_div2:
	lw $s1,-16($fp)
	lw $s0, -12($fp)
	lw $ra, -8($fp)
	lw $fp, -4($fp)

	addi $sp,$sp,16

	jr $ra

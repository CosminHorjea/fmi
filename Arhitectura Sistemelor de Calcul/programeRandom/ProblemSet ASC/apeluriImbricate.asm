#Sa se implementeze un program care sa calculeze functia f(x) = 2g(x), unde g(x) = x+1.

.data
	x: .word 5
.text

main:
	# push x
	lw $t0, x
	subu $sp, 4
	sw $t0, 0($sp)

	jal f

	addu $sp, 4

	move $a0, $v0
	li $v0, 1
	syscall

	li $v0, 10
	syscall

f:
	subu $sp, 4
	sw $fp, 0($sp)
	addi $fp, $sp, 4
	# $sp:($fp v)$fp:(x)
	
	subu $sp, 4
	sw $ra, 0($sp)

	# $sp:($ra v)($fp v)$fp:(x)

	subu $sp, 4
	sw $s0, 0($sp)

	# $sp:($s0 v)($ra v)($fp v)$fp:(x)

	lw $s0, 0($fp)

	subu $sp, 4
	sw $s0, 0($sp)
	jal g
	addu $sp, 4

	mul $v0, $v0, 2 # f(x) = 2g(x), g(x) returnase in $v0

	lw $s0, -12($fp)
	lw $ra, -8($fp)
	lw $fp, -4($fp)
	addu $sp, 12
jr $ra

g:
	subu $sp, 4
	sw $fp, 0($sp)
	addi $fp, $sp, 4
	# $sp:($fp v)$fp:(x)

	subu $sp, 4
	sw $s0, 0($sp)
	# $sp:($s0 v)($fp v)$fp:(x)
	
	lw $s0, 0($fp)

	addi $v0, $s0, 1 # g(x) = x + 1 adica $v0 = $s0 + 1

	lw $s0, -8($fp)
	lw $fp, -4($fp)

	addu $sp, 8
	jr $ra

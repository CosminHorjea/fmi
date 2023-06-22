.data
	x: .word 2
	y: .word 0
	z: .word 0
	n: .word 5
	v: .word 1, 2, 3, 4, 5
.text
	eval:
		subu $sp, 4
		sw $fp, 0($sp)
		addi $fp, $sp, 4

		subu $sp, 4
		sw $ra, 0($sp)

		subu $sp, 4
		sw $s0, 0($sp)

		subu $sp, 4
		sw $s1, 0($sp)

		subu $sp, 4
		sw $s2, 0($sp)

		subu $sp, 4
		sw $s3, 0($sp)

		subu $sp, 4
		sw $s4, 0($sp)

		lw $s0, 0($fp)	# adresa lui v
		lw $s1, 4($fp)	# n
		lw $s2, 8($fp)	# x
		lw $s3, 12($fp)	# y
		lw $s4, 16($fp) # z

		li $v1, 0	# suma

		loop:
		beqz $s1, exit
			li $t0, 0	# v[i] + y = 0
			lw $t1, 0($s0)	# v[i]
			add $t0, $t0, $t1
			add $t0, $t0, $s3	# v[i] + y

			subu $sp, 4
			sw $t0, 0($sp)	# push(v[i] + y)

			subu $sp, 4
			sw $s2, 0($sp)	# push(x)

			jal exactXDivizori
			addi $sp, 8

			subu $t0, $t0, $s4

			mul $v0, $t0, $v0

			add $v1, $v1, $v0

			addi $s0, 4
			addi $s1, -1
			j loop

	exit:
		lw $s4, -28($fp)
		lw $s3, -24($fp)
		lw $s2, -20($fp)
		lw $s1, -16($fp)
		lw $s0, -12($fp)
		lw $ra, -8($fp)
		lw $fp, -4($fp)
		addi $sp, 28
		jr $ra

	exactXDivizori:
		subu $sp, 4
		sw $fp, 0($sp)
		addi $fp, $sp, 4

		lw $t3, 0($fp)	# x
		lw $t4, 4($fp)	# v[i] + y

		li $t5, 1	# nr_divizori
		li $t6, 2	# pe post de j

		loop2:
		bgt $t6, $t4, exit2
			rem $t7, $t4, $t6
			addi $t6, 1
			beqz $t7, incrementare
			j loop2

		incrementare:
			addi $t5, 1
			j loop2

		exit2:
			beq $t5, $t3, afirmativ
				lw $fp, -4($fp)
				addi $sp, 4
				li $v0, 0
				jr $ra
		afirmativ:
			li $v0, 1
			lw $fp, -4($fp)
			addi $sp, 4
			jr $ra

main:
	lw $t0, n
	la $t1, v
	lw $t2, x
	lw $t3, y
	lw $t4, z

	subu $sp, 4
	sw $t4, 0($sp)	# push(z)

	subu $sp, 4
	sw $t3, 0($sp)	# push(y)

	subu $sp, 4
	sw $t2, 0($sp)	# push(x)

	subu $sp, 4
	sw $t0, 0($sp)	# push(n)

	subu $sp, 4
	sw $t1, 0($sp)	# push(v) - adresa

	jal eval
	addi $sp, 20

	move $a0, $v1
	li $v0, 1
	syscall

	li $v0, 10
	syscall
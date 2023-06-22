.data
	x: .word 28
.text

perfect:
	subu $sp, 4
	sw $fp, 0($sp)
	# $sp: ($fp v)(x)
	addi $fp, $sp, 4
	# $sp: ($fp v)$fp:(x)
	
	subu $sp, 4
	sw $s0, 0($sp)
	# $sp:($s0 v)($fp v)$fp:(x)

	lw $s0, 0($fp)
	# verific daca $s0 este perfect i.e. $s0 = suma div. sai pana la jumatate

	div $t0, $s0, 2 # $t0 = $s0 / 2 = x / 2
	li $t1, 1 # pe post de index in for
	li $t2, 0 # pe post de suma

	for: 
		# daca i > x/2 => mergi la exit
		# daca $t1 > $t0 => exit
		bgt $t1, $t0, exit
		rem $t3, $s0, $t1 # $t3 = $s0 % $t1
		beqz $t3, edivizor
	cont:
		addi $t1, 1
		j for

	edivizor:
		add $t2, $t2, $t1
		j cont

	exit:
		seq $v0, $s0, $t2
		# daca $s0 == $t2 at. $v0 = 1, altfel $v0 = 0
		lw $s0, -8($fp)
		lw $fp, -4($fp)
		addu $sp, 8
	jr $ra

main:
	# push x
	lw $t0, x
	subu $sp, 4
	sw $t0, 0($sp)

	jal perfect

	 addu $sp, 4

	move $a0, $v0
	li $v0, 1
	syscall

	li $v0, 10
	syscall

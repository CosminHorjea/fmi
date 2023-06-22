
.data
	v: .space 100 
	n: .space 4
	x: .space 4
	y: .space 4
	z: .space 4

.text

main:
	# se citeste n de la tastatura
	li $v0, 5
	syscall
	
	sw $v0, n	# se stocheaza n in memorie
	lw $t0, n
	li $t1, 0
	
	loop_read:
		beqz $t0 cont
		
		li $v0, 5
		syscall
		sw $v0, v($t1)

		sub $t0, $t0, 1
		add $t1, $t1, 4
		
		j loop_read

cont:
	# se citesc pe rand x, y si z si se stocheaza in memorie
	li $v0, 5
	syscall
	sw $v0, x
	
	li $v0, 5
	syscall
	sw $v0, y
	
	li $v0, 5
	syscall
	sw $v0, z

	# pun totul pe stiva in ordine inversa citirii pe stiva
	lw $t0, z
	subu $sp, $sp, 4 
	sw $t0, 0($sp)

	lw $t0, y
	subu $sp, $sp, 4 
	sw $t0, 0($sp)

	lw $t0, x
	subu $sp, $sp, 4 
	sw $t0, 0($sp)

	lw $t0, n
	subu $sp, $sp, 4 
	sw $t0, 0($sp)

	la $t0, v
	subu $sp, $sp, 4 
	sw $t0, 0($sp)

	jal evalueaza

	addu $sp, $sp, 20

	move $a0, $v1
	li $v0, 1
	syscall

	li $v0, 10
	syscall

evalueaza:
	subu $sp, $sp, 4 #fac loc de $fp
	sw $fp, 0($sp)
	addi $fp, $sp, 4 # fac fp sa pointeze la primul parametru
	# $sp:($fp v) $fp:(*v)(n)(x)(y)(z)

	subu $sp, $sp, 4
	sw $ra, 0($sp)
	# $sp:($ra v)($fp v) $fp:(*v)(n)(x)(y)(z)

	subu $sp, $sp, 4
	sw $s0, 0($sp)

	subu $sp, $sp, 4
	sw $s1, 0($sp)

	subu $sp, $sp, 4
	sw $s2, 0($sp)

	subu $sp, $sp, 4
	sw $s3, 0($sp)

	subu $sp, $sp, 4
	sw $s4, 0($sp)
	#$sp:($s4)($s3)($s2)($s1)($s0)($ra v)($fp v) $fp:(*v)(n)(x)(y)(z)
	lw $s0, 0($fp) 		# *v
	lw $s1, 4($fp)		# n
	lw $s2, 8($fp) 		# x
	lw $s3, 12($fp) 	# y
	lw $s4, 16($fp) 	# z

	div $t0, $s4, 3 	# $t0 = [z/3]

	li $t1, 0
	li $v1, 0

	for: 
		bgt $t1, $s1, exit_evalueaza

		lw $t2, 0($s0)	# $t2 = v[i]

		subu $sp, $sp, 4
		sw $t2, 0($sp)	# push nr din vector in stiva

		jal suma_cifre_pare

		addu $sp, $sp, 4

		mul $v0, $v0, -1
		addi $v0, $v0, 1	# 1 - $v0
		#move $a0,$v0
		#li $v0,1
		#syscall
		#move $v0,$a0

		rem $t3, $t2, $s2 	# t3 = v[i] % x 
		sub $t4, $s3, $t0
		add $t4, $t4, $t1
		move $t5, $t4

		# $t4 = ($t4)^3
		mul $t4, $t4, $t4
		mul $t4, $t4, $t5

		add $t3, $t3, $t4
		mul $v0, $v0, $t3
		add $v1, $v1, $v0

		addi $t1, $t1, 1
		addi $s0, $s0, 4

		j for

exit_evalueaza:
	# $sp:($s4 n)($s3 n)($s2 n)($s1 n)($s0 n)($ra)($fp n) $fp:(*v)(n)(x)(y)(z)
	lw $s4, -28($fp)
	lw $s3, -24($fp)
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	lw $ra, -8($fp)
	lw $fp, -4($fp)

	addu $sp, $sp, 28

	jr $ra
	
suma_cifre_pare:
	subu $sp, $sp, 4
	sw $fp, 0($sp)

	addi $fp, $sp, 4
	# $sp:($fp v) $fp:(x)

	subu $sp, $sp, 4
	sw $s5, 0($sp)
	
	lw $s5,0($fp)

	while:
		beqz $s5, exit_suma
		
		rem $t8, $s5, 10
		add $t9, $t9, $t8
		div $s5, $s5, 10

		j while

exit_suma:
	rem $v0, $t9, 2
	sne $v0, $v0, 1

	lw $s5, -8($fp)
	lw $fp, -4($fp)

	addu $sp, $sp, 8

	jr $ra

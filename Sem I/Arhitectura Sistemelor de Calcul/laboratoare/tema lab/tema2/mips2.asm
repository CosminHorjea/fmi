# Tema ASC 2
# modifica un element din vector cu suma patratelor numerelor mai mici strict decat el

.data
	v: .word 3, 4, 5, 6
	n: .word 4
	space : .asciiz " "
.text
main:
	# push n
	lw $t0, n
	subu $sp, $sp,4
	sw $t0, 0($sp)
	
	# push v
	la $t0, v
	subu $sp, $sp,4
	sw $t0, 0($sp)
	
	jal modif
	
	# eliberare stiva
	addu $sp, $sp,8
	
	# afisare
	li $t0,0
	lw $t1,n
	afisare:
		beq $t0,$t1,exit2
		mul $t2,$t0,4
		lw $a0,v($t2)
		li $v0,1
		syscall
		la $a0,space
		li $v0,4
		syscall
		addi $t0,$t0,1
		j afisare
	exit2:
	li $v0, 10
	syscall
suma_patrate:
	subu $sp,$sp,4
	sw $fp,0($sp)
	addi $fp,$sp,4
	subu $sp,$sp,4
	sw $ra,0($sp)
	subu $sp,$sp,4
	sw $s0,0($sp)
	
	lw $s0,0($fp)
	blez $s0,exitRecPatrate #daca e numar negativ
	
	li $t8,1
	beq $s0,$t8,exitRecPatrate
	addi $s0,$s0,-1
	mul $t4,$s0,$s0
	add $v0,$v0,$t4
	subu $sp,$sp,4
	sw $s0,0($sp)
	jal suma_patrate
exitRecPatrate:
	lw $s0,-12($fp)
	lw $ra,-8($fp)
	lw $fp -4($fp)
	addu $sp,$sp,12
	jr $ra
	
	modif:
		# push $fp
		subu $sp,$sp, 4
		sw $fp, 0($sp)
		
		addi $fp, $sp, 4
		
		# push $ra
		# pt. procedura recursiva
		subu $sp, $sp,4
		sw $ra, 0($sp)
		
		subu $sp, $sp,4
		sw $s0, 0($sp)

		subu $sp,$sp, 4
		sw $s1, 0($sp)
		
		lw $s0, 0($fp)
		lw $s1, 4($fp)
		
		beqz $s1, exit
		
		# incrementarea unui element si salvarea lui
		lw $t0, 0($s0)
		#addi $t0, 1
		#sw $t0, 0($s0)
		
		
		subu $sp,$sp,4
		#lw $t7,0($s0)
		#addi $t7,$t7,
		sw $t0,0($sp)
		
		jal suma_patrate
		addu $sp,$sp,4
		sw $v0,0($s0)
		li $v0,0
		addi $s0,$s0, 4
		addi $s1,$s1, -1
		
		### apelare recursiva
		
		subu $sp,$sp, 4
		sw $s1, 0($sp)
		subu $sp,$sp,4
		sw $s0, 0($sp)
		
		jal modif
		
		addu $sp,$sp, 8
		
		###
		
		exit:
		lw $s1, -16($fp)
		lw $s0, -12($fp)
		lw $ra, -8($fp)
		lw $fp, -4($fp)
		addu $sp,$sp, 16
		jr $ra

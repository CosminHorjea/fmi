#Proceduri recursive. Sa se implementeze procedura proc(x), x > 1, cu definitia:
#proc(x) = afiseaza x, proc(x-1), daca x != 0
#	   stop, altfel
#proc(3) = 321

.data
	x: .word 3
.text

main:
	# push x
lw $t0, x	
subu $sp, 4
	sw $t0, 0($sp)

	jal proc

	addu $sp, 4
	li $v0, 10
	syscall

proc:
	subu $sp, 4
	sw $fp, 0($sp)
	addi $fp, $sp, 4
	
	subu $sp, 4
	sw $ra, 0($sp) # pentru ca fac apeluri imbricate catre proc

	subu $sp, 4
	sw $s0, 0($sp)

	# $sp:($s0 v)($ra v)($fp v)$fp:(x)

	lw $s0, 0($fp)

	beqz $s0, exit # daca x = 0, atunci oprim procedura
	
	move $a0, $s0
	li $v0, 1
	syscall

	addi $s0, -1
	
	subu $sp, 4
	sw $s0, 0($sp)
	jal proc
	addu $sp, 4

exit:
	lw $s0, -12($fp)
	lw $ra, -8($fp)
	lw $fp, -4($fp)
	addu $sp, 12
	jr $ra

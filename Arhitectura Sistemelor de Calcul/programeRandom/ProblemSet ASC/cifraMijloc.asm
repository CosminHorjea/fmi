.data
	x:.word 1234
.text
main:
	lw $t0,x
	subu $sp,$sp,4
	sw $t0,0($sp)
	
	jal sumaCifraPara
	
	addu $sp,$sp,4
	li $v0,10
	syscall

sumaCifraPara:
	subu $sp,$sp,4
	sw $fp,0($sp)
	addu $fp,$sp,4
	
	subu $sp,$sp,4
	sw $ra,0($sp)
	
	subu $sp,$sp,4
	sw $s0,0($sp)
	
	lw $s0,0($fp)
	li $t1,0 #nr cifre
	for_cifre:
		beqz $s0, cont
		div $s0,$s0,10
		addi $t1,$t1,1
		j for_cifre
	cont:
		remu $t7, $t1,2
		beqz $t7,cifrePare
		
	exitSuma:
		lw $s0,-12($fp)
		lw $ra, -8($fp)
		lw $fp, -4($fp)
		
		jr $ra
	
	
	
.data
	str1: .asciiz "DJSAHK"
	vocale: .asciiz "AEIOU"
	ch: .byte 'A'
.text
main:
	la $t0,str1
	lb $t1,ch
	
	subu $sp,$sp,4
	sb $t1,0($sp) #push ch
	
	subu $sp,$sp,4
	sw $t0,0($sp) #push *str1
	
	jal strchr_cons
	
	addu $sp,$sp,8
	
	move $a0,$v0 
	li $v0,1
	syscall 
	
	li $v0,10
	syscall
	
strchr_cons:
	subu $sp,$sp,4
	sw $fp,0($sp)
	addu $fp,$sp,4
	
	subu $sp,$sp,4
	sw $ra,0($sp)
	# ($ra)($fpv)$fp:(*str1)(ch)
	subu $sp,$sp,4
	sw $s0,0($sp)
	
	subu $sp,$sp,4
	sw $s1,0($sp)
	
	lw $s0,0($fp)
	lb $s1,4($fp)
	for_str:
		lb $t4,0($s0)
		beqz $t4 ,exit_strchr
			bne $t4,$s1,cont
				lb $t5,1($s0)
				subu $sp,$sp,4
				sw $t5,0($sp)
		
				jal este_consoana
			
				addu $sp,$sp,4
				li $t3,1
				beq $v1,$t3,exit_ok
		
		cont:
		addi $s0,$s0,1
		j for_str
exit_ok:
	subu $v0,$s0,$t0 #daca nu e trebuie -1
	j exit_strchr
exit_strchr:
	lw $s1,-16($fp)
	lw $s0,-12($fp)
	lw $ra, -8($fp)
	lw $fp, -4($fp)
	jr $ra
este_consoana:
	subu $sp,$sp,4
	sw $fp,0($sp)
	addu $fp,$sp,4
	
	subu $sp,$sp,4
	sw $s2,0($sp)
	
	lb $s2,0($fp)
	
	la $t6,vocale
	
	for_consoane:
		lb $t7,0($t6)
		beqz $t7, exit_adev
		beq $s2, $t7 exit_fals
		addi $t6,$t6,1
		j for_consoane
	exit_adev:
		li $v1,1
		j exit_consoane
	exit_fals:
		li $v1,0
		j exit_consoane
exit_consoane:
	lw $s2,-8($fp)
	lw $fp,-4($fp)
	
	addi $sp,$sp,8
		
	jr $ra

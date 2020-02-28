.data
	n: .word 3
	k: .word 2
.text
main:


	lw $a0, n
	lw $a1, k

	jal comb

	add $a0,$v0,$zero
	li $v0,1
	syscall

	li $v0,10
	syscall

comb:
#a0 = n, a1 = k
#if( n == k ) return 1;
#if ( n == 1 ) return 1;
#if ( k == 1 ) return 1;
#return( comb(n-1, k)+comb(n-1, k-1) );

	addi $sp,$sp,-16
	sw $ra,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)

	add $s0, $a0, $zero    #s0 = n
	add $s1, $a1, $zero	#s1 = k

	beq $s0, $s1, return1 	
	beq $s0,$zero, return1	
	beq $s1,$zero, return1	

	addi $a0,$s0,-1		

	jal comb

	add $s2,$zero,$v0     #s2 = comb(n-1, k)

	addi $a0,$s0,-1	
	addi $a1,$s1,-1		

	jal comb               #v0 = comb(n-1, k-1)

	add $v0,$v0,$s2       #v0 = comb(n-1, k - 1) + $s2

exitcomb:

	lw $ra,0($sp)       
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	addi $sp,$sp,16       
	jr $ra

return1:
 	li $v0,1
 	j exitcomb

#Lab5: 5
.data
das: .asciiz "da"
nus: .asciiz "nu"
.text

main: 
	li $t0,10
	
	li $v0,5
	syscall
	move $s0,$v0
	
	li $v0,5
	syscall
	move $s1,$v0

	loop:
	div $s0,$t0
	mflo $s0
	mfhi $t1
	beq $t1,$s1,da
	bnez $s0,loop
	
	j nu

nu:
la $a0,nus
li $v0,4
syscall
li $v0,10
syscall

da:
la $a0,das
li $v0,4
syscall
li $v0,10
syscall

	.data
		x: .word 4
		y: .word 6
		sp: .asciiz " "

	.text
main:
	lw $t0, x
	lw $t1, y
	sw $t1, x
	sw $t0, y
	move $a0,$t1
	li $v0,1
	syscall
	la $a0, sp
	li $v0,4
	syscall
	move $a0,$t0
	li $v0,1
	syscall
	li $v0,10
	syscall

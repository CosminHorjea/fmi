.data	
	#suma numerelor
	n: .word 4
	v: .word 2,3,1,1
	
.text
main:
	lw $t3,n
	li $t0,4
	mulo $t3,$t3,4
for:
	bge $t0,$t3,final
	lw $t5,v($t0)
	add $t4,$t4,$t5
	addi $t0,$t0,4	
	j for
final:
	move $a0,$t4
	li $v0,1
	syscall
	li $v0,10
	syscall
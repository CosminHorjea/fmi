.data
sir: .asciiz "azscsffq"
.text
# $s0 ->contorMAX
# $s1 ->lieraMAX
# $s2 ->contorACC
main:
	li $s2,1
	#citire pr char
	lb $s3,sir($t2)
	addiu $t2,$t2,1

	mainLoop:
		lb $s4,sir($t2)
		beq $s4,$s3,incrC
		bne $s4,$s3,notEq
	continuareLoop:
		addiu $t2,$t2,1
		move $s3,$s4
		bnez $s3,mainLoop
	li $v0,10
	syscall



incrC:
	add $s2,$s2,1
	j continuareLoop

notEq:
	blt $s2,$s0,notAct
	move $s0,$s2
	notAct:
	li $s2,1
	j continuareLoop

	
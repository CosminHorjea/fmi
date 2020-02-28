#Lab5: 6
.data
n: .word 3
mat: .word 1 ,2 ,3 ,4 ,5 ,6 ,7 ,8 , 9
das: .asciiz "da"
nus: .asciiz "nu"
.text
main:
	li $t2,2
	lw $s0,n
		loop:
		mulo $t1,$t0,$s0
		add $t1,$t1,$t0
		mulo $t1,$t1,4
		lw $s1,mat($t1)
		div $s1,$t2
		mfhi $t3
		beqz $t3,nu
		add $t0,$t0,1
		blt $t0,$s0,loop
	j da


da:
la $a0,das
li $v0,4
syscall
li $v0,10
syscall


nu:
la $a0,nus
li $v0,4
syscall
li $v0,10
syscall
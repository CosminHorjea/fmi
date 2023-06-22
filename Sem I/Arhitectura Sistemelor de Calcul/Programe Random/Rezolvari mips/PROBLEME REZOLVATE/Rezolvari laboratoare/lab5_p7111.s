.data
n: .word 5
vector: .word 5 ,1 ,3 ,2 ,7
.text
#s0 ->nr comp
#t0 ->i
#t1 ->j
#a0 -> vetor+i 
#a1 -> vetor+j 
#t1 ->s1-s2
main:
	
	lw $s0,n
	add $s1 ,$s0 , -1

	loop1:
		mulo $t2,$t0,4
		lw $a0,vector($t2)
		add $t1,$t0,1		
		loop2:
			mulo $t3,$t1,4
			lw $a1,vector($t3)
			bgt $a1,$a0, notI
			
				#interschimbare in mem
				sw $a1,vector($t2)
				sw $a0,vector($t3)
				#interschimbare in reg
				lw $a0,vector($t2)
				lw $a1,vector($t3)
			
			notI:
			add $t1,$t1,1
		blt $t1,$s0,loop2
		
		add $t0,$t0,1
	blt $t0,$s1,loop1  #$s0-1
	
	li $t0,0
	li $t2,0
	lw $t7,n
	#add $t5,t7,-1
	loop3:
	lb $a0,vector($t2)
	mulo $t2,$t0,4
	li $v0,1
	syscall
	bltz $t7,loop3
	

	li $v0,10
	syscall

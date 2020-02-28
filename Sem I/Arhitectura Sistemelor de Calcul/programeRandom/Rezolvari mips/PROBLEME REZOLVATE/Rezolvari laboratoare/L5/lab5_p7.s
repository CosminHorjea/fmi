#Lab5: 7
.data
n: .word 5
vector: .word 5 ,1 ,3 ,2 ,7
.text
#Legenda:
#s0 ->nr comp
#t0 ->i
#t1 ->j
#a0 -> vetor+i 
#a1 -> vetor+j 
#t1 ->s1-s2
main:
	
	lw $s0,n				#incarca in registrul s0 numarul de elemente
	add $s1 ,$s0 , -1			#incarca in registrul s0 numarul de elemente-1

	loop1:
		mulo $t2,$t0,4			#se obtine adresa in memorie a urmatoarei valori 
		lw $a0,vector($t2)		#incarca in a0 elementul pe care se afla pointerul din vector
		add $t1,$t0,1		
		loop2:
			mulo $t3,$t1,4		#simuleaza j-ul, care merge de la i+1 la n
			lw $a1,vector($t3)
			bgt $a1,$a0, notI	#daca a1 < a0 se interschimba 
			
				#interschimbare in mem
				sw $a1,vector($t2)
				sw $a0,vector($t3)
				#interschimbare in reg
				lw $a0,vector($t2)
				lw $a1,vector($t3)
			
			notI:
			add $t1,$t1,1		 #j++
		blt $t1,$s0,loop2		 #while j<n-1
		
		add $t0,$t0,1			#i++
	blt $t0,$s1,loop1  #$s0-1		#$s0-1, n-1   adica t0 < n-1 , t0 =i
	
	li $v0,10
	syscall

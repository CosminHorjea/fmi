#arg si valori returnate de proceduri
.data
	x: .word 100
	y: .word 250
.text
 main:
 	#prin conventie arg procedurilor le punem in $a0,a1,a2 si a3
 	lw $a1,x
 	lw $a2,y
 	jal adunare
 	

 	li $v0,1
 	move $a0,$v1 #a0=v1
 	syscall
 	
 	li $v1,10
 	syscall
 	
 	adunare: #prin cinventie val returnate de proceduri se pun in $v1
 		add $v1,$a1,$a2
 		jr $ra
 		
 		
 		
 		
 		
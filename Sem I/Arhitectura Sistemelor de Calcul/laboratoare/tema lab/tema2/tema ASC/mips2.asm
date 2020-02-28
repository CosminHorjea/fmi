# Tema ASC 2
# modifica un element din vector cu suma patratelor numerelor mai mici strict decat el

.data
	v: .word 3, 4, 5, 6
	n: .word 4
	space : .asciiz " "
.text
main:
	# push n pe stiva
	lw $t0, n
	subu $sp, $sp,4
	sw $t0, 0($sp) # pun pe n pe stiva
	
	# push v pe stiva
	la $t0, v
	subu $sp, $sp,4
	sw $t0, 0($sp) # pun adresa lui v pe stiva
	
	jal modif 
	
	# eliberez stiva
	addu $sp, $sp,8
	
	# afisare
	li $t0,0
	lw $t1,n
	afisare:
		beq $t0,$t1,exitProgram
		mul $t2,$t0,4
		lw $a0,v($t2)
		li $v0,1
		syscall
		la $a0,space
		li $v0,4
		syscall
		addi $t0,$t0,1
		j afisare
	exitProgram:
	li $v0, 10
	syscall
suma_patrate:
	#push $fp pe stiva
	subu $sp,$sp,4
	sw $fp,0($sp)
	addi $fp,$sp,4

	#push la $ra pe stiva
	subu $sp,$sp,4
	sw $ra,0($sp)

	#alocare de spatiu pt variabile din procedura
	subu $sp,$sp,4
	sw $s0,0($sp)
	
	#incarcare parametrului
	lw $s0,0($fp)
	blez $s0,exitRecPatrate #daca e numar negativ nu exista numere naturale mai mici decat el
	
	li $t8,1
	beq $s0,$t8,exitRecPatrate #daca elementul curent e egal cu 1 ies din functie (base case pentru recursie)
	addi $s0,$s0,-1 #scad 1 din el curent pt ca trebuie sa iau in considerare numerele mai mici strict decat el curent
	mul $t4,$s0,$s0 # calculez patratul in $t4
	add $v0,$v0,$t4 # il adaug in $v0

	#fac loc pe stiva si adaug elementul urmator
	subu $sp,$sp,4 
	sw $s0,0($sp)

	#apelez functia recursiva
	jal suma_patrate

exitRecPatrate:
	# restaurez cadrul de apel si ma intorc in functia modif
	lw $s0,-12($fp)
	lw $ra,-8($fp)
	lw $fp -4($fp)
	addu $sp,$sp,12
	jr $ra
	
modif:
	# push $fp
	subu $sp,$sp, 4
	sw $fp, 0($sp)
	
	addi $fp, $sp, 4
	
	# push $ra
	subu $sp, $sp,4
	sw $ra, 0($sp)
	
	#fac loc pentru variabilele folosite in procedura
	subu $sp, $sp,4
	sw $s0, 0($sp)

	subu $sp,$sp, 4
	sw $s1, 0($sp)
	
	#incarc parametrii in $s0 si $s1
	lw $s0, 0($fp)
	lw $s1, 4($fp)
	
	beqz $s1, exit #daca s1 e zero am terminat
	
	lw $t0, 0($s0) # iau primul element din v
	
	#fac loc pe stiva pentru elementul curent si il adaug
	subu $sp,$sp,4 
	sw $t0,0($sp)
	
	jal suma_patrate

	# pun suma partatelor pt el curent pe stiva
	addu $sp,$sp,4
	sw $v0,0($s0) #salvez suma in locul elementului in vector

	li $v0,0 # resetez suma pentru urmatorul element
	addi $s0,$s0, 4 #trec la urmatorul element din vector
	addi $s1,$s1, -1 # scad din lungime 
	
	### apelare recursiva
	
	#pun pe stiva lungimea si adresa vectorului pentru a le folosi in urmatorul apel
	subu $sp,$sp, 4
	sw $s1, 0($sp)
	subu $sp,$sp,4
	sw $s0, 0($sp)
	
	jal modif
	
	addu $sp,$sp, 8
	
	###
	
	exit:
	#restaurez cadrul de apel
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	lw $ra, -8($fp)
	lw $fp, -4($fp)
	addu $sp,$sp, 16
	jr $ra

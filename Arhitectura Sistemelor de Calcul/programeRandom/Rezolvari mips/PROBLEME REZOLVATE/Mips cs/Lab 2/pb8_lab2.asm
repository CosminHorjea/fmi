.data 
	msg1: .asciiz "Introdu valori [pune -1 cand vrei sa termini]\n"
	msg2: .asciiz "a[][] = "
	msg3: .asciiz " "
	msg4: .asciiz "Matricea este:\n"
.text
	main:
	move $s0,$gp # de aici incepe stocarea elementelor gp = global pointer
	li $t2, 0 # contor pentru nr de elemente
	sub $t7,$zero,1 
	li $v0,4		# afiseaza mesaj
	la $a0,msg1		
	syscall		
	
	add $s1,$s0,$zero	# copiez pointerul de la matrice in $s1
	add $s2, $s0, $zero
valori:
	li $v0,4		# afiseaza mesaj
	la $a0,msg2	
	syscall	
	li $v0,5		# pun valoarea in v0 
	syscall		
	
	beq $v0,$t7, out # verific daca elementul este -1, daca e, ma opresc
	sb $v0,0($s1)	# pun valoarea pe positia data de $s1
	addi $s1, $s1, 4		# merg pe urmatoare pozitie din matrice
	addi $t2, $t2, 1
	j valori
out:
	PRINT:
## afisare
li $v0, 4
la $a0, msg4
syscall
while:
	beq		$t2, $zero, sfarsitWhile
	# pun spatiu
	li		$v0, 4
	la		$a0, msg3
	syscall
	# printez un element din matrice
	li		$v0, 1
	lw		$a0, 0($s2)
	syscall
	addi	$t2, $t2, -1
	addi	$s2, $s2, 4
	
	j		while
sfarsitWhile:
li $v0, 10
syscall
 #Program care calculeaza suma divizorilor unui numar natural. Numarul este
 #dat intr-o variabila n de tip word declarata cu initializare in program;
 #suma va fi stocata in final intr-o variabila s de tip word.

.data
  sum: .asciiz "Suma divizorilor lui "
  plus: .asciiz " + "
  equal: .asciiz " = "
  n:.word 12
  suma:.word 0

.text
main:

  lw $t0, n
  lw $t1, suma

  li $v0, 4
  la $a0, sum
  syscall

  li $v0, 1
  lw $a0, n
  syscall

  li $v0, 4
  la $a0, equal
  syscall

  subu $t3, $t0, 1
  
  add $t2, $zero, $t3
  while:
	ble $t2, 1, printSum
	div $t0, $t2
	mfhi $s0   
	beq $s0, $zero, addSum

	subu $t2, $t2, 1
	j while

  li $v0, 10
  syscall
update:
  subu $t2, $t2, 1
  j while
addSum:
  add $t1, $t1, $t2
  
  li $v0, 1
  add $a0, $zero, $t2
  syscall
  
  li $v0, 4
  la $a0, plus
  syscall
  
  j update
 
printSum:
  li $v0, 4
  la $a0, equal
  syscall
  
  li $v0, 1
  add $a0, $zero, $t1
  syscall








 

   


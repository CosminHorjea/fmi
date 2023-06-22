#Lab6:1
.data
	n: .word 0
	l1: .word 0
	l2: .word 0
	matrix: .space 128
	sir1: .asciiz "Introduceti lungimea laturii matricii:\n"	
	sir2: .asciiz "Introduceti prima valoare a liniei:\n"
	sir3: .asciiz "Introduceti a 2-a valoare a liniei:\n"
	sir4: .asciiz "Introduceti valorile matricii:\n"
	sir5: .asciiz " "
	sir6: .asciiz "\n"
.text
function:
la $t0, matrix
li $t1, 0
sub $t5, $s1, 1
mulo $t5, $t5, $s0
loop1:
beq $t1, $t5, end_loop1
addi $t1, 1
addi $t0, 4
b loop1
end_loop1:
la $t2, matrix
li $t1, 0
sub $t6, $s2, 1
mulo $t6, $t6, $s0
loop2:
beq $t1, $t6, end_loop2
addi $t1, 1
addi $t2, 4
b loop2
end_loop2:
li $t1, 0
loop3:
beq $t1, $s0, end_loop3
addi $t1, 1
lw $t3, ($t0)
lw $t4, ($t2)
sw $t3, ($t2)
sw $t4, ($t0)
addi $t0, 4
addi $t2, 4
b loop3
end_loop3:
jr $ra
main:
li $v0, 4
la $a0, sir1
syscall
li $v0, 5
syscall
sw $v0, n
lw $s0, n
li $v0, 4
la $a0, sir2
syscall
li $v0, 5
syscall
sw $v0, l1
lw $s1, l1
li $v0, 4
la $a0, sir3
syscall
li $v0, 5
syscall
sw $v0, l2
lw $s2, l2
li $v0, 4
la $a0, sir4
syscall
mulo $s3, $s0, $s0
la $s4, matrix
li $s5, 0
for:
beq $s5, $s3, end_for
addi $s5, 1
li $v0, 5
syscall
sw $v0, ($s4)
addi $s4, 4
b for
end_for:
jal function
move $t7, $s0
la $s4, matrix
li $s5, 0
for2:
beq $s5, $s3, end_for2
addi $s5, 1
lw $s6, ($s4)
li $v0, 1
move $a0, $s6
syscall
li $v0, 4
la $a0, sir5
syscall
addi $s4, 4
bne $s5, $s0 aici
li $v0, 4
la $a0, sir6
syscall
add $s0, $s0, $t7
aici:
b for2
end_for2:
li $v0, 10
syscall

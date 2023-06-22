#Lab6:2
.data
	n: .word 0
	p: .word 0
	tablou: .space 128
	sir1: .asciiz "Introduceti numarul de elemente al tabloului:\n"
	sir2: .asciiz "Introduceti elementele tabloului:\n"
	sir3: .asciiz "Introduceti valoarea lui 'p':\n"
	sir4: .asciiz "Suma puterilor este:\n"
.text
functie:
move $t0, $s4
li $t1, 1
lw $t2, p
for2:
beq $t1, $t2, end_for2
addi $t1, 1
mulo $v0, $t0, $t0
b for2
end_for2:
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
la $a0, sir3
syscall
li $v0, 5
syscall
sw $v0, p
lw $s1, p
li $s2, 0
li $s5, 0
la $s3, tablou
li $v0, 4
la $a0, sir2
syscall
for:
beq $s2, $s0, end_for
addi $s2, 1
li $v0, 5
syscall
sw $v0, ($s3)
lw $s4, ($s3)
addi $s3, 4
jal functie

add $s5, $s5, $v0
b for
end_for:
li $v0, 1
move $a0, $s5
syscall
li $v0, 10
syscall

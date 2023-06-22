#Lab6:3
.data
	n: .word 0
	string: .asciiz ""
	sir1: .asciiz "Introduceti numarul de caractere ce urmeaza a fi citite:\n"
	sir2: .asciiz "Introduceti sirul de la tastatura:\n"
	sir3: .asciiz "\n"
	x: .byte 'a'
	y: .byte 'A'
.text
prelucrare:
lw $t0, n
li $t1, 0
for:
beq $t1, $t0, end_for
addi $t1, 1
lb $t2, ($s1)
lb $t3, x
lb $t4, y
beq $t2, $t3, aaa
beq $t2, $t4, AAA
b here
aaa:
sb $t4, ($s1)
b here
AAA:
sb $t3, ($s1)
here:
addi $s1, 1
b for
end_for:
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
li $v0, 8
la $a0, string
move $a1, $s0
addi $a1, 1
syscall
la $s1, string
jal prelucrare 
li $v0, 4
la $a0, sir3
syscall
li $v0, 4
la $a0, string
syscall
li $v0, 10
syscall	
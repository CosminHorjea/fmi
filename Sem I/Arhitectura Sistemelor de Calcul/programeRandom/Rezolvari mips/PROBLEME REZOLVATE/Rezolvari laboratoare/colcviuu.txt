#Lab6:3
.data
	n: .word 0
	string: .asciiz ""
	sir1: .asciiz "Introduceti numarul de caractere ce urmeaza a fi citite:\n"
	sir2: .asciiz "Introduceti sirul de la tastatura:\n"
	sir3: .asciiz "\n"
.text

pozMax:
lw $t0, n
li $t1, 0
lb $t3,($s1)

for:
beq $t1, $t0, end_for
addi $t1, 1
lb $t2, ($s1)

bgt $t2, $t3, actualizeaza
b here

actualizeaza:
move $t4,$t2
move $t2,$t3
move $t3,$t4
sb $t3,0($t4)

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
j pozMax 
li $v0, 4
la $a0, sir3
syscall



li $v0, 5
move $a0,$t3
syscall

li $v0, 10
syscall	
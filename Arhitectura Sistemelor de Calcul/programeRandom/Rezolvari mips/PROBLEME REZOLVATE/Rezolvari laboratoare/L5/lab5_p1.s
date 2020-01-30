#Lab5: 1
.data
sir: .asciiz "anaaremere"
revsir: .space 100
space: .asciiz "\n"
.text
main:

adaugareInStiva:
lb $a0,sir($t2)
subu $sp, $sp, 4
sw $a0, 0($sp)

addiu $t2,$t2,1
bnez $a0,adaugareInStiva

addu $sp, $sp, 4
subu $t0,$t2,1
li $t2 0
extragereDinStiva:
lw $a0, 0($sp) #load in registru a valorii de la adresa din varful stivei
sb $a0,revsir($t2)
addu $sp, $sp, 4
addu $t2,$t2,1
blt $t2,$t0,extragereDinStiva

li $a0,0
sb $a0,revsir($t2)#caracterul null

la $a0,revsir
li $v0,4
syscall

li $v0,10
syscall










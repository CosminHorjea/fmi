#Lab5: 2
.data
numar: .word 432234
space: .asciiz "\n"
nu: .asciiz "NU"
da: .asciiz "DA"
.text

main:

lw $t0 , numar
move $t3,$t0
li $t1,10
li $t2,0

loop:
add $t2,$t2,1
div $t0,$t1
mflo $t0
mfhi $a0
jal adaugareInStiva
bnez $t0,loop

numberRev:
jal preluareDinStiva
#a0->cifra din stiva
#t3->numaru
div $t3,$t1
mflo $t3
mfhi $t4
#t4->cifra acc
bne $a0,$t4,nonPal
add $t2,$t2,-1
bnez $t2,numberRev
j Pal
#apelaeaza PAL

li $v0,10
syscall

adaugareInStiva:
subu $sp, $sp, 4
sw $a0 ,0($sp)
jr $ra

preluareDinStiva:
lw $a0 ,0($sp)
addu $sp, $sp, 4 
jr $ra

nonPal:
la $a0,nu
li $v0,4
syscall
li$v0,10
syscall

Pal:
la $a0,da
li $v0,4
syscall
li$v0,10
syscall